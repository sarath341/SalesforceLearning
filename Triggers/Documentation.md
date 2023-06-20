<H2>Trigger Context Variables</H2>
<ul>
<li>Trigger.new - List of New Version of sObjects (Insert, Update, Undelete) - Before Triggers Only</li>
<li>Trigger.newMap - Holds the 'Map of IDs' of new Version of sObjects(Before Update, After Insert, After Update, and After Undelete)</li>
<li>Trigger.old - List of Old Version of sObjects (Update, Delete)</li>
<li>Trigger.oldMap - Holds the 'Map of IDs' of Old Version of sObjects(Update, Delete)</li>
<li>IsInsert, IsUpdate, isDelete, isUndelete, isExecuting are Boolean Context var due to the specific operation</li>
<li>operationType - (System.TriggerOperation) can be used with 'Switch' statement based on programming Logic</li>
<li>size - Total Number of Records in Trigger Operation</li>
</ul>
[Reference Document
](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_context_variables.htm)
