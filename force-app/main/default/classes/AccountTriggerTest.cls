@IsTest
public class AccountTriggerTest {
	@IsTest
    static void testAccountTrigger(){
        List<Account> accountList = new List<Account>();
        for (Integer i = 0; i < 200; i++){
            Account newAccount = new Account(Name = 'Account Test ' + i, BillingState = 'CA');
            accountList.add(newAccount);
        }
        
        Test.startTest();
        	insert accountList;
        Test.stopTest();
        
        List<Account> updatedAccounts = [
            SELECT Id, Name, BillingState, ShippingState
        	FROM Account
        	WHERE Id IN: accountList
        ];
        
        for (Account acc : updatedAccounts){
            System.assertEquals('CA', acc.ShippingState, 'ShippingState demands to be equal to BillingState');
        }
    }
}