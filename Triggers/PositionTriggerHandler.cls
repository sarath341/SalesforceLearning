public class PositionTriggerHandler {

    public static void followOnPositionInsert(List<Position__c> posList){

        List<EntitySubscription> entList = new List<EntitySubscription>();
        for(Position__c ent: posList){
            
            EntitySubscription entityInstance = new EntitySubscription();
            entityInstance.ParentId = ent.Id;
            entityInstance.SubscriberId = ent.Hiring_Manager__c;
            entList.add(entityInstance);
        }
        
        try{            
            insert entList;          
        }
        
        catch (DmlException ex){
            System.debug(ex.getMessage());
        }
    }
    
public static void followOnPositionUpdate(List<Position__c> posList){

        List<EntitySubscription> entList = new List<EntitySubscription>();
        
    	for(Position__c ent: posList){            
            EntitySubscription entityInstance = new EntitySubscription();
            entityInstance.ParentId = ent.Id;
            entityInstance.SubscriberId = ent.Hiring_Manager__c;
            entList.add(entityInstance);
        }
        
        try{            
            insert entList;          
        }
        
        catch (DmlException ex){
            System.debug(ex.getMessage());
        }
    }
    
}
