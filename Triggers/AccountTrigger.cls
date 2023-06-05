//Trigger should be of object name
trigger AccountTrigger on Account (before insert, before update) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        AccountTriggerHandler.updateAccountFields(Trigger.new);
    }

}
