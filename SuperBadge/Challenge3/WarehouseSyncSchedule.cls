public with sharing class WarehouseSyncSchedule implements Schedulable{
    // implement scheduled code here
    public void execute(SchedulableContext ctx){
        Id jobID = System.enqueueJob(new WarehouseCalloutService());
        System.debug('jobID: '+jobID);
    }
}
