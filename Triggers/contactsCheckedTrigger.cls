trigger contactsCheckedTrigger on Contact(after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        contactsChecked.massUpdateStatus(Trigger.new);
    }
}
