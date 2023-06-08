public class OpportunityTriggerHandler {
    //Post Won deals on chatter
    public static void postWonDealOnChatter(List<Opportunity> oppList){
        //Select All AW Computing Group
        CollaborationGroup chatterGroup = [SELECT Id 
                                           FROM CollaborationGroup 
                                           WHERE Name = 'All AW Computing'];
        
        //Create a feed item list called chatterPostList
        List<FeedItem> chatterPostList = new List<FeedItem>();
        
        //Traverse the Opportunity list passed from postWonDealOnChatter(oppList) method
        for(Opportunity opp: oppList){
         
         //Create a feed item instance variable called chatterPost, set field values query (for All AW Computing ID) and set field values from opp traversing
            FeedItem chatterPost = new FeedItem();
            chatterPost.ParentId = chatterGroup.Id; //Id of 'All AW Computing' from Query
            chatterPost.Body = 'We are pleased to inform you that '+opp.Name+' has been Won '+
                ' and the Amount is '+ opp.Amount;
            chatterPost.LinkUrl = '/'+opp.Id; //Populate the url with opportunity record ID
            chatterPost.Title = opp.Name; //Url Title with opportunity name
            chatterPostList.add(chatterPost); //Create a list one by one
        }
        try{
            
            insert chatterPostList;
            
        }
        catch (DmlException ex){
            System.debug(ex.getMessage());
        }
    }
    
    public static void createAnOrderForWonDealForUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        
        //Create a Set to store Account Id's of all the opportunities
        Set<Id> accIdSet = new Set<Id>();
        
        for(Opportunity opp:oppList){
            accIdSet.add(opp.AccountId);
        }
        
        //Fire a query on account object and fetch both billing and shipping address details
        //and store them in a map
        Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id, BillingStreet, BillingCity, 
                                                          BillingState, BillingPostalCode, BillingCountry, 
                                                          ShippingCity, ShippingStreet, ShippingState, 
                                                          ShippingPostalCode, ShippingCountry 
                                                          FROM Account WHERE Id IN :accIdSet]);
        //Create a list of order for Bulkification
        List<Order> orderRefList= new List<Order>();
        
        for(Opportunity opp:oppList){
            
            Opportunity oldRecord = oldMap.get(opp.Id);
            if(oldRecord.StageName != 'Closed Won' && opp.StageName == 'Closed Won'){
                //Create an instance of the Order Record and populate the fields
                //from Opportunity and Account
                Order orderRef = new Order();
                orderRef.AccountId = opp.AccountId;
                orderRef.EffectiveDate = opp.CloseDate;
                orderRef.Status = 'Draft';
                
                //Fetch current opportunity records account info from the Map
                Account acc = accountMap.get(opp.AccountId);
                
                orderRef.BillingCity = acc.BillingCity;
                orderRef.BillingStreet = acc.BillingStreet;
                orderRef.BillingCountry = acc.BillingCountry;
                orderRef.BillingState = acc.BillingState;
                orderRef.BillingPostalCode = acc.BillingPostalCode;
                
                orderRef.ShippingCity = acc.ShippingCity;
                orderRef.ShippingStreet = acc.ShippingStreet;
                orderRef.ShippingCountry = acc.ShippingCountry;
                orderRef.ShippingState = acc.ShippingState;
                orderRef.ShippingPostalCode = acc.ShippingPostalCode;
                orderRefList.add(orderRef);
            }
        }
        //Insert the orderRefList
        try{
            //In reality, an empty list will not consume a DML - but we
            //keep this check as a best practice
            if(orderRefList.size()>0){
                insert orderRefList;
            }
        }
        catch(DmlException ex){
            System.debug(ex.getMessage());
            //System.debug(ex.getStackTraceString());
        }
    }
    
    public static void createAnOrderForWonDealForInsert(List<Opportunity> oppList){
        //Create a Set to store Account Id's of all the opportunities
        Set<Id> accIdSet = new Set<Id>();
        for(Opportunity opp:oppList){
            accIdSet.add(opp.AccountId);
        }
        //Fire a query on account object and fetch both billing and shipping address details
        //and store them in a map
        Map<Id,Account> accountMap = new Map<Id,Account>([SELECT Id, BillingStreet, BillingCity, 
                                                          BillingState, BillingPostalCode, BillingCountry, 
                                                          ShippingCity, ShippingStreet, ShippingState, 
                                                          ShippingPostalCode, ShippingCountry 
                                                          FROM Account WHERE Id IN :accIdSet]);
        //Create a list of order for Bulkification
        List<Order> orderRefList= new List<Order>();
        
        for(Opportunity opp:oppList){
            if(opp.StageName == 'Closed Won'){
                //Create an instance of the Order Record and populate the fields
                //from Opportunity and Account
                Order orderRef = new Order();
                orderRef.AccountId = opp.AccountId;
                orderRef.EffectiveDate = opp.CloseDate;
                orderRef.Status = 'Draft';
                
                //Fetch current opportunity records account info from the Map
                Account acc = accountMap.get(opp.AccountId);
                
                orderRef.BillingCity = acc.BillingCity;
                orderRef.BillingStreet = acc.BillingStreet;
                orderRef.BillingCountry = acc.BillingCountry;
                orderRef.BillingState = acc.BillingState;
                orderRef.BillingPostalCode = acc.BillingPostalCode;
                
                orderRef.ShippingCity = acc.ShippingCity;
                orderRef.ShippingStreet = acc.ShippingStreet;
                orderRef.ShippingCountry = acc.ShippingCountry;
                orderRef.ShippingState = acc.ShippingState;
                orderRef.ShippingPostalCode = acc.ShippingPostalCode;
                orderRefList.add(orderRef);
            }//if
            
        }//for
        //Insert the orderRefList
        try{
            //In reality, an empty list will not consume a DML - but we
            //keep this check as a best practice
            if(orderRefList.size()>0){
                insert orderRefList;
            }
        }
        catch(DmlException ex){
            System.debug(ex.getMessage());
        }
    }//method
    
    public static void preventStageChange(List<Opportunity> oppList, Map<Id, Opportunity>oldMap){
        for(Opportunity opp : oppList){
            Opportunity oldRecord = oldMap.get(opp.Id);
            if(opp.StageName != 'Closed Won' && oldRecord.StageName == 'Closed Won'){
                opp.StageName.addError('Closed Won Opportunities cannot be Modified');
            }
        }
    }//End of preventStageChange
}//End of Class
