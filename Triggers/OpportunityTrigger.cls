trigger OpportunityTrigger on Opportunity (after insert,after update, before delete, before update) {
    
    List<Opportunity> oppList = new List<Opportunity>();
    
    //'isAfter' returns true if this trigger was fired after all records were saved.
    //'isUpdate' Returns true if this trigger was fired due to an update operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isAfter && Trigger.isInsert){
        for(Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                oppList.add(opp);
            }//If
        }//for
        OpportunityTriggerHandler.postWonDealOnChatter(oppList);
    }
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
    /*
    //'isDelete' Returns true if this trigger was fired due to a delete operation, from the Salesforce user interface, Apex, or the API.
    if(Trigger.isDelete){
        for(Opportunity opp : Trigger.old){
            if(opp.StageName == 'Closed Won'){
                //opp.addError('Closed Won Opportunities cannot be deleted');
                opp.StageName.addError('Closed Won Opportunities cannot be deleted');
            }//If
        }//for
    }
	*/
//Prevent Changing the Closed Won Opportunities

     if(Trigger.isBefore && Trigger.isUpdate){
        for(Opportunity opp : Trigger.new){
            Opportunity oldRecord = Trigger.oldMap.get(opp.Id);
            if(opp.StageName != 'Closed Won' && oldRecord.StageName == 'Closed Won'){
                opp.StageName.addError('Closed Won Opportunities cannot be Modified');
            }//if
        }//for
    }//if
/*
if(Trigger.isAfter && Trigger.isInsert){
OpportunityTriggerHandler.createAnOrderForWonDealForInsert(Trigger.new);
}
if(Trigger.isAfter && Trigger.isUpdate){
OpportunityTriggerHandler.createAnOrderForWonDealForUpdate(Trigger.new,Trigger.oldMap);
}
*/
}//trigger
