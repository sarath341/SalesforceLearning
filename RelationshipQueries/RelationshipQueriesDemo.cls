public class RelationshipQueriesDemo {
    public void childToParentQueries(){

//Contact and Account -> Fetch Contact record details along with Accounts   
//1. Fetch all the Contacts details along with their account names

/*
List<Contact> conList = [SELECT FirstName, LastName, Account.Name, Account.Industry, Account.AnnualRevenue
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

/*
//Opportunity
//1. Fetch all the Opportunities details along with their account names
List<Opportunity> oppsWithAccount =  [SELECT Name, Account.Name FROM Opportunity];
    
    for(Opportunity opp:oppsWithAccount){
        System.debug(opp.Name+'::'+opp.Account.Name);
    }
*/
        
}//End of childToParentQueries()
    
    public void parentToChildQueries(){
        
//Account and Contact -> Fetch Account records along with their associated Contacts
//1. Fetch all the Account Names along with or without their Contact Details
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
        
/*
//2. Fetch all the Accounts that have Associated Contacts
List<Account> accList = [SELECT Name
FROM Account
WHERE Id IN (SELECT AccountId
FROM Contact)];
for(Account acc : accList){
System.debug(acc.Name);
}

*/
        
/*
//3. Fetch all the Accounts that DO NOT have Associated Contacts
List<Account> accNoConList = [SELECT Name
FROM Account
WHERE Id NOT IN (SELECT AccountId
FROM Contact)];
//Traverse & Display List of Accounts from the accNoConList
for(Account acc : accNoConList){
System.debug(acc.Name);
}
*/
        //Opportunities
        //Cases
        /*

//4. Fetch all the Accounts that have Associated Opportunities
List<Account> accWithOppList = [SELECT Name 
FROM Account
WHERE Id IN (SELECT AccountId
FROM Opportunity)
];
for(Account acc : accWithNoOppList){
System.debug(acc.Name);
}
*/
        
        /*
//5. Fetch all the Accounts that DO NOT have Associated Opportunities
List<Account> accWithNoOppList = [SELECT Name 
FROM Account
WHERE Id NOT IN (SELECT AccountId
FROM Opportunity)
];
for(Account acc : accWithNoOppList){
System.debug(acc.Name);
}

*/

/*        
//6. Fetch all the Accounts that have Associated Cases
        List<Account> accWithCaseList = [SELECT Name 
                                         FROM Account
                                         WHERE Id IN (SELECT AccountId
                                                      FROM Case)
                                        ];
        for(Account acc : accWithCaseList){
            System.debug(acc.Name);
            
        }
*/
/*        
//7. Fetch all the Accounts that DO NOT have Associated Cases
        List<Account> accWithNoCaseList = [SELECT Name 
                                           FROM Account
                                           WHERE Id NOT IN (SELECT AccountId
                                                            FROM Case)
                                          ];
        for(Account acc : accWithNoCaseList){
            System.debug(acc.Name);
            
        }
 
*/

//CustomObjects - Fetch all the Applicants that have Associated Job Application
List<Position__c> appl = [SELECT Name 
                       FROM Position__c
                       WHERE Id IN (SELECT Position__c
                                   FROM Job_Application__c)];
        for(Position__c al:appl){
            System.debug(al.Name);
        }
    }
}
