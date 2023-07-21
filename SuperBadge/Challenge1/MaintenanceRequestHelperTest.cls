@isTest
public with sharing class MaintenanceRequestHelperTest {
    // implement scheduled code here
    @isTest
    public static void mRequestTest(){
        Vehicle__c v1 = new Vehicle__c(Name = 'Ford Figo');
        Vehicle__c v2 = new Vehicle__c(Name = 'Hyundai i10');
        insert v1;
        insert v2;
        
        List<Vehicle__c> vehicles = [SELECT Id, Name FROM Vehicle__c];
        List<Case> newCaseList = new List<Case>();
        for(Integer i=0; i<200; i++){
            Case newCase = New Case();
            newCase.Status = 'New';
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = 'Test Case';
            newCase.Vehicle__c = vehicles[0].Id;
            newCase.Origin = 'Web';
            newCase.Date_Reported__c = System.today();
            newCaseList.add(newCase);
        }
        for(Integer i=0; i<200; i++){
            Case newCase = New Case();
            newCase.Status = 'New';
            newCase.Type = 'Repair';
            newCase.Subject = 'Test Case';
            newCase.Vehicle__c = vehicles[1].Id;
            newCase.Origin = 'Web';
            newCase.Date_Reported__c = System.today();
            newCaseList.add(newCase);
        }
        insert newCaseList;
        
        Product2 pdt = new Product2(Name='Product0', Maintenance_Cycle__c = 30, Replacement_Part__c = true);
        insert pdt;
        
        List<Product2> products = [SELECT Id, Name FROM Product2];
        List<Equipment_Maintenance_Item__c> EMIList = new List<Equipment_Maintenance_Item__c>();
        for(Case newCaseUpd:newCaseList){
            Equipment_Maintenance_Item__c eqp = new Equipment_Maintenance_Item__c();
            eqp.Quantity__c = 1;
            eqp.Maintenance_Request__c = newCaseUpd.Id;
            eqp.Equipment__c = products[0].Id;
            EMIList.add(eqp);
        }
        insert EMIList;
        
        List<Case> updateCaseList = new List<Case>();
        for(Case upd : [SELECT Id, Status FROM Case]){
            upd.Status = 'Closed';
            updateCaseList.add(upd);
        }
        update updateCaseList;
        
        System.assertEquals(800, [SELECT Count() FROM Case]);
        System.assertEquals(800, [SELECT Count() FROM Equipment_Maintenance_Item__c]);
    }
}
