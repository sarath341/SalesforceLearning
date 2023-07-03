System.debug('This is a Govt Limit test');

//Create 1000 Account Records
//Bulkification
List<Account> accList = new List<Account>();

for(Integer i=1; i<=1000; i++){
    Account acc = new Account(Name='Demo'+i);
    accList.add(acc);
}
//DML
insert accList;

//Fetch Demo Accounts and update all of them with Rating as 'Cold'
List<Account> accList = [SELECT Id
                         FROM Account
                         WHERE Name LIKE 'Demo%'];
//Traversing the List
for(Account acc: accList){
    acc.Rating = 'Cold';
}
update accList;

//Update half of demo acc to Prospect and Anothe half to Analyst (500+500)
List<Account> accList = [SELECT Id
                         FROM Account
                         WHERE Name LIKE 'Demo%'];
Integer i=0;
for(Account acc: accList){
    
    if(Math.Mod(i, 2) == 0){
        acc.Type = 'Prospect';
        System.debug('Prospect:'+i);
    }
    else if(Math.Mod(i, 2) == 1){
        acc.Type = 'Analyst';
        System.debug('Analyst:'+i);
    }
    i++;
}
update accList;

//Show the Accounts from NY,MA,NJ,PA with either Rating as Hot or
//Annual Revenue greater than 5M
//IN is used instead of OR to reduce more OR operations
List<Account> accList = [SELECT Id, BillingState, Name, Rating, AnnualRevenue
                         FROM Account
                         WHERE BillingState IN ('NY','MA','NJ','PA')
                         AND (Rating='Hot' OR AnnualRevenue>5000000)];
//Traverse one by one with acc until accList
for(Account acc:accList){
    System.debug(acc.Name+' '+acc.BillingState+' '+acc.Rating+' '+acc.AnnualRevenue);
}

//Show 'New' Cases Status with Priority High or Medium
List<Case> caseList = [SELECT Id, CaseNumber, Status, Priority 
                       FROM Case
                       WHERE Status='New' AND (Priority='High' OR Priority='Medium')];
//Traverse one by one with caseL until caseList
for(Case caseL:caseList){
    System.debug(caseL.CaseNumber+' '+caseL.Status+' '+caseL.Priority);
}

//Show the count of all the Accounts (including the one from recycle bin);
Integer count = [SELECT count()
                 FROM Account
                 ALL ROWS];//All rows must be at the end
System.debug(count);

//Show the count of deleted Accounts (in recycle bin);
Integer count = [SELECT count()
                 FROM Account
                 WHERE isDeleted = true
                 ALL ROWS];
System.debug(count);

//SOSL - Salesforce Object Search Language
List<List<sObject>> records = [FIND 'Acme*'
                               RETURNING Opportunity(Name, StageName, CloseDate, Amount),
                               Account (Name,Type,AnnualRevenue)];
//Whatever we are returning first, that will be on 0th index
List<Opportunity> oppList = records[0]; //Returning first in query (0th Index)
List<Account> accList = records[1]; //Returning 2nd in query (1st Index)

for(Opportunity opp: oppList){
    System.debug('Opportunity Records: '+ opp.Name +', '+ opp.StageName+', '+opp.CloseDate+', '+opp.Amount);
}
for(Account acc: accList){
    System.debug('Account Records: '+ acc.Name +', '+ acc.Type +', '+acc.AnnualRevenue);
}

DMLDemo.databaseDMLDemo();

//Insert an Account and a Contact that is associated with the account
Account acc = new Account(Name='Parent Account');
insert acc;

Contact c1 = new Contact(LastName='Contact1', FirstName='Child',AccountId=acc.Id);
Contact c2 = new Contact(LastName='Contact2', FirstName='Child',AccountId=acc.Id);
insert c1;
insert c2;

//Use List sObject to perform bulk operations on multiple types of Objects (Generic DML)
//Pushing unrelated no problem, but related will cause issue due to one go
List<sObject> objList = new List<sObject>();
Account acc = new Account(Name='Parent Account 22');
Contact c1 = new Contact(LastName='Contact33',AccountId=acc.ID);
Contact c2 = new Contact(LastName='Contact44',AccountId=acc.ID);
objList.add(acc);
objList.add(c1);
objList.add(c2);
objList.add(new Lead(LastName='Apex Lead', Company='ABC'));
insert objList;
