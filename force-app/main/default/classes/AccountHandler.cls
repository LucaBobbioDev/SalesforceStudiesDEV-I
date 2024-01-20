public class AccountHandler {
    public static Account insertNewAccount(String accountName){
        try{
            Account newAccount = new Account(Name = accountName);
            insert newAccount;
            return newAccount;
        } catch(Exception e) {
            return null;
        }
    }
}