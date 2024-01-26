@IsTest
public with sharing class AccountManagerTest {
    @IsTest
    static void testGetAccount(){
        Id recordId = createTestRecord();

        Contact testContact = new Contact(AccountId = recordId, LastName = 'Test Contact');
        insert testContact;

        RestRequest request = new RestRequest();
        request.requestUri = 'https://NA233.my.salesforce.com/services/apexrest//Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
    }

    static Id createTestRecord() {
        Account accountTest = new Account(Name = 'Test Account');
        insert accountTest;
        return accountTest.Id;
    }        
}