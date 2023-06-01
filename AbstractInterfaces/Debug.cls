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
