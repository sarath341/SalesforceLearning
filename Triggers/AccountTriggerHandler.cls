public class AccountTriggerHandler {
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
