public class ContactsTodayController {
    @AuraEnabled
    public static List<Contact> getContactsForToday() {
        List<Contact> importantContacts = new List<Contact>();
        List<Id> idList = new List<Id>();
        
        List<Task> myTasks = getMyTasks();
        List<Event> myEvents = getMyEvents();
        List<Case> myCases =  getMyCases();
        
        List<Id> taskContactsIds = new List<Id>();
        for(Task task : myTasks) {
            taskContactsIds.add(task.WhoId);
        }

        List<Contact> taskContactsList = [SELECT Id, Name, Phone, Description FROM Contact WHERE ID IN: taskContactsIds];
        System.debug(taskContactsList.size() + ' task contacts found');
        for(Contact contact : taskContactsList) {
            for(Task task : myTasks) {
                if(task.WhoId == contact.Id) {
                    contact.Description = 'Because of Task "'+task.Subject+'"';
                    System.debug(contact.Description);
                }
            }
        }

        importantContacts.addAll(taskContactsList);

        List<Id> eventContactsIds = new List<Id>();
        for(Event event : myEvents) {
            eventContactsIds.add(event.WhoId);
        }
        
        List<Contact> eventContactsList = [SELECT Id, Name, Phone, Description from Contact where ID IN: eventContactsIds];
        System.debug(eventContactsList.size() + ' event contacts found');
        for(Contact contact : eventContactsList) {
            for(Event event : myEvents) {
                System.debug(event.WhoId +';;;'+ contact.Id);
                if(event.WhoId == contact.Id) {
                    contact.Description = 'Because of Event "'+event.Subject+'"';
                    System.debug(contact.Description);
                }
            }
        }
        importantContacts.addAll(eventContactsList);
        
        List<Id> caseContactsIds = new List<Id>();
        for(Case cases : myCases) {
            caseContactsIds.add(cases.ContactId);
        }
        
        List<Contact> caseContactsList = [SELECT Id, Name, Phone, Description from Contact where ID IN: caseContactsIds];
        for(Contact contact : caseContactsList) {
            for(Case cases : myCases) {
                if(cases.ContactId == contact.Id) {
                    contact.Description = 'Because of Case "'+cases.Subject+'"';
                    System.debug(contact.Description);
                }
            }
        }

        importantContacts.addAll(caseContactsList);
        return importantContacts;
    }
    
    public static List<Task> getMyTasks() {
        return [
            SELECT Id, Subject, WhoId 
            FROM Task 
            WHERE OwnerId = :UserInfo.getUserId() 
            AND Status != 'Completed' 
            AND WhoId != null
        ];
    }

    public static List<Event> getMyEvents() {
        return [
            SELECT Id, Subject, WhoId 
            FROM Event 
            WHERE OwnerId = :UserInfo.getUserId() 
            AND StartDateTime >= :Date.today() 
            AND WhoId != null
        ];
    }

    public static List<Case> getMyCases() {
        return [
            SELECT ID, ContactID, Status, Subject 
            FROM Case 
            WHERE OwnerId = :UserInfo.getUserId() AND Status != 'Closed'
        ];
    }
}