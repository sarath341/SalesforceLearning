public class FutureAccountDemo {
    //Fetch Account records starting with the Name 'Demo' and update Type as 'Prospect'
    @future
    public static void updateAccountType(){
        List<Account> accList = [SELECT Id
                                FROM Account
                                WHERE Name LIKE 'Demo%'];
        for(Account acc: accList){
            acc.Type = 'Prospect';
        }
        update accList;
    }

}
