public class QueueableAccountDemo implements Queueable {
    public void execute(QueueableContext qc){
        //First Job
        List<Account> accList = [SELECT Id
                                FROM Account
                                WHERE Name LIKE 'Demo%'];
        for(Account acc: accList){
            acc.Type = 'Analyst';
        }
        update accList;
        
        //Chaining can be done from here - can call another Queueable from here (using AsyncApexJob Object)
        AsyncApexJob job = [SELECT Status
                           FROM AsyncApexJob
                           WHERE Id = :qc.getJobId()];
        System.debug(job.Status);
        //Using the job.Status we can chain another method
    }
}

/* Call this from Ananymous Window
 * QueueableAccountDemo demo = new QueueableAccountDemo();
 * System.enqueueJob(Demo);
 * 
 */
