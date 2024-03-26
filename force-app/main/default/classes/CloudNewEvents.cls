public with sharing class CloudNewEvents {
    public void createNewEventMessage(){
        Cloud_News__e newsEvent = new Cloud_News__e(
                Location__c='Mountain City',
                Urgent__c=true,
                News_Content__c='Lake Road is closed due to mudslides.'
        );
        
        // Call method to publish events
        Database.SaveResult eventResult = EventBus.publish(newsEvent);

        if (eventResult.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : eventResult.getErrors()) {
                System.debug('Error returned: ' +
                            err.getStatusCode() +
                            ' - ' +
                            err.getMessage()
                );
            }
        }
    }

    public void createNewEventsListMessage(){
        List<Cloud_News__e> newsEventList = new List<Cloud_News__e>();

        Cloud_News__e newsEvent1 = new Cloud_News__e(
                Location__c='Mountain City',
                Urgent__c=true,
                News_Content__c='Lake Road is closed due to mudslides.'
        );
        newsEventList.add(newsEvent1);

        Cloud_News__e newsEvent2 = new Cloud_News__e(
                Location__c='Mountain City',
                Urgent__c=false,
                News_Content__c='Small incident on Goat Lane causing traffic.'
        );
        newsEventList.add(newsEvent2);

        // Call method to publish events
        List<Database.SaveResult> results = EventBus.publish(newsEventList);
    
        for (Database.SaveResult eventResult : results) {
            if (eventResult.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error err : eventResult.getErrors()) {
                    System.debug('Error returned: ' +
                                err.getStatusCode() +
                                ' - ' +
                                err.getMessage()
                    );
                }
            }
        } 
    }
}