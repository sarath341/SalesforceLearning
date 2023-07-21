public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> updWorkOrders, Map<Id,Case> nonUpdCaseMap) {
        Set<Id> validIds = new Set<Id>();
  
        for (Case c : updWorkOrders){
            if (nonUpdCaseMap.get(c.Id).Status != 'Closed' && c.Status == 'Closed'){
                if (c.Type == 'Repair' || c.Type == 'Routine Maintenance'){
                    validIds.add(c.Id);
                }
            }
        }
        
        if (!validIds.isEmpty()){
            List<Case> newCases = new List<Case>();
            Map<Id,Case> closedCasesM = new Map<Id,Case>([SELECT Id, Vehicle__c, ProductId, Product.Maintenance_Cycle__c,(SELECT Id,Equipment__c,Quantity__c FROM Equipment_Maintenance_Items__r) 
                                                         FROM Case WHERE Id IN :validIds]);
            Map<Id,Decimal> maintenanceCycles = new Map<ID,Decimal>();
            AggregateResult[] results = [SELECT Maintenance_Request__c, MIN(Equipment__r.Maintenance_Cycle__c)cycle FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c IN :ValidIds GROUP BY Maintenance_Request__c];
        
        for (AggregateResult ar : results){ 
            maintenanceCycles.put((Id) ar.get('Maintenance_Request__c'), (Decimal) ar.get('cycle'));
        }
            
            for(Case cc : closedCasesM.values()){
                Case nc = new Case (
                    ParentId = cc.Id,
                	Status = 'New',
                    Subject = 'Routine Maintenance',
                    Type = 'Routine Maintenance',
                    Vehicle__c = cc.Vehicle__c,
                    ProductId =cc.ProductId, //No field like this
                    Origin = 'Web',
                    Date_Reported__c = Date.Today()
                );
                
                if (maintenanceCycles.containskey(cc.Id)){
                    nc.Date_Due__c = Date.today().addDays((Integer) maintenanceCycles.get(cc.Id));
                } /*else {
                    nc.Date_Due__c = Date.today().addDays((Integer) cc.Product.maintenance_Cycle__c);
                }*/
                
                newCases.add(nc);
            }
            
           insert newCases;
            
           List<Equipment_Maintenance_Item__c> clonedWPs = new List<Equipment_Maintenance_Item__c>();
           for (Case nc : newCases){
                for (Equipment_Maintenance_Item__c wp : closedCasesM.get(nc.ParentId).Equipment_Maintenance_Items__r){
                    Equipment_Maintenance_Item__c wpClone = wp.clone();
                    wpClone.Maintenance_Request__c = nc.Id;
                    ClonedWPs.add(wpClone);
                }
            }
            insert ClonedWPs;
        }
    }
   /* public static void updateWorkOrders(Map<Id,Case> caseMap) {
        
        Set<Id> caseIds = caseMap.keySet();
        System.debug('keySet: ' +caseIds);
        
        List<Case> caseList = caseMap.values();
        Map<Id,Integer> result = getMCycle(caseList);
        
        List<Equipment_Maintenance_Item__c> oldMaintenanceItems = [SELECT Equipment__c, Maintenance_Request__c, Quantity__c
                                                                   FROM Equipment_Maintenance_Item__c
                                                                   WHERE Maintenance_Request__c IN :caseIds];
        List<Equipment_Maintenance_Item__c> newMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
        
        Map<Id,Case> newCaseMap = new Map<Id,Case>();
        for(Case oldCase : caseMap.values()){
            Case c1 = new Case();
            c1.Subject = oldCase.Subject;
            c1.Type = 'Routine Maintenance'; 
            c1.Vehicle__c = oldCase.Vehicle__c;
            c1.Origin = 'Phone';
            c1.Date_reported__c = System.today(); 
            c1.Status = 'New';
            if(result.get(oldCase.Id) != null){
                c1.Date_Due__c = System.today()+result.get(oldCase.Id);
            }
            else{
                c1.Date_Due__c = System.today();
            }
            
            newCaseMap.put(c1.Id,c1);
        }
        System.debug('New Cases: '+ newCaseMap.values());
        insert newCaseMap.values();
        
        for(Case newCase : newCaseMap.values()){
            for(Equipment_Maintenance_Item__c oldItem : oldMaintenanceItems){
                if(caseMap.containsKey(oldItem.Maintenance_Request__c)){                     
                    Equipment_Maintenance_Item__c e1 = new Equipment_Maintenance_Item__c();
                    e1.Quantity__c = oldItem.Quantity__c;
                    e1.Equipment__c = oldItem.Equipment__c;
                    e1.Maintenance_Request__c = newCase.Id;
                    newMaintenanceItems.add(e1);
                    System.debug('New M items: '+ newMaintenanceItems);
                }
            }    
        }
        
        insert newMaintenanceItems;
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
    }*/
}
