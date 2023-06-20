/*Trigger Context Variables*/

//Trigger.new - List of New Version of sObjects (Insert, Update, Undelete) - Before Triggers Only
//Trigger.newMap - Holds the 'Map of IDs' of new Version of sObjects(Before Update, After Insert, After Update, and After Undelete)
//Trigger.old - List of Old Version of sObjects (Update, Delete)
//Trigger.oldMap - Holds the 'Map of IDs' of Old Version of sObjects(Update, Delete)
//IsInsert, IsUpdate, isDelete, isUndelete, isExecuting are Boolean Context var due to the specific operation
//operationType - (System.TriggerOperation) can be used with 'Switch' statement based on programming Logic

[Reference Document
](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_context_variables.htm)
