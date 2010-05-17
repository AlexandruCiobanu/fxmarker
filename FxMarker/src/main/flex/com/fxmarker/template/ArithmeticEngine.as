package com.fxmarker.template 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ArithmeticEngine
	{
		
		public function ArithmeticEngine() { }
		
		public function add(a : Number, b : Number) : Number {
			return a + b;
		}
		
		public function substract(a : Number, b : Number) : Number {
			return a - b;
		}
		
		public function divide(a : Number, b : Number) : Number {
			return a / b;
		}
		
		public function multiply(a : Number, b : Number) : Number {
			return a * b;
		}
		
		public function modulus(a : Number, b : Number) : Number {
			return a % b;
		}
		
		public function pow(a : Number, b : Number) : Number {
			return a ^ b;
		}		
	}
}