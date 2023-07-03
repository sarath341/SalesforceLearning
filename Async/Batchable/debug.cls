SchedulableAccountDemo demo = new SchedulableAccountDemo();
String cronExp = '0 15 10 ? * *';
System.schedule('Demo',cronExp, demo);
