@isTest
public class AccountTriggerHandlerTest {
    //Test data can be created in different ways
    //We can create test data inside every test method
	@isTest
    static void testupdateAccountFieldsRatingHot(){
        Account acc = new Account(Name='Test Inc', NumberOfEmployees=6000);
        try{
            insert acc;
        }
        catch(DmlException ex){
            System.debug(ex.getMessage());
        }
        Account newAcc = [SELECT Name, Rating
                         FROM Account];
        System.assertEquals('Hot', newAcc.Rating, 'Please Check the Logic');
    }
    @isTest
    static void testupdateAccountFieldsRatingWarm(){
        Account acc = new Account(Name='Test Inc', NumberOfEmployees=3000);
        try{
            insert acc;
        }
        catch(DmlException ex){
            System.debug(ex.getMessage());
        }
        Account newAcc = [SELECT Name, Rating
                         FROM Account];
        System.assertEquals('Warm', newAcc.Rating, 'Please Check the Logic');
    }
}
