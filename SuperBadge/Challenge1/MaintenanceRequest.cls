trigger MaintenanceRequest on Case (after insert, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){
        MaintenanceRequestHelper.updateWorkOrders(Trigger.newMap);
    }
}
