public class parentChildStatusUpdate {
    static Boolean isUpdated = false;
    public static void updateTypeField(List<Account> accList){
        System.debug('accList: '+accList);
        
        if(isUpdated == false){
            //Filter Account IDs Set with ParentID Only
            Set<Id> accIdwithParent = new Set<Id>();
            
            for(Account acc:accList){
                if(acc.ParentId != null){
                    accIdwithParent.add(acc.ParentId);
                }
            }
            System.debug('accIdwithParent: '+accIdwithParent);
            
            //Query Parent accounts from that has Id in accIdwithParent
            //Query Child accounts from that has parent ID in accIdwithParent
            List<Account> parentFields = [SELECT Id, Type FROM Account WHERE Id IN :accIdwithParent];
            List<Account> childAccToUpdate = [SELECT Id, Type FROM Account WHERE ParentId IN :accIdwithParent];
            System.debug('Parent: '+parentFields);
            System.debug('Child: '+childAccToUpdate);
            List<Account> updateRecords = new List<Account>();
            for(Account childAccUpd:childAccToUpdate){
                //Some Condition needed to update only on 4th and 5th Child Account update only.
                for(Account parentAccUpd:parentFields){
                    childAccUpd.Type = parentAccUpd.Type;
                    updateRecords.add(childAccUpd);
                }
            }
            isUpdated = true;
            update updateRecords;
        }
    }
    
    //Corrected Code
    public static void handleUpdate(List<Account> newAccounts) {
        Map<Id, Account> parentAccounts = new Map<Id, Account>();
        for(Account parentAccount : newAccounts) {
            parentAccounts.put(parentAccount.Id, parentAccount);
        }
        List<Account> childAccounts = [SELECT Id, Description, ParentId FROM Account WHERE ParentId IN :parentAccounts.keySet()];
        for (Account childAcc : childAccounts) {
            //Get the entire record of the parent record ID (From ParentId Field)
            Account parentAccount = parentAccounts.get(childAcc.ParentId);
            System.debug('Get Method: '+parentAccounts.get(childAcc.ParentId));
            //childAcc.Amount__c = parentAccount.Amount__c;
            childAcc.Type = parentAccount.Type;
            childAcc.Description = parentAccount.Description;
            childAcc.AnnualRevenue = parentAccount.AnnualRevenue;
        }
        update childAccounts;
    }


/*

public static void updateTypeFieldFromChild(List<Account> accList){
System.debug('accList: '+accList);

if(isUpdated == false){
//Filter Account IDs Set with ParentID Only
Set<Id> childAccIdwithParent = new Set<Id>();

for(Account acc:accList){
if(acc.ParentId != null){
childAccIdwithParent.add(acc.ParentId);
}
}
System.debug('childAccIdwithParent: '+childAccIdwithParent);

//Query Child Accounts that has ParentIds
List<Account> parentFields = [SELECT Id, Type FROM Account WHERE Id IN :childAccIdwithParent];
List<Account> childAccToUpdate = [SELECT Id, Type FROM Account WHERE ParentId IN :childAccIdwithParent];
System.debug('Parent: '+parentFields);
System.debug('Child: '+childAccToUpdate);
List<Account> updateChildRecords = new List<Account>();

for(Account childAccUpd:childAccToUpdate){
for(Account parentAccUpd:parentFields){
childAccUpd.Type = parentAccUpd.Type;
updateChildRecords.add(childAccUpd);
}
}
isUpdated = true;
update updateChildRecords;
}
}
*/
}
