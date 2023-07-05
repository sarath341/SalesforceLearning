trigger checkLMDateTrigger on Task (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        //accStatusHandler.setStatus(Trigger.newMap);
        accStatusHandler.setStatusWithoutMap(Trigger.new);
    }
}
