trigger MaintenanceRequest on Case (after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders

    if((Trigger.isUpdate) && Trigger.isAfter){

        MaintenanceRequestHelper.updateWorkOrders(Trigger.New, Trigger.OldMap);

    }
    
    /*
    Map<Id, Case> caseMap = new Map<Id, Case>();
    if(Trigger.isAfter && (Trigger.isUpdate)){
        
        for(Case oldCase : Trigger.new){
            if((oldCase.Type == 'Repair' || oldCase.Type == 'Routine Maintenance') && oldCase.Status == 'Closed'){
                caseMap.put(oldCase.Id, oldCase);
            }
        }
    }
    MaintenanceRequestHelper.updateWorkOrders(caseMap);*/
}
