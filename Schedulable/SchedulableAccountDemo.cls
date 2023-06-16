public class SchedulableAccountDemo implements Schedulable{
    public void execute(SchedulableContext sc){
        BatchableAccountDemo demo = new BatchableAccountDemo();
        Database.executeBatch(demo, 500); //Max batch size is 2K
    }
}
