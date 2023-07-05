trigger parentChildTrigger on Account (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        //parentChildStatusUpdate.updateTypeField(Trigger.new);
        parentChildStatusUpdate.handleUpdate(Trigger.new);
    }
}
