@IsTest
public with sharing class AnimalLocatorTest {
    @IsTest 
    static void testAnimalName() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        String actualValue = AnimalLocator.getAnimalNameById(1);
        String expectedValue = 'chicken';
        System.assertEquals(expectedValue, actualValue);   
    }

    @IsTest 
    static void testFailedAnimalName() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        String actualValue = AnimalLocator.getAnimalNameById(2);
        String expectedValue = 'bear';
        System.assertNotEquals(expectedValue, actualValue);   
    }
}