/*Trigger Context Variables*/

//Trigger.new - List of New Version of sObjects (Insert, Update, Undelete) - Before Triggers Only
//Trigger.newMap - Holds the 'Map of IDs' of new Version of sObjects(Before Update, After Insert, After Update, and After Undelete)
//Trigger.old - List of Old Version of sObjects (Update, Delete)
//Trigger.oldMap - Holds the 'Map of IDs' of Old Version of sObjects(Update, Delete)
//IsInsert, IsUpdate, isDelete, isUndelete, isExecuting are Boolean Context var due to the specific operation
//operationType - (System.TriggerOperation) can be used with 'Switch' statement based on programming Logic

trigger OpportunityTrigger on Opportunity (after insert,after update, before delete, before update) {
    
    List<Opportunity> oppList = new List<Opportunity>();
    
    /* After, Insert, Trigger.new */
    //'isAfter' Returns true if this trigger was fired after all records were saved.
    //'isInsert' Returns true if this trigger was fired due to an insert operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isAfter && Trigger.isInsert){
        for(Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                oppList.add(opp);
            }
        }
        OpportunityTriggerHandler.postWonDealOnChatter(oppList);
    }
    
    /* After, Insert,Update, Trigger.new */
    //'isAfter' returns true if this trigger was fired after all records were saved.
    //'isUpdate' Returns true if this trigger was fired due to an update operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Opportunity opp : Trigger.new){
            Opportunity oldRecord = Trigger.oldMap.get(opp.Id);
            if(opp.StageName == 'Closed Won' && oldRecord.StageName != 'Closed Won'){
                oppList.add(opp);
            }
        }
        OpportunityTriggerHandler.postWonDealOnChatter(oppList);
    }
    
    /* Delete, Trigger.old */    
    //'isDelete' Returns true if this trigger was fired due to a delete operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isDelete){
        for(Opportunity opp : Trigger.old){
            if(opp.StageName == 'Closed Won'){
                //opp.addError('Closed Won Opportunities cannot be deleted');
                opp.StageName.addError('Closed Won Opportunities cannot be deleted');
            }
        }
    }
    
    /* Before, Update, Trigger.new, Trigger.oldMap */
    //Prevent Changing the Closed Won Opportunities
    //isBefore - Returns true if this trigger was fired before any record was saved.
    //'isUpdate' Returns true if this trigger was fired due to an update operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityTriggerHandler.preventStageChange(Trigger.new,Trigger.oldMap);
        
        for(Opportunity opp : Trigger.new){
            Opportunity oldRecord = Trigger.oldMap.get(opp.Id);
            if(opp.StageName != 'Closed Won' && oldRecord.StageName == 'Closed Won'){
                opp.StageName.addError('Closed Won Opportunities cannot be Modified');
            }
        }        
    }
    
    /* After, Insert, Trigger.new */
    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityTriggerHandler.createAnOrderForWonDealForInsert(Trigger.new);
    }
    
    /* After, Update, Trigger.new, Trigger.oldMap */
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.createAnOrderForWonDealForUpdate(Trigger.new,Trigger.oldMap);
    }
    
}
