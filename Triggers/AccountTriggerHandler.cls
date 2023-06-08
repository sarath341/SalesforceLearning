public class AccountTriggerHandler {
    //get the accList from trigger and traverse then change the field based on condition
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
    }
}
