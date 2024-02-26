@IsTest
private class CSVTests {
    @TestSetup
    static void loadTestDataFromStaticResource() {
        List<sObject> accounts = Test.loadData(Account.SObjectType, 'accountData');
    }
    @IsTest
    static void testLoadAccountsFromStaticResource() {
        List<Account> accts = [SELECT ID FROM Account];
        Assert.isTrue(accts.size() == 3, 'Expected 3 accounts');
    }
}