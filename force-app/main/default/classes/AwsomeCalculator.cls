public with sharing class AwsomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x,y);
    }
}