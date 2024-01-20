public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accountList){
        for(Account acc: accountList){
            if(acc.ShippingState != acc.BillingState){
                acc.ShippingState = acc.BillingState;
            }
        }
    }
}