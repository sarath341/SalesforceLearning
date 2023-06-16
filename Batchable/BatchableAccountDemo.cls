
//To Perform more than 10000 DML ROWS (DML Limit)- upto 50 Million 
public class BatchableAccountDemo implements Database.Batchable<sobject>{
    Integer counter=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'Demo%\'';
        return Database.getQueryLocator(query);
    }
	
    public void execute(Database.BatchableContext bc, List<Account> accList){
        //Business Logic
        for(Account acc : accList){
            acc.Rating = 'Hot';
            counter++;
        }
        update accList;
    }
    
    public void finish(Database.BatchableContext bc){
        //Notify after batch complete
        System.debug('No. of records updated: '+counter);
    }
}
