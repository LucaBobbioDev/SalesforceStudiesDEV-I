@IsTest
private class AccountWrapperTests {
    @TestSetup
    static void loadTestData() {
        Account acct = new Account(Name = 'ACME');
        insert acct;
        Account acct2 = new Account(Name = 'ACME Test');
        insert acct2;

        List<Opportunity> opps = TestFactory.generateOppsForAccount(acct.id, 1000.00, 5);
        insert opps;
        List<Opportunity> opps2 = TestFactory.generateOppsForAccount(acct2.id, 3000.00, 5);
        insert opps2;
    }

    @IsTest
    static void testPositiveRoundedAveragePrice() {
        Account acct = [SELECT Id FROM Account WHERE Name = 'ACME' LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);

        Test.startTest();
        Assert.areEqual(
            1000.00,
            acctWrapper.getRoundedAvgPriceOfOpps(),
            'Expected to get 1000.00');
        Test.stopTest();
    }   

    @IsTest
    static void testIsHighPriority(){
        Account acct = [SELECT Id FROM Account WHERE Name = 'ACME Test' LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);

        Test.startTest();
            System.debug('Value =>' + acctWrapper.getRoundedAvgPriceOfOpps());
            Assert.areEqual(
                true,
                acctWrapper.isHighPriority(),
                'Expected to be true'
            );
         Test.stopTest();
    }

    @IsTest
    static void testNegativeAccountWrapperAvgPriceOfOpps() {
    // GIVEN
        Account acct = [SELECT Id FROM Account LIMIT 1];
        List<Opportunity> opps = [
            SELECT Amount
            FROM Opportunity
            WHERE accountId = :acct.Id
        ];

        for(Opportunity o : opps) {
            o.Amount = 0;
        }
        update opps;

        AccountWrapper acctWrapper = new AccountWrapper(acct);

        try {
            Test.startTest();
                acctWrapper.getRoundedAvgPriceOfOpps();
            Test.stopTest();
            Assert.fail('An exception should have been thrown');
        } catch (AccountWrapper.AWException e) {
            Assert.isTrue(
                e.getMessage().equalsIgnoreCase('no won opportunities'),
                'Exception message does not match: ' + e.getMessage()
            );
        }
    }
}