trigger CloudNewsTrigger on Cloud_News__e (after insert) {
    List<Case> cases = new List<Case>();
    Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' AND Type='Queue'];

    for (Cloud_News__e event : Trigger.New) {
        if (event.Urgent__c == true) {
            Case cs = new Case();
            cs.Priority = 'High';
            cs.Subject = 'News team dispatch to ' +
                event.Location__c;
            cs.OwnerId = queue.Id;
            cases.add(cs);
        }
    }

    System.debug('Case' + cases);
    insert cases;
}