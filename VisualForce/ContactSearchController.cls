public class ContactSearchController {
    
    public String searchText{get; set;}
    public List<Contact> conList {get; set;}
    
    public pageReference doSearch(){
        List<List<sObject>> records = [FIND :searchText
                                      RETURNING Contact (FirstName, LastName, Email)];
        conList = records[0];
        return null;
    }
}
