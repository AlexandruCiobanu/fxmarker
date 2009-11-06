/**
* Gold Parser engine.
* See more details on http://www.devincook.com/goldparser/
* 
* Original code is written in VB by Devin Cook (GOLDParser@DevinCook.com)
*
* This translation is done by Reggie Wilbanks (GOLDParser@sc8pe.com) 
* 
* The translation is based on the other engine translations:
* C# engine by Vladimir Morozov (vmoroz@hotmail.com)
* Delphi engine by Alexandre Rai (riccio@gmx.at)
* C# engine by Marcus Klimstra (klimstra@home.nl)
*/
package com.sc8pe.parsers.gold.engine
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	[Event(name="complete", type="flash.events.Event")]

	/**
	 * Pull parser which uses Grammar table to parse the input stream.
	 */	
	public class Parser extends EventDispatcher
	{

		// PRIVATES //
		
		private var _grammar:Grammar; 		// Grammar of parsed language.
		private var _sourceData:Array;		// The input data to parse.
		private var _sourceDataIndex:int;	// The read index.
		private var _buffer:Array;	 		// Buffer to keep current characters.
		private var _bufferSize:int; 		// Size of the buffer. 
		private var _bufferStartIndex:int;	// Absolute position of buffered first character.
		private var _charIndex:int;			// Index of character in the buffer.
		private var _preserveChars:int;		// Number of characters to preserve when the buffer is refilled.
		private var _lineStart:int;			// Relative position of line start to the buffer beginning.
		private var _lineLength:int;		// Length of current source line.
		private var _lineNumber:int = 1;	// Current line number.
		private var _commentLevel:int; 		// Keeps stack level for embedded comments.
		private var _commentText:String;	// Current comment text.
		private var _token:Token; 			// Current Token.
		private var _inputTokens:Array; 	// Stack of input tokens.
		private var _inputTokenCount:int 	// The number of tokens in the input.
		private var _lrStack:Array;			// Stack of LR states used for LR parsing.
		private var _lrStackIndex:int;		// Index of the current LR state in the LR parsing stack.
		private var _lrState:LRState; 		// Current LR state.
		private var _reductionCount:int; 	// Number of items in reduction. It is Undefined if no reduction is available.
		private var _expectedTokens:Array;	// The tokens expected in case of an error.
		
		private const MINIMUM_BUFFER_SIZE:int = 4096; 					// Minimum size of the char buffer.
		private const END_OF_STRING:String = String.fromCharCode(0);	// Designates the last string terminator.
		private const MINIMUM_INPUT_TOKEN_COUNT:int = 2;				// Minimum input token stack size.
		private const MINIMUM_LR_STACK_SIZE:int = 256;					// Minimum size of reduction stack.
		private const UNDEFINED:int = -1;								// Used for undefined int values.
		
		// SIMPLE PROPERTIES //
		
		public var trimReductions:Boolean = true;	// Allows the minimization of the reduction tree.
		public var SourceReadCallback:Function; 	// Called when line reading is finished.
		
		// PUBLIC FUNCTIONS //
		
		/**
		 * Initializes a new instance of the <code>Parser</code> class.
		 * 
		 * @param input The input string to parse.
		 * @param grammar The grammar to parse against.
		 */
		public function Parser(data:String, grammar:Grammar) {
			var loopIndex:int; // One variable to rule them all...
			
			if (data == null) {
				dispatchEvent(FaultEvent.createEvent(new Fault("-1","The \"data\" parameter is null.")));
				return;
			}
			else if (grammar == null) {
				dispatchEvent(FaultEvent.createEvent(new Fault("-2","The \"grammar\" parameter is null.")));
				return;
			}
			
			_sourceData = data.split("");
			_sourceDataIndex = 0;
			_bufferSize = MINIMUM_BUFFER_SIZE;
			_lineLength = UNDEFINED;
			ReadBuffer();
			
			_inputTokens = new Array(MINIMUM_INPUT_TOKEN_COUNT);
			for (loopIndex = 0; loopIndex != _inputTokens.length; loopIndex++) {
				_inputTokens[loopIndex] = new Token();
			}
			_lrStack = new Array(MINIMUM_LR_STACK_SIZE);
			for (loopIndex = 0; loopIndex != _lrStack.length; loopIndex++) {
				_lrStack[loopIndex] = new LRStackItem();
			}
			
			_grammar = grammar;
			
			// Put the grammar start symbol into the LR parsing stack.
			_lrState = _grammar.InitialLRState;
			var start:LRStackItem = new LRStackItem();
			start._token._symbol = _grammar.StartSymbol;
			start._state = _lrState;
			_lrStack[_lrStackIndex] = start;
			_reductionCount = UNDEFINED;
			_token = new Token();
		}

		/**
		 * Get the parser's grammar.
		 */
		public function get grammar():Grammar {
			return _grammar;	
		}
		
		/**
		 * Get the source input.
		 */
		public function get SourceData():String {
			return _sourceData.toString();
		}

		/**
		 * Get the current character position.
		 */
		public function get CharPosition():int {
			return _charIndex + _bufferStartIndex;
		}
		
		/**
		 * Get the current (1-based) line number.
		 */
		public function get LineNumber():int {
			return _lineNumber;
		}
		
		/**
		 * Get the current (1-based) position in the current source line.
		 */
		public function get LinePosition():int {
			return CharPosition - _lineStart + 1;
		}
		 
		/**
		 * Get the current source line text. It may be truncated if the line is longer than 2048 characters.
		 */
		public function get LineText():String {
			var lineStart:int = Math.max(_lineStart,0);
			var lineLength:int;
			if (_lineLength == UNDEFINED) {
				lineLength = _charIndex - lineStart;
			}
			else {
				lineLength = _lineLength - (lineStart - _lineStart);
			}
			if (lineLength > 0) {
				return _buffer.slice(lineStart,lineStart+lineLength).toString();
			}
			return "";
		}
		
		private function ReadBuffer():int {
			// Find out how many bytes to preserve.
			// We truncate long lines.
			
			var lineStart:int = (_lineStart < 0) ? 0 : _lineStart;
			var lineCharCount:int = _charIndex - lineStart;
			if (lineCharCount > Math.floor(_bufferSize / 2)) {
				lineCharCount = Math.floor(_bufferSize / 2);
			}

			var moveIndex:int = _charIndex - lineCharCount;
			var moveCount:int = lineCharCount + _preserveChars;
			if (moveCount > 0) {
				// We need to keep current token characters.
				if (_bufferSize - moveCount < 20) {
					// Grow the buffer
					_bufferSize = _bufferSize * 2;
					var newBuffer:Array = new Array(_bufferSize + 1);
					_buffer = _buffer.concat(newBuffer);
				}
				else
				{
					_buffer = _buffer.slice(moveIndex,moveIndex+moveCount);
				}
			}
	
			// Read as many characters as possible.
			var count:int = _bufferSize - moveCount;
			var newBufferData:Array = _sourceData.slice(_sourceDataIndex,_sourceDataIndex + count);
			_sourceDataIndex += count;
			if (_buffer == null) {
				_buffer = newBufferData;
			}
			else {
				_buffer = _buffer.concat(newBufferData);
			}
			_buffer.splice(_buffer.length,0,END_OF_STRING);

			// Adjust buffer variables.
			_bufferStartIndex += moveIndex;
			_charIndex -= moveIndex;
			_lineStart -= moveIndex;

			return newBufferData.length;
		}

		/*
		 * Increments current char index by delta character positions.
		 * 
		 * @param delta Number to increment char index.
		 */
		private function MoveBy(delta:int):void {
			for (var i:int = delta; --i >= 0;) {
				if (_buffer[_charIndex++] == "\n") {
					if (SourceReadCallback != null) {
						_lineLength = _charIndex - _lineStart - 1; // Exclude '\n'
						var lastIndex:int = _lineStart + _lineLength - 1;
						if (lastIndex >= 0 && _buffer[lastIndex] == "\r") {
							_lineLength--;
						}
						if (_lineLength < 0) {
							_lineLength = 0;
						}
						SourceReadCallback(this, _lineStart + _bufferStartIndex, _lineLength);
					}
					_lineNumber++;
					_lineStart = _charIndex;
					_lineLength = UNDEFINED;
				}
				if (_buffer[_charIndex] == '\0') {
					if (SourceReadCallback != null) {
						_lineLength = _charIndex - _lineStart; 
						if (_lineLength > 0) {
							SourceReadCallback(this, _lineStart + _bufferStartIndex, _lineLength);
						}
						_lineLength = UNDEFINED;
					}
				}
			}
		}
		
		/*
		 * Moves current char pointer to the end of source line.
		 */
		private function MoveToLineEnd():void {
			while (true) {
				switch (_buffer[_charIndex]) {
					case "\r":
					case "\n":
						return;
					case END_OF_STRING:
						if (ReadBuffer() == 0) {
							return;
						}
						break;
					default:
						if (_commentText != null) {
							_commentText += _buffer[_charIndex];
						}
						break;
				}
				_charIndex++;
			}
		}
		
		/**
		 * Get the current token symbol.
		 */
		public function get TokenSymbol():Symbol {
			return _token._symbol;
		}
		
		/**
		 * Set the current token symbol.
		 */
		public function set TokenSymbol(value:Symbol):void {
			_token._symbol = value;
		}
		
		/**
		 * Get the current token text.
		 */
		public function get TokenText():String {
			if (_token._text == null) {
				if (_token._length > 0) {
					_token._text = _buffer.slice(_token._start - _bufferStartIndex,(_token._start - _bufferStartIndex) + _token._length).toString();
				}
				else {
					_token._text = "";
				}
			}
			return _token._text; 			
		}
		
		/**
		 * Set the current tokent text.
		 */
		public function set TokenText(value:String):void {
			_token._text = value;
		}
		
		
		/**
		 * Get the current token position relative to the input stream beginning.
		 */
		public function get TokenCharPosition():int {
			return _token._start;
		}
		
		/**
		 * Set the current token position relative to the input stream beginning.
		 */
		public function set TokenCharPosition(value:int):void {
			_token._start = value;
		}

		/**
		 * Get the current token text length.
		 */
		public function get TokenLength():int {
			return _token._length;
		}
		
		/**
		 * Set the current token text length.
		 */
		public function set TokenLength(value:int):void {
			_token._length = value;
		}
		
		/**
		 * Get the current token line number. It is 1-based.
		 */
		public function get TokenLineNumber():int {
			return _token._lineNumber;
		}
		
		/**
		 * Set the current token line number. It is 1-based.
		 */
		public function set TokenLineNumber(value:int):void {
			_token._lineNumber = value;
		}
		
		/**
		 * Get the current token position in current source line. It is 1-based.
		 */
		public function get TokenLinePosition():int {
			return _token._linePosition;
		}
		
		/**
		 * Set the current token position in current source line. It is 1-based.
		 */
		public function set TokenLinePosition(value:int):void {
			_token._linePosition = value;
		}
		
		/**
		 * Get the token syntax object associated with the current token or reduction.
		 */
		public function get TokenSyntaxNode():Object {
			if (_reductionCount == UNDEFINED) {
				return _token._syntaxNode; 
			}
			else {
				return _lrStack[_lrStackIndex]._token._syntaxNode;
			}
		}
		
		/**
		 * Set the token syntax object associated with the current token or reduction.
		 */
		public function set TokenSyntaxNode(value:Object):void {
			if (_reductionCount == UNDEFINED) {
				_token._syntaxNode = value;
			}
			else {
				_lrStack[_lrStackIndex]._token._syntaxNode = value;
			}
		}
		
		/**
		 * Get the string representation of the token.
		 */
		public function get TokenString():String {
			if (_token._symbol._symbolType != SymbolType.TERMINAL) {
				return _token._symbol.toString();
			}
			var sb:String = "";
			for (var i:int = 0; i < _token._length; i++) {
				var ch:String = _buffer[_token._start - _bufferStartIndex + i];
				if (ch.charCodeAt(0) < String(" ").charCodeAt(0)) {
					switch (ch) {
						case "\n": 
							sb += "{LF}";
							break;
						case "\r": 
							sb += "{CR}";
							break;
						case "\t": 
							sb += "{HT}";
							break;
					}
				}
				else {
					sb += ch;
				}
			}
			return sb;
		}

		/**
		 * Pushes a token to the input token stack.
		 * 
		 * @param symbol Token symbol
		 * @param text Token text
		 * @param syntaxNode Syntax node associated with the token.
		 */
		public function PushInputToken(symbol:Symbol, text:String, syntaxNode:Object):void {
			if (_token._symbol != null) {
				if (_inputTokenCount == _inputTokens.length) {
					var newTokenArray:Array = new Array(_inputTokenCount * 2);
					_inputTokens = _inputTokens.concat(newTokenArray);
				}
				_inputTokens[_inputTokenCount++] = _token;
			}
			_token = new Token();
			_token._symbol = symbol;
			_token._text = text;
			_token._length = (text != null) ? text.length : 0;
			_token._syntaxNode = syntaxNode;
		}
		
		/**
		 * Pops a token from the input token stack.
		 * 
		 * @returns The token symbol from the top of input token stack.
		 */
		public function PopInputToken():Symbol {
			var result:Symbol = _token._symbol;
			
			if (_inputTokenCount > 0) {
				_token = _inputTokens[--_inputTokenCount];
			}
			else {
				_token._symbol = null;
				_token._text = null;
			}
			return result;
		}

		/**
		 * Reads the next token from the input stream.
		 * 
		 * @returns The token symbol which was read.
		 */
		public function ReadToken():Symbol {
			_token._text = null;
			_token._start = _charIndex + _bufferStartIndex;
			_token._lineNumber = _lineNumber;
			_token._linePosition = _charIndex + _bufferStartIndex - _lineStart + 1;
			var lookahead:int = _charIndex;  // Next look ahead char in the input
			var tokenLength:int = 0;       
			var tokenSymbol:Symbol = null;
			var dfaStateTable:Dictionary = _grammar.m_dfaStateTable;
			
			var ch:String = _buffer[lookahead];
			if (ch == END_OF_STRING) {
				if (ReadBuffer() == 0) {
					_token._symbol = _grammar.m_endSymbol;
					_token._length = 0;
					return _token._symbol;
				}
				lookahead = _charIndex;
				ch = _buffer[lookahead];
			}
			var dfaState:DfaState = _grammar.m_dfaInitialState;
			while (true) {
				dfaState = dfaState._transitionVector.getItemAt(ch.charCodeAt(0)) as DfaState;

				// This block-if statement checks whether an edge was found from the current state.
				// If so, the state and current position advance. Otherwise it is time to exit the main loop
				// and report the token found (if there was it fact one). If the LastAcceptState is -1,
				// then we never found a match and the Error Token is created. Otherwise, a new token
				// is created using the Symbol in the Accept State and all the characters that
				// comprise it.
				if (dfaState != null) {
					// This code checks whether the target state accepts a token. If so, it sets the
					// appropiate variables so when the algorithm in done, it can return the proper
					// token and number of characters.
					lookahead++;
					if (dfaState._acceptSymbol != null) {
						tokenSymbol = dfaState._acceptSymbol;
						tokenLength = lookahead - _charIndex;
					}
					ch = _buffer[lookahead];
					if (ch == END_OF_STRING) {
						_preserveChars = lookahead - _charIndex;
						if (ReadBuffer() == 0) {
							// Found end of of stream
							lookahead = _charIndex + _preserveChars;
						}
						else {
							lookahead = _charIndex + _preserveChars;
							ch = _buffer[lookahead];
						}
						_preserveChars = 0;
					}
				}
				else {
					if (tokenSymbol != null) {
						_token._symbol = tokenSymbol;
						_token._length = tokenLength;
						MoveBy(tokenLength);
					}
					else {
						//Tokenizer cannot recognize symbol
						_token._symbol = _grammar.m_errorSymbol;
						_token._length = 1;
						MoveBy(1);
					}        
					break;
				}
			}
			return _token._symbol;
		}
		
		/**
		 * Removes the current token and pops next token from the input stack.
		 */
		private function DiscardInputToken():void {
			if (_inputTokenCount > 0) {
				_token = _inputTokens[--_inputTokenCount];
			}
			else {
				_token._symbol = null;
				_token._text = null;
			}
		}
		
		/**
		 * Get the current LR state.
		 */
		public function get CurrentLRState():LRState {
			return _lrState;
		}
		
		/**
		 * Get the current reduction syntax rule.
		 */
		public function get ReductionRule():Rule {
			return _lrStack[_lrStackIndex]._rule;
		}

		/**
		 * Get the number of items in the current reduction.
		 */
		public function get ReductionCount():int {
			return _reductionCount;
		}
		
		/**
		 * Gets reduction item syntax object by its index.
		 * 
		 * @param index Index of reduction item.
		 * @returns Syntax object attached to reduction item.
		 */
		public function GetReductionSyntaxNode(index:int):Object
		{
			if (index < 0 || index >= _reductionCount) {
			//todo:	throw new IndexOutOfRangeException();
			}
			return _lrStack[_lrStackIndex - _reductionCount + index]._token._syntaxNode;
		}
		
		/**
		 * Get the array of expected token symbols.
		 */
		public function get GetExpectedTokens():Array {
			return _expectedTokens;
		}

		/**
		 * Executes next step of parser and returns parser state.
		 * 
		 * @returns The current state of the parser.
		 */
		public function Parse():ParseMessage {
			if (_token._symbol != null) {
				switch (_token._symbol._symbolType) {
					case SymbolType.COMMENT_LINE:
						DiscardInputToken(); //Remove it 
						MoveToLineEnd();
						break;
					case SymbolType.COMMENT_START:
						ProcessBlockComment();
						break;
				}
			}
			while (true) {
				if (_token._symbol == null) {
					//We must read a token
					var readTokenSymbol:Symbol = ReadToken();
					var symbolType:SymbolType = readTokenSymbol._symbolType;					
					if (_commentLevel == 0 
						&& symbolType != SymbolType.COMMENT_LINE
						&& symbolType != SymbolType.COMMENT_START
						&& symbolType != SymbolType.WHITESPACE) {
						return ParseMessage.TOKEN_READ;
					}
				}
				else {
					//==== Normal parse mode - we have a token and we are not in comment mode
					switch (_token._symbol._symbolType) {
						case SymbolType.WHITESPACE:
							DiscardInputToken();  // Discard Whitespace
							break;
						case SymbolType.COMMENT_START:
							_commentLevel = 1; // Switch to block comment mode.
							return ParseMessage.COMMENT_BLOCK_READ;
						case SymbolType.COMMENT_LINE:
							return ParseMessage.COMMENT_LINE_READ;
						case SymbolType.ERROR:
							return ParseMessage.LEXICAL_ERROR;
						default:
							//Finally, we can parse the token
							switch (ParseToken()) {
								case TokenParseResult.Accept:
									return ParseMessage.ACCEPT;
								case TokenParseResult.InternalError:
									return ParseMessage.INTERNAL_ERROR;
								case TokenParseResult.ReduceNormal:
									return ParseMessage.REDUCTION;
								case TokenParseResult.Shift: 
									//A simple shift, we must continue
									DiscardInputToken(); // Okay, remove the top token, it is on the stack
									break;
								case TokenParseResult.SyntaxError:
									return ParseMessage.SYNTAX_ERROR;
								default:
									//Do nothing
									break;
							}
							break;
					}
				}
			}
			// Should never get here
			return ParseMessage.INTERNAL_ERROR;
		}

		/*
		 * Processes a block comment.
		 */
		private function ProcessBlockComment():void {
			if (_commentLevel > 0) {
				if (_commentText != null) {
					_commentText += TokenText;
				}
				DiscardInputToken();
				while (true) {
					var symbolType:SymbolType = ReadToken().symbolType;
					if (_commentText != null) {
						_commentText += TokenText;
					}
					DiscardInputToken();
					switch (symbolType) {
						case SymbolType.COMMENT_START: 
							_commentLevel++;
							break;
						case SymbolType.COMMENT_END: 
							_commentLevel--;
							if (_commentLevel == 0) {
								// Done with comment.
								return;
							}
							break;
						case SymbolType.END:
							//TODO: replace with special exception.
							//throw new Exception("CommentError");
						default:
							//Do nothing, ignore
							//The 'comment line' symbol is ignored as well
							break;
					}
				}
			}
		}

		/*
		 * Get the current comment text
		 */
		private function get CommentText():String {
			if (_token._symbol != null) {
				switch (_token._symbol._symbolType) {
					case SymbolType.COMMENT_LINE:
						_commentText = TokenText;
						DiscardInputToken(); //Remove token 
						MoveToLineEnd();
						var lineComment:String = _commentText;
						_commentText = null;
						return lineComment;
					case SymbolType.COMMENT_START:
						_commentText = "";
						ProcessBlockComment(); 
						var blockComment:String = _commentText;
						_commentText = null;
						return blockComment;
				}
			}
			return "";
		}

		/*
		 * Parse a token.
		 */
		private function ParseToken():int {
			var stateAction:LRStateAction = _lrState._transitionVector[_token._symbol._index];
			
			if (stateAction != null) {
				// Work - shift or reduce
				if (_reductionCount > 0) {
					var newIndex:int = _lrStackIndex - _reductionCount;
					_lrStack[newIndex] = _lrStack[_lrStackIndex];
					_lrStackIndex = newIndex;
				}
				_reductionCount = UNDEFINED;
				switch (stateAction.Action) {
					case LRAction.ACCEPT:
						_reductionCount = 0;
						return TokenParseResult.Accept;
					case LRAction.SHIFT:
						_lrState = _grammar.m_lrStateTable[stateAction.Value];
						var nextToken:LRStackItem = new LRStackItem();
						nextToken._token = _token.clone();
						nextToken._state = _lrState;
						if (_lrStack.Length == ++_lrStackIndex) {
							_lrStack = _lrStack.concat(new Array(MINIMUM_LR_STACK_SIZE));
						}
						_lrStack[_lrStackIndex] = nextToken;
						return TokenParseResult.Shift;
					case LRAction.REDUCE:
						// Produce a reduction - remove as many tokens as members in the rule & push a nonterminal token
						var ruleIndex:int = stateAction.Value;
						var currentRule:Rule = _grammar.m_ruleTable[ruleIndex];
						// ======== Create Reduction
						var head:LRStackItem;
						var parseResult:int;
						var nextState:LRState;
						if (trimReductions && currentRule._containsOneNonTerminal)  {
							// The current rule only consists of a single nonterminal and can be trimmed from the
							// parse tree. Usually we create a new Reduction, assign it to the Data property
							// of Head and push it on the stack. However, in this case, the Data property of the
							// Head will be assigned the Data property of the reduced token (i.e. the only one
							// on the stack).
							// In this case, to save code, the value popped of the stack is changed into the head.
							head = _lrStack[_lrStackIndex];
							head._token._symbol = currentRule._nonTerminal;
							head._token._text = null;
							parseResult = TokenParseResult.ReduceEliminated;
							// ========== Goto
							nextState = _lrStack[_lrStackIndex - 1]._state;
						}
						else {
							// Build a Reduction
							head = new LRStackItem();
							head._rule = currentRule;
							head._token._symbol = currentRule._nonTerminal;
							head._token._text = null;
							_reductionCount = currentRule._symbols.length;
							parseResult = TokenParseResult.ReduceNormal;
							// ========== Goto
							nextState = _lrStack[_lrStackIndex - _reductionCount]._state;
						}
						//========= If nextAction is null here, then we have an Internal Table Error!!!!
						var nextAction:LRStateAction = nextState._transitionVector[currentRule._nonTerminal._index];
						if (nextAction != null) {
							_lrState = _grammar.m_lrStateTable[nextAction.Value];
							head._state = _lrState;
							if (parseResult == TokenParseResult.ReduceNormal) {
								if (_lrStack.Length == ++_lrStackIndex) {
									_lrStack = _lrStack.concat(new Array(MINIMUM_LR_STACK_SIZE));
								}
								_lrStack[_lrStackIndex] = head;
							}
							else {
								_lrStack[_lrStackIndex] = head;
							}
							return parseResult;
						}
						else {
							return TokenParseResult.InternalError;
						}
				}
			}

			// === Syntax Error! Fill Expected Tokens
			_expectedTokens = new Array(_lrState.ActionCount); //TODO: WTF?
			var length:int = 0;
			for (var i:int = 0; i < _lrState.ActionCount; i++) {
				switch (_lrState.GetAction(i).symbol.symbolType) {
					case SymbolType.TERMINAL:
					case SymbolType.END:
						_expectedTokens[length++] = _lrState.GetAction(i).symbol;
						break;
				}
			}
			if (length < _expectedTokens.Length) {
				_expectedTokens = _expectedTokens.concat(new Array(length));
			}
			return TokenParseResult.SyntaxError;
		}
	}
	
}

import com.sc8pe.parsers.gold.engine.LRState;
import com.sc8pe.parsers.gold.engine.Rule;
import com.sc8pe.parsers.gold.engine.Symbol;

/*
 * Result of the parsing token.
 */
class TokenParseResult {
	public static const Empty:int 				= 0;
	public static const Accept:int 				= 1;
	public static const Shift:int 				= 2;
	public static const ReduceNormal:int		= 3;
	public static const ReduceEliminated:int 	= 4;
	public static const SyntaxError:int 		= 5;
	public static const InternalError:int 		= 6;
}

/*
 * Represents data about the current token.
 */
class Token {
	internal var _symbol:Symbol;		// Token Symbol.
	internal var _text:String; 			// Token text.
	internal var _start:int;			// Token start stream start.
	internal var _length:int;			// Token length.
	internal var _lineNumber:int;		// Token source line number (1-based).
	internal var _linePosition:int;		// Token position in source line (1-based).
	internal var _syntaxNode:Object;	// Syntax node which can be attached to the token.
	
	internal function clone():Token {
		var clone:Token = new Token();
		clone._symbol = new Symbol(this._symbol.Index,this._symbol.Name, this._symbol.symbolType);
		clone._text = this._text;
		clone._start = this._start;
		clone._length = this._length;
		clone._lineNumber = this._lineNumber;
		clone._linePosition = this._linePosition;
		clone._syntaxNode = this._syntaxNode;
		return clone;	
	}
}

/*
 * Represents an item in the LR parsing stack.
 */
class LRStackItem {
	internal var _token:Token;
	internal var _state:LRState;
	internal var _rule:Rule;
	
	public function LRStackItem() {
		_token = new Token();
	}	
}
