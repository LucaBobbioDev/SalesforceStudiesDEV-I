@IsTest
public with sharing class TestAccountDeletion {
    @IsTest static void TestDeleteAccountWithOneOpportunity() {
        Account[] accounts = TestDataFactory.createAccountsWithOpps(1,1);

        Test.startTest();
            Database.DeleteResult result = Database.delete(accounts[0], false);
        Test.stopTest();
    
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', result.getErrors()[0].getMessage());
    }

    @IsTest static void TestDeleteAccountWithNoOpportunities() {
        Account[] accounts = TestDataFactory.createAccountsWithOpps(1,0);

        Test.startTest();
            Database.DeleteResult result = Database.delete(accounts[0], false);
        Test.stopTest();

        System.assert(result.isSuccess());
    }

    @IsTest static void TestDeleteBulkAccountsWithOneOpportunity() {
        Account[] accountsList = TestDataFactory.createAccountsWithOpps(200,1);
        Test.startTest();
            Database.DeleteResult[] resultList = Database.delete(accountsList, false);
        Test.stopTest();
        for(Database.DeleteResult result : resultList) {
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Cannot delete account with related opportunities.',
                                 result.getErrors()[0].getMessage());
        }
    }
}