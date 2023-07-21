@isTest
public with sharing class WarehouseSyncScheduleTest {
    // implement scheduled code here
    @isTest
    static void scheduleTest(){
        String cronExp = '00 00 01 * * ?';
        Test.startTest();
        Test.setMock(HttpCalloutMock.Class, new WarehouseCalloutServiceMock());
        String jobId = System.schedule('syncScheduleJob', cronExp, new WarehouseSyncSchedule());
        Test.stopTest();
        CronTrigger a=[SELECT Id FROM CronTrigger where Id=:jobId];
        System.assertEquals(jobID, a.Id);
    }
}
