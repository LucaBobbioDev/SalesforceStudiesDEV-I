@IsTest
public with sharing class CalculatorTests {
    @IsTest
    static void testDivideByZero() {
        Integer numerator = 5;
        Integer denominator = 0;
        try {
            Calculator.divide(numerator, denominator);
        } catch (Calculator.CalculatorException e) {
            System.assertEquals('You still can\'t divide by zero', e.getMessage(), 'Incorrect exception message');
        }
    }

    @IsTest
    static void testMultiplyByZero() {
        Integer a =-10;
        Integer b = 0;
        try {
            Calculator.multiply(a, b);
        } catch (Calculator.CalculatorException e) {
            System.assertEquals('It doesn\'t make sense to multiply by zero', e.getMessage(), 'Incorrect exception message');
        }
    }
}