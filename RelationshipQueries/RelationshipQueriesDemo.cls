public class RelationshipQueriesDemo {
    public void childToParentQueries(){
        //Contact and Account -> Fetch Contact record details along with Accounts
        
        //1. Fetch all the Contacts details along with their account names
        /*List<Contact> conList = [SELECT FirstName, LastName, Account.Name, Account.Industry, Account.AnnualRevenue
								FROM Contact];
		for(Contact con : conList){
			System.debug(con.FirstName + ' :: ' + con.LastName+ ' :: '+ con.Account.Name+ ' :: '+ con.Account.Industry + ' :: '+con.Account.AnnualRevenue);
				}*/
        
        /*
		
		//2.Fetch all the contact details who have related accounts (It must have an AccountID)
		List<Contact> conList = [SELECT FirstName, LastName, Account.Name, Account.Industry, Account.AnnualRevenue
								FROM Contact WHERE AccountId !=null];
		for(Contact con : conList){
		//con.Account.Name gets field from the parent
		System.debug(con.FirstName + ' :: ' + con.LastName+ ':: '+con.AccountId +' :: '+ con.Account.Name+ ' :: '+ con.Account.Industry + ' :: '+con.Account.AnnualRevenue);
		}
		*/
        
        //3.Fetch all the contact details who have related accounts (It must have an AccountID)
        List<Contact> conList = [SELECT FirstName, LastName, Account.Name, Account.Industry, Account.AnnualRevenue
                                 FROM Contact WHERE AccountId =null];
        for(Contact con : conList){
            System.debug(con.FirstName + ' :: ' + con.LastName+ ':: '+con.AccountId +' :: '+ con.Account.Name+ ' :: '+ con.Account.Industry + ' :: '+con.Account.AnnualRevenue);
        }
        
    }
    public void parentToChildQueries(){
        //Account and Contact -> Fetch Account records along with their associated Contacts
        //Fetch all the Account Names along with or without their Contact Details
        /*
        List<Account> accList = [SELECT Name, (SELECT FirstName, LastName FROM Contacts)
                                 FROM Account];
        for(Account acc : accList){
            System.debug('--->'+acc.Name);
            
            for(Contact con: acc.Contacts){
                System.debug(con.FirstName+' :: '+ con.LastName);
            }
        }
		*/
        
        //Fetch all the Accounts that have Associated Contacts
        List<Account> accList = [SELECT Name
                                FROM Account
                                WHERE Id IN (SELECT AccountId
                                            FROM Contact)];
        for(Account acc : accList){
            System.debug(acc.Name);
        }
        /*
        //Fetch all the Accounts that DO NOT have Associated Contacts
        List<Account> accNoConList = [SELECT Name
                                FROM Account
                                WHERE Id NOT IN (SELECT AccountId
                                            FROM Contact)];
        for(Account acc : accNoConList){
            System.debug(acc.Name);
        }
		*/
    }
}
