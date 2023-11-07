Integer batchSize = 200;
List<Account> accList = [SELECT Id, Name, Industry FROM Account];
//Batch For loop - increments each iteration by batchSize (200)
for (Integer startRow = 0; startRow < accList.size(); startRow += batchSize) {
    Integer endRow = Math.min(startRow + batchSize, accList.size());
    Integer startBatchTotal = startRow + batchSize;
    System.debug('Outer Start Row: '+startRow+' Outer endRow: '+ endRow+' startRow + batchSize: '+ startBatchTotal +' accListSize: '+accList.size());
    
    //Record for Loop - updated endRow from Batch For Loop, so the condition true until all records finished
    List<SObject> batchRecords = new List<SObject>();
    for (Integer i = startRow; i < endRow; i++) {
        batchRecords.add(accList[i]);
        System.debug('i Value:'+i +' Inner Start Row: '+startRow+' Inner endRow: '+endRow);
    }
    
    // Process the batch of records
    //processBatch(batchRecords);
    //System.debug('Call the Method: '+batchRecords);
}
