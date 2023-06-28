public class contactsChecked {
    //Static in salesforce are per transaction, so the value will be true only for the current transaction.
    public static Boolean isUpdated = false; //To avoid recursion when updating same object records
    public static void massUpdateStatus(List<Contact> conList){
        Set<Id> updAccListID = new Set<Id>();
        for(Contact con:conList){
            if(con.Status__c == true){
                updAccListID.add(con.AccountId);
            }
        }
        
        List<Contact> updConList = [SELECT Id FROM Contact Where AccountId IN :updAccListID];
        List<Contact> toUpdate = new List<Contact>();
        if(isUpdated == false){ 
            for(Contact updCon:updConList){
                updCon.Status__c = true;
                toUpdate.add(updCon);
            }
            isUpdated = true;//Before Update
            update toUpdate;
        }
    }
}
