Customer customer1 = new Customer();
customer1.setData('Sarath', 30, 'Male','5353535353','C101');
customer1.displayData();

//Supertype reference can refer sub type instance
Figure ref;
ref = new Rectangle(100,200);
System.debug('Area of Rectangle '+ref.area());

ref = new Triangle(100,200);
System.debug('Area of Triangle '+ref.area());

CollectionDemo.listDemo();
CollectionDemo.setDemo();

//SOQL Queries
//Square Bracketed Expression
//Return Types -> 3
//Return a List of sObjects -> sObject represents a record in the database
List<Account> accList = [SELECT Name, Type, Rating, Industry FROM Account];

for(Account acc: accList){
    System.debug(acc.Name+' ' +acc.Type+' ' +acc.Rating+' ' +acc.Industry);
    }
//Return a Single sObject
Account acc = [SELECT Name FROM Account WHERE Id='0015i00000fonIqAAI'];
System.debug(acc.Name);
//Return an Integer
Integer accCount = [SELECT count() FROM Account];
System.debug(accCount);

//Show only Account with Rating as'Hot' or AnnualRevenue>5M
List<Account> accList = [SELECT Name, Type, Rating, Industry FROM Account WHERE Rating = 'Hot' OR AnnualRevenue<50000000];

for(Account acc: accList){
    System.debug(acc.Name+' ' +acc.Type+' ' +acc.Rating+' ' +acc.Industry);
    }

//Show top 5 Accounts based on Annual Revenue
List<Account> accList = [SELECT Name, AnnualRevenue 
                         FROM Account
                         WHERE AnnualRevenue !=null
                         ORDER BY AnnualRevenue DESC
                         LIMIT 5];
for(Account acc: accList){
    System.debug(acc.Name+' ' +acc.AnnualRevenue);
    }

//Show High value Opportunities with Stage Closed Won
List<Opportunity> oppList = [SELECT Name, StageName, CloseDate, Amount
                         FROM Opportunity
                         WHERE StageName = 'Closed Won'
                         ORDER BY Amount DESC
                         LIMIT 5];
for(Opportunity opp: oppList){
    System.debug(opp.Name+','+opp.StageName+',' + opp.Amount);
    }
