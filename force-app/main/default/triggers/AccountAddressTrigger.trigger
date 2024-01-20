trigger AccountAddressTrigger on Account (before insert, before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Account account: Trigger.new){
            if(account.Match_Billing_Address__c == true){
                account.ShippingPostalCode = account.BillingPostalCode;
            }
        }
    }
}