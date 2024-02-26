@IsTest
private class DataGenerationTests {
    @TestSetup
    static void dataCreation() {
        Account a = TestFactory.getAccount('Muddy Waters Inc.', true);
        Contact c = TestFactory.getContact(a.id, 'Muddy', 'Waters', true);

        Opportunity opp = New Opportunity();
        opp.name = 'Long lost record';
        opp.accountId = a.id;
        opp.closeDate = Date.today().addDays(14);
        opp.stageName = 'prospecting';

        insert opp;
    }
    @IsTest
    static void testBruteForceAccountCreation() {
        List<Account> accts;
        Account a = new Account(name='McTesterson LLC');
        Test.startTest();
            insert a;
            accts = [SELECT Id FROM Account];
        Test.stopTest();
        Assert.isTrue(accts.size() > 0, 'Was expecting to find at least one account');
    }

    @IsTest
    static void testUseTestFactoryToCreateAccountsWithContacts() {
        List<Account> accts;
        List<Contact> contacts;
        TestFactory.generateAccountWithContacts(5);

        Test.startTest();
            accts = [SELECT Id FROM Account];
            contacts = [SELECT Id FROM Contact];
        Test.stopTest();

        Assert.isTrue(accts.size() > 0, 'Was expecting to find at least one account');
        Assert.areEqual(5, contacts.size(), 'Was expecting to find 5 contacts');
    }
}