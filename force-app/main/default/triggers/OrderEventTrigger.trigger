trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> tasksToInsert = new List<Task>();
    
    for (Order_Event__e event : Trigger.new) {
        if (event.Has_Shipped__c == true) {
            Task newTask = new Task();
            newTask.Priority = 'Médio';
            newTask.Subject = 'Acompanhar pedido enviado 105';
            newTask.OwnerId = event.CreatedById;
            tasksToInsert.add(newTask);
        }
    }
    
    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}