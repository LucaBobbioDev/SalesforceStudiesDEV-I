@IsTest
public with sharing class ParkLocatorTest {
    @IsTest 
    static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        String[] returnList = new String[]{
            'Hamburg Wadden Sea National Park',
            'Hainich National Park',
            'Bavarian Forest National Park'
        };
        
        List<String> resultList = ParkLocator.country('Germany');

        System.assertEquals(returnList, resultList); 
    }
}