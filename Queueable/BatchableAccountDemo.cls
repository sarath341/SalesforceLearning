public class BatchableAccountDemo implements Database.Batchable<sobject>{
    
    public Database.QueryLocater start(Database.BatchableContext bc){
        String q;
        return null;
    }
	
    public void execute(Database.BatchableContext bc, List<Account> accList){
        
    }
    
    public void Finish(){
        
    }
}
