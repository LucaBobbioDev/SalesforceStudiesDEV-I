@IsTest
private class AwsomeCalculatorTest {
    @IsTest 
    static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock());

        Double x = 1.0;
        Double y = 2.0;
        Double result = AwsomeCalculator.add(x, y);

        System.assertEquals(3.0, result); 
    }
}