public with sharing class WarehouseCalloutService implements Queueable {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    @future(Callout=true)
    public static void makeCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Product2> equipsToUpdate = new List<Product2>();
        if(response.getStatusCode() == 200){
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            for(Object res : results){
                Map<String, Object> eq = (Map<String, Object>)res;
                Product2 equip = new Product2();
                equip.Cost__c = (Decimal) eq.get('cost');
                equip.Current_Inventory__c = (Decimal) eq.get('quantity');
                equip.Lifespan_Months__c = (Decimal) eq.get('lifespan');
                equip.Maintenance_Cycle__c = (Decimal) eq.get('maintenanceperiod');
                equip.Replacement_Part__c = (Boolean) eq.get('replacement');
                equip.Warehouse_SKU__c = (String) eq.get('sku');
                equip.Name = (String) eq.get('name');
                equipsToUpdate.add(equip);
            }
        }
        upsert equipsToUpdate;
    }
    public void execute(QueueableContext context){
        WarehouseCalloutService.makeCallout();
    }
}
