public class MyFutureClass {  
    static void myFutureMethod() {
        List<Account> accounts = [
            SELECT Id 
            FROM Account 
            WHERE BillingState = 'NY'
        ];

        Id parentId = [SELECT Id FROM Account WHERE Name = 'ACME Corp'][0].Id;

        UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
        ID jobID = System.enqueueJob(updateJob);
    }
}