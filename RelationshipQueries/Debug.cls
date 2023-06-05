//Insert an Account and a Contact that is associated with the account
Account acc = new Account(Name='Parent Account');
insert acc;

Contact c1 = new Contact(LastName='Contact1', FirstName='Child',AccountId=acc.Id);
Contact c2 = new Contact(LastName='Contact2', FirstName='Child',AccountId=acc.Id);
insert c1;//Use bulkification to reduce the DML
insert c2;//Use bulkification to reduce the DML

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

//Child to Parent RelationShip Query
RelationshipQueriesDemo rq = new RelationshipQueriesDemo();
rq.childToParentQueries();

//Parent to Child RelationShip Query
RelationshipQueriesDemo rq = new RelationshipQueriesDemo();
rq.parentToChildQueries();
