public with sharing class NewAccounts {
    public static void sObjectsInsert(Integer value){
        Integer counter = 1;
        List<Account> teaFactoryAccounts = new List<Account>();
        
        while(counter <= value){
            System.debug('Counter Value before Incrementing ' + counter);

            Account store = new Account();
            store.Name = 'The Tea Factory ' + counter;
            store.AccountNumber = '35629' + counter;

            teaFactoryAccounts.add(store);
            System.debug(teaFactoryAccounts);

            counter = counter + 1;
            System.debug('Counter Value after incrementing ' + counter);
        }

        System.debug('Size of Account List: ' + teaFactoryAccounts.size() );
        System.debug('Elements in Account List: ' + teaFactoryAccounts);

        insert teaFactoryAccounts;
    }
}