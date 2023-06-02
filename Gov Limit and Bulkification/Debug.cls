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
