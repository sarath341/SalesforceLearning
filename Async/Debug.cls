FutureDemo.getReady();
FutureDemo.doBreakfast();
FutureDemo.printPhotoAlbum();
FutureDemo.doWork();

List<Account> accList = new List<Account>();
for(Integer i=1001; i<=5000; i++){
    Account acc = new Account();
    acc.Name = 'Demo'+i;
    accList.add(acc);
}

insert accList;

FutureAccountDemo.updateAccountType();
