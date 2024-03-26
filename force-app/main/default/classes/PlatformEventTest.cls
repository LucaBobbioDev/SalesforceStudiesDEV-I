@IsTest
public class PlatformEventTest {
    @IsTest 
    static void test1() {
        Cloud_News__e newsEvent = new Cloud_News__e(
            Location__c='Mountain City',
            Urgent__c=true,
            News_Content__c='Test message.');
        Test.startTest();
            Database.SaveResult sr = EventBus.publish(newsEvent);
        Test.stopTest();
        
        System.assertEquals(true, sr.isSuccess());

        List<Case> cases = [SELECT Id FROM Case];
        System.assertEquals(1, cases.size());
    }
}