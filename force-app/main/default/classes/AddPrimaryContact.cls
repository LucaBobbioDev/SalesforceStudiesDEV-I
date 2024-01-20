public with sharing class AddPrimaryContact implements Queueable{
    private Contact contact;
    private String targetState;

    public AddPrimaryContact(Contact contactRecord, String state) {
        this.contact = contactRecord;
        this.targetState = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accountList = [
            SELECT Id, Name 
            FROM Account 
            WHERE BillingState = :targetState 
            LIMIT 200
        ];

        List<Contact> newContactsToInsert = new List<Contact>();
        for (Account acc : accountList) {
            Contact newContact = contact.clone(false, true, false, false);
            newContact.AccountId = acc.Id;
            newContactsToInsert.add(newContact);
        }

        if (!newContactsToInsert.isEmpty()) {
            insert newContactsToInsert;
        }
    }
}