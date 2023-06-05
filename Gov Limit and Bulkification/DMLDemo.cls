public class DMLDemo {
    public static void standaloneDMLDemo(){
        //DML
        //2 Types of -> Standalone vs Database
        //LastName is a Required Field (we are making an error intentionally to verify)
        Contact c1 = new Contact(FirstName='Sarath',LastName='Kumar');
        Contact c2 = new Contact(FirstName='Rajesh');
        
        //Add them to the List
        List<Contact> conList = new List<Contact>{c1,c2};
            //conList.add(c1);
            //conList.add(c2);
            //Handle the DML Exception
            try{
                insert conList; //All or Nothing (If one fails all will fail)
            } catch (DmlException ex){
                System.debug(ex.getMessage());
            }
        System.debug('After Insert');        
    }//StandaloneDMLDemoEnd
    
    //DatabaseDML - Partial operation is allowed
    public static void databaseDMLDemo(){
        //LastName is a Required Field (we are making an error intentionally to verify)
        Contact c1 = new Contact(FirstName='Sarath',LastName='Kumar');
        Contact c2 = new Contact(FirstName='Rajesh');
        
        //Add them to the List
        List<Contact> conList = new List<Contact>{c1,c2};
            //conList.add(c1);
            //conList.add(c2);
            //saveResult holds the result of the DML Operation
            List<Database.SaveResult> saveResultList = Database.insert(conList, false);
        //We traverse the SaveResult List One by One
        for(Database.SaveResult saveResult: SaveResultList){
            
            //isSuccess() Method mentions the status 
            if(saveResult.isSuccess()){
                //getID() method shows the id of the record caused this error
                System.debug('Contact ID '+saveResult.getId());
            }
            else{
                //getError() method holds the errors
                //Traverse the saveResult.getErrors() to display getMessage() and display in debug
                for(Database.Error err : SaveResult.getErrors()){
                    System.debug(err.getMessage());
                }
            }
        }
        
    }//DatabaseDMLDemo
}//DMLDemo1
