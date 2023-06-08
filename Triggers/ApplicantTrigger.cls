trigger ApplicantTrigger on Applicant__c (before insert,before update,before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.OperationType{
        when BEFORE_INSERT{
           System.debug('BEFORE_INSERT from Applicant__c');
        }
        when BEFORE_UPDATE{
            System.debug('BEFORE_UPDATE from Applicant__c');
        }
        when BEFORE_DELETE{
            System.debug('BEFORE_DELETE from Applicant__c');
        }
        when AFTER_INSERT{
            System.debug('AFTER_INSERT from Applicant__c');
        }
        when AFTER_UPDATE{
            System.debug('AFTER_UPDATE from Applicant__c');
        }
        when AFTER_DELETE{
            System.debug('AFTER_DELETE from Applicant__c');
        }
        when AFTER_UNDELETE{
            System.debug('AFTER_UNDELETE from Applicant__c');
        }
    }//switch
}//Trigger
