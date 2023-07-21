@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
	@isTest 
    static void testPostCallout() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.Class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.makeCallout();
        System.enqueueJob(new WarehouseCalloutService());
        Test.stopTest();
        System.assertEquals(22, [SELECT count() FROM Product2]);
    }
}
