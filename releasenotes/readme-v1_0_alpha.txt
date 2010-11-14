/*********************************************************************************************************************************/
/**												FxMarker version 1.0 alpha (14-11-2010)				   									**/
/**													by Alex Ciobanu						   										**/
/*********************************************************************************************************************************/

Copyright 2008 - 2009 Alex Ciobanu (http://code.google.com/p/flexxb)

CONTENTS

FxMarker-1_0_alpha-14112010-bin.zip - contains the FxMarker library along with the test 
							application
			/bin/ 				 - SWC file and test application directory
			/bin/test/ 			 - the test application
			/bin/flexunit        - flexunit automated test reports
			/doc/ 				 - ASDOC
			/samples/			 - samples showing FxMarker's features 
			/README.txt			 - version release notes

FxMarker-1_0_alpha-14112010-src.zip - contains source files
			/FxMarker/	 - FxMarker project sources
			/FxMarkerTest - FxMarker test application sources

DESCRIPTION

FxMarker is a templating engine similar with the Freemarker java library. It generates text output based on templates and context objects provided as input. It is a Flex library providing content generation features to ActionScript? community.

FEATURES

	* FXK-001 - Template parsing 
	* FXK-002 - Execution directives 
	* FXK-003 - Expression parsing 
	* FXK-004 - Data model
	* FXK-005 - Data formatting 
	* FXK-006 - Template caching 

USAGE

To compile a template from a string source:
com.fxmarker.FxMarker.instance.getTemplate(source)) 

To get the canonical form of the compiled template (reverse engineer the string source from the compiled template):
template.getRootElement().getCanonicalForm() 

To populate the data model instance: 
com.fxmarker.dataModel.DataModel.putValue(name_or_dot_separated_path, value)
Value can be a regular instance or one can use the wrapper objects, implementors of com.fxmarker.dataModel.IDataItemModel 

To process the template against a data model and produce the generated content: 
var writer : com.fxmarker.writer.Writer = new com.fxmarker.writer.Writer(); 
template.process(dataModel, writer);
The generated content is accesible via writer.writtenData field.

Template execution directives

	* Interpolation: Evaluate an expression and print the result. 
	  Usage: ${expression}

	* Switch: Control flow execution via multiway branch. 
      Usage: 
      <#switch expression>
          <#case expression or constant>
             ... content       
             <#break> //optional
          <#default>
             ...content 
      </#switch>
      
    * If: You can use if, elseif and else directives to conditionally skip a section of the template. The condition-s must evaluate to a boolean value, or else an error will abort template processing. The elseif-s and else-s must occur inside if (that is, between the if start-tag and end-tag). The if can contain any number of elseif-s (including 0) and at the end optionally one else. 
      Usage: 
      <#if>
        ...content 
      <elseif>
        ...content 
      <else>
        ...content 
      </#if>
    
    * List: Process a section of template for each variable contained within a sequence. For each iteration the loop variable will contain the current subvariable. There one special loop variable available inside the list loop: item_index, a numerical value that contains the index of the current item being stepped over in the loop. 
      Usage: 
      <#list collectionName as indexName>
          ...content    
          <#break>//optional 
      </#list>
      
    * ForEach: Process a section of template for each variable contained within a sequence. For each iteration the loop variable will contain the current subvariable. There one special loop variable available inside the list loop: item_index, a numerical value that contains the index of the current item being stepped over in the loop. 
      Usage: 
      <#foreach indexName in collectionName>
          ...content    
          <#break>//optional 
      </#foreach>
      
    * CsList: Adds a comma "," after each item written to the generated content. Binds by the same execution rules as list and forEach. 
      Usage: 
      <#csList indexName in collectionName>
          ...content    
          <#break>//optional 
      </#csList>

KNOWN LIMITATIONS

None so far 

RELEASE NOTES

1.0 alpha - 14-11-2010
		  - First alpha release 