public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext context, List<Lead> leadList){
        for(Lead leadRecord : leadList){
            leadRecord.LeadSource = 'Dreamforce';
        }
        update leadList;
    }

    public void finish(Database.BatchableContext context){}
}