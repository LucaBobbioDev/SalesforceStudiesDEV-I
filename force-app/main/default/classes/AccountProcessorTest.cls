@IsTest
public with sharing class AccountProcessorTest {
    @IsTest
    static void testCountContacts(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con1 = new Contact(AccountId = acc.Id, LastName = 'Test Contact 1');
        Contact con2 = new Contact(AccountId = acc.Id, LastName = 'Test Contact 2');
        insert new List<Contact>{con1, con2};

        Test.startTest();
            AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();

        Account updatedAccount = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals(2, updatedAccount.Number_Of_Contacts__c, 'Number of contacts should be 2');
    }
}