public with sharing class PropertyUtility {
    //Phind version
    public static void newListedPropertiesPhind(){
        List<String> newPropList = new List<String>();

        String queryString = 'SELECT Name, Broker__r.Email__c, Days_on_Market__c FROM Property__c WHERE Days_on_Market__c <= 30';
        List<Property__c> properties = Database.query(queryString);

        for (Property__c prop : properties) {
            String propEmail = prop.Name + ' : ' + prop.Broker__r.Email__c;
            newPropList.add(propEmail);
            System.debug(propEmail);
        }
    }

    //GPT Version
    public static void newListedPropertiesGPT(){
        List<Property__c> newPropList = [
            SELECT Name, Broker__r.Email__c, Days_on_Market__c 
            FROM Property__c 
            WHERE Days_on_Market__c <= 30
        ];

        for(Property__c property : newPropList) {
            String propEmail = property.Name + ' : ' + property.Broker__r.Email__c;
            System.debug(propEmail);
        }
    }
}