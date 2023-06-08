//To check the order of execution from child to parent(Applicants) also a custom validation (validation Rules)
trigger JobApplicationTrigger on Job_Application__c (before insert,before update,before delete, after insert, after update, after delete, after undelete) {
    
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            System.debug('BEFORE_INSERT from Job_Application__c');
        }
        when BEFORE_UPDATE{
            System.debug('BEFORE_UPDATE from Job_Application__c');
        }
        when BEFORE_DELETE{
            System.debug('BEFORE_DELETE from Job_Application__c');
        }
        when AFTER_INSERT{
            System.debug('AFTER_INSERT from Job_Application__c');
        }
        when AFTER_UPDATE{
            System.debug('AFTER_UPDATE from Job_Application__c');
        }
        when AFTER_DELETE{
            System.debug('AFTER_DELETE from Job_Application__c');
        }
        when AFTER_UNDELETE{
            System.debug('AFTER_UNDELETE from Job_Application__c');
        }
    }//switch
}//Trigger
