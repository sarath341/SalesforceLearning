trigger OpportunityTrigger on Opportunity (after insert,after update) {
    
    List<Opportunity> oppList = new List<Opportunity>();
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                oppList.add(opp);
            }//If
        }//for
        OpportunityTriggerHandler.postWonDealOnChatter(oppList);
    }
    
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
if(Trigger.isAfter && Trigger.isInsert){
OpportunityTriggerHandler.createAnOrderForWonDealForInsert(Trigger.new);
}
if(Trigger.isAfter && Trigger.isUpdate){
OpportunityTriggerHandler.createAnOrderForWonDealForUpdate(Trigger.new,Trigger.oldMap);
}
*/
}
