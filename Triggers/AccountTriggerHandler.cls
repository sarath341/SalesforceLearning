//This Class runs under user mode - with sharing
//Always mention this with the class unless there is a special requirement to run
//the class under system mode

public with sharing class AccountTriggerHandler {
    //We create a new instance to avoid read only error
    static Boolean isDone = false;
    public static void updateAccountFieldsWithoutUsingNewMap(List<Account> accList){
        List<Account> newAccList = new List<Account>();
        if(isDone ==  false){
            for(Account acc : accList){
                Account newAcc = new Account();
                newAcc.Id = acc.Id;
                if(acc.NumberOfEmployees >= 5000){
                    newAcc.Rating = 'Hot';
                }
                else{
                    newAcc.Rating = 'Warm';
                }
                newAccList.add(newAcc);
            }
            isDone = true;
            update newAccList;
        }//End of updateAccountFieldsWithoutUsingNewMap
    }
    public static void updateAccountFields(List<Account> accList){
        for(Account acc : accList){
            if(acc.NumberOfEmployees >= 5000){
                acc.Rating = 'Hot';
                acc.Type = 'Prospect';
            }
            else{
                acc.Rating = 'Warm';
                acc.Type = 'Analyst';
            }
        }
    }//End of updateAccountFields
    
    public static void updateAccountFieldsAfterInsert(Map<Id,Account> newMap){
        List<Account> accList = [SELECT Id, NumberofEmployees
                                 FROM Account
                                 WHERE Id IN :newMap.keySet()];
        for(Account acc : accList){
            if(acc.NumberOfEmployees >= 5000){
            acc.Rating = 'Hot';
            }
        }
        update accList;
    }//End of updateAccountFieldsAfterInsert()
}
