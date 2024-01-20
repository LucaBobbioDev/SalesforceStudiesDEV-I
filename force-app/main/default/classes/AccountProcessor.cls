public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds){
        Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
        List<Account> accountsToUpdateList = new List<Account>();

        for (Account account :[SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
            Integer counter = account.Contacts.size();
            accountContactCountMap.put(account.Id, counter);
        }
        
        for (Id accountId : accountContactCountMap.keySet()) {
            Account newAccount = new Account(
                Id = accountId, 
                Number_Of_Contacts__c = accountContactCountMap.get(accountId)
            );
            accountsToUpdateList.add(newAccount);
        }

        update accountsToUpdateList;
    }
}