trigger PositionTrigger on Position__c (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        PositionTriggerHandler.followOnPositionInsert(Trigger.new);
    }
//If there is an update and isAfter, pass Trigger.new to triggerHandler
    if(Trigger.isAfter && Trigger.isUpdate){
        PositionTriggerHandler.followOnPositionUpdate(Trigger.new);
    }
}
