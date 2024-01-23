@IsTest
public with sharing class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < numAccts; i++) {
            Account account = new Account(Name = 'TestAccount ' + i);
            accountList.add(account);
        }
        insert accountList;

        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j = 0; j < numAccts; j++) {
            Account acct = accountList[j];
            for (Integer k = 0; k < numOppsPerAcct; k++) {
                opps.add(new Opportunity(
                            Name = acct.Name + ' Opportunity ' + k,
                            StageName = 'Prospecting',
                            CloseDate = System.today().addMonths(1),
                            AccountId = acct.Id
                        ));
            }
        }

        insert opps;
        return accountList;
    }
}