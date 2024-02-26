@IsTest
public with sharing class MyDataGenerationTests {
    @TestSetup
    static void loadTestDataFromStaticResource() {
        List<sObject> accounts = Test.loadData(Account.SObjectType, 'otherAccountData');
    }

    @IsTest
    static void testLoadOtherAccountsFromStaticResource() {
        List<Account> accts = [SELECT ID FROM Account];
        Assert.isTrue(accts.size() == 15, 'Expected 15 accounts');
    }
}