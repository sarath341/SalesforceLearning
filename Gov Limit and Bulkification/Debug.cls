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
for(Account acc: accList){
    acc.Rating = 'Cold';
}
update accList;

//Update half of demo acc to Prospect and Another half to Analyst ALTERNATIVELY
List<Account> accList = [SELECT Id
                         FROM Account
                         WHERE Name LIKE 'Demo%'];
Integer i=0;
for(Account acc: accList){
    
    //If Odd mod result will be 0 hence EVEN
    if(Math.Mod(i, 2) == 0){
        acc.Type = 'Prospect';
        //System.debug('Prospect:'+i);
    }
    //If Odd mod result will be 1 hence ODD
    else if(Math.Mod(i, 2) == 1){
        acc.Type = 'Analyst';
        //System.debug('Analyst:'+i);
    }
    i++;
}
update accList;
