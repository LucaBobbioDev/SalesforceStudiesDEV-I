trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    if(Trigger.isAfter & (Trigger.isInsert || Trigger.isUpdate)){
        List<Task> tasksToInsert = new List<Task>();

        for (Opportunity opp : Trigger.new) {
            if (opp.StageName == 'Closed Won') {
                Task newTask = new Task(
                    Subject = 'Tarefa de teste de acompanhamento',
                    WhatId = opp.Id
                );
                tasksToInsert.add(newTask);
            }
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}