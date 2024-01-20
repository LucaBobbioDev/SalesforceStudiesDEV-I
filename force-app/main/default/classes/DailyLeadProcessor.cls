public with sharing class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext ctx) {
        List<Lead> leadListToUpdate = [
            SELECT Id, LeadSource
            FROM Lead
            LIMIT 200
        ];
        
        for(Lead leadRecord : leadListToUpdate){
            leadRecord.LeadSource = 'Dreamforce';
        }
        update leadListToUpdate;
    }
}