public class accStatusHandler {
    public static void setStatusWithoutMap(List<Task> taskList){
        List<Id> accIDs = new List<Id>();
        for(Task eachTask: taskList){
            accIDs.add(eachTask.AccountId);
        }
        
        List<Account> accList = [SELECT Id, Name, Status__c, LastModifiedDate FROM Account WHERE Id IN :accIds];
        List<Account> accUpdatedList = new List<Account>();
        
        for(Account acc: accList){
            System.debug('LM Date: '+acc.LastModifiedDate);
            System.debug('LM Date+30: '+(acc.LastModifiedDate+30));
            System.debug('Today: '+System.today());
            if(acc.LastModifiedDate > System.NOW()-30){
                acc.Status__c = true;
            }
            else{
                acc.Status__c = false;
            }
            accUpdatedList.add(acc);
        }
        update accUpdatedList;
    }
    
    
    
    
  /*  
    public static void setStatus(Map<Id, Task> taskMap){
        
        Set<Id> taskIDs = taskMap.keySet();
        System.debug('Task Ids: '+taskIDs);
        
        
        
        List<Account> accList = [SELECT Id, Name, Status__c 
                                 FROM Account 
                                 WHERE Id IN :taskIDs];
        System.debug('accList : '+accList);
        
        List<Account> accUpdatedList = new List<Account>();
        for(Account acc:accList){
            System.debug('LM Date: '+acc.LastModifiedDate);
            System.debug('LM Date+30: '+acc.LastModifiedDate);
            if(acc.LastModifiedDate+30>System.today()){
                acc.Status__c = false;
            }
            else if(acc.LastModifiedDate+30< System.today()){
                acc.Status__c = true;
            }
            accUpdatedList.add(acc);
        }
        update accUpdatedList;
    }
*/
}
