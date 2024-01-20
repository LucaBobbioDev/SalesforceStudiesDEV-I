@IsTest
public with sharing class AddPrimaryContactTest {
    @TestSetup
    static void makeData(){
        List<Account> accountsNY = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accountsNY.add(new Account(Name = 'Account NY ' + i, BillingState = 'NY'));
        }
        insert accountsNY;

        List<Account> accountsCA = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accountsCA.add(new Account(Name = 'Account CA ' + i, BillingState = 'CA'));
        }
        insert accountsCA;

        Contact testContact = new Contact(FirstName = 'John', LastName = 'Doe');
        insert testContact;
    }

    static testmethod void testQueueable() {
        Contact testContact = [SELECT Id, FirstName, LastName FROM Contact LIMIT 1 ];
        AddPrimaryContact addContactJob = new AddPrimaryContact(testContact, 'CA');

        Test.startTest();
            System.enqueueJob(addContactJob);
        Test.stopTest();

        List<Contact> insertedContacts = [
            SELECT Id, Account.BillingState 
            FROM Contact 
            WHERE Account.BillingState = 'CA'
        ];

        System.assertEquals(50, insertedContacts.size());
    }
}