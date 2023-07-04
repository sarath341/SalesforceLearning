trigger AccountTrigger on Account (before insert, before update, after insert, after update) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        AccountTriggerHandler.updateAccountFields(Trigger.new);
    }
    
/*
    if(Trigger.isAfter){
        AccountTriggerHandler.updateAccountFieldsAfterInsert(Trigger.newMap);
    }
*/
/*   
  //Trigger without Using New Map (Create another Instance to avoid Read only error)
  if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        AccountTriggerHandler.updateAccountFieldsWithoutUsingNewMap(Trigger.new);
    }  
*/
}
