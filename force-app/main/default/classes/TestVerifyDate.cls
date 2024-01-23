@IsTest
public with sharing class TestVerifyDate {
    @IsTest
    public static void testDateWithin30Days() {
        Date currentDateWithin30Days = Date.today();
        Date dateWithin30Days = currentDateWithin30Days.addDays(15);
        Date currentDateNotWithin30Days = Date.today();
        Date dateNotWithin30Days = currentDateNotWithin30Days.addDays(-40);

        Test.startTest();
        	Date resultDateWithin30Days = VerifyDate.CheckDates(currentDateWithin30Days, dateWithin30Days);
            Date resultDateNotWithin30Days = VerifyDate.CheckDates(currentDateNotWithin30Days, dateNotWithin30Days);
        Test.stopTest();
        
        System.assertEquals(dateWithin30Days, resultDateWithin30Days);
        System.assertNotEquals(dateNotWithin30Days, resultDateNotWithin30Days);
    }
    
    @IsTest
    public static void testSetEndOfMonthDate() {
        Date currentDateNotWithin30Days = Date.today();
        Date dateNotWithin30Days = currentDateNotWithin30Days.addDays(40);
        
        Test.startTest();
        	Date resultDateNotWithin30Days = VerifyDate.CheckDates(currentDateNotWithin30Days, dateNotWithin30Days);
        Test.stopTest();
        
        Integer expectedDay = Date.daysInMonth(currentDateNotWithin30Days.year(), currentDateNotWithin30Days.month());
        Date expectedEndDateNotWithin30Days = Date.newInstance(currentDateNotWithin30Days.year(), currentDateNotWithin30Days.month(), expectedDay);
        System.assertEquals(expectedEndDateNotWithin30Days, resultDateNotWithin30Days);
    }
}