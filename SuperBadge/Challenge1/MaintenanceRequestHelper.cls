//Status not yet working
public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(Map<Id,Case> caseMap) {
        
        Set<Id> caseIds = caseMap.keySet();
        System.debug('keySet: ' +caseIds);
        
        List<Case> caseList = caseMap.values();
        Map<Id,Integer> result = getMCycle(caseList);
        
        List<Equipment_Maintenance_Item__c> oldMaintenanceItems = [SELECT Equipment__c, Maintenance_Request__c
                                                                   FROM Equipment_Maintenance_Item__c
                                                                   WHERE Maintenance_Request__c IN :caseIds];
        List<Equipment_Maintenance_Item__c> newMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
        
        Map<Id,Case> newCaseMap = new Map<Id,Case>();
        for(Case oldCase : caseMap.values()){
            if((oldCase.Type == 'Repair' || oldCase.Type == 'Routine Maintenance') && oldCase.IsClosed){
                Case c1 = new Case(Subject = 'Vehicle Maintenance', Type = 'Routine Maintenance', Vehicle__c = oldCase.Vehicle__c,
                                   Origin = 'Phone', Date_reported__c = System.today(),
                                   Date_Due__c = System.today()+result.get(oldCase.Id));
                newCaseMap.put(c1.Id,c1);
            }
        }
        System.debug('New Cases: '+ newCaseMap.values());
        insert newCaseMap.values();
        
        for(Case newCase : newCaseMap.values()){
            for(Equipment_Maintenance_Item__c oldItem : oldMaintenanceItems){
             //   if(caseMap.containsKey(oldItem.Maintenance_Request__c)){                     
                    Equipment_Maintenance_Item__c e1 = new Equipment_Maintenance_Item__c();
                    e1.Equipment__c = oldItem.Equipment__c;
                    e1.Maintenance_Request__c = newCase.Id;
                    newMaintenanceItems.add(e1);
                    System.debug('New M items: '+ newMaintenanceItems);
                //}
            }
            
            insert newMaintenanceItems;
        }
        
    }
    public static Map<Id,Integer> getMCycle(List<Case> caseList){
        Map<Id,Integer> result = new Map<Id,Integer>();
        Map<Id,Case> caseMap = new Map<Id,Case>(caseList);
        List<AggregateResult> equips = [SELECT Maintenance_Request__r.Id cID, MIN(Equipment__r.Maintenance_Cycle__c)cycle 
                                        FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__r.Id IN :caseMap.KeySet()
                                        GROUP BY Maintenance_Request__r.Id];
        for(AggregateResult eq:equips){
            Integer addDays = 0;
            if(eq.get('cycle')!=null){
                addDays+= Integer.valueOf(eq.get('cycle'));
                result.put((String)eq.get('cID'), addDays);
            }
            
        }
        return result;     
    }
}
