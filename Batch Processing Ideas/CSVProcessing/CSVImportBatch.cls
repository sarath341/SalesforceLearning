public class CSVImportBatch implements Database.Batchable<String>, Database.Stateful{
    private List<String> base64Data;
    private Map<Integer, String> headerMap;

    public CSVImportBatch(List<String> base64Data, Map<Integer,String> headerMap){
        this.base64Data = base64Data;
        this.headerMap = headerMap;
    }

    public Iterable<String> start(Database.BatchableContext BC){
        return base64Data;
    }

    public void execute(Database.BatchableContext BC, List<String> scope){
        Map<String, List<String>> csvRowDataMap = csvRowData(scope);
        System.debug('Execute--->'+csvRowDataMap);

    }

    public void finish(Database.BatchableContext BC){
        System.debug('Finish');
    }

    public static Map<String, List<String>> csvRowData(List<String> csvLines){
        Map<String,List<String>> csvRowDataMap = new Map<String, List<String>>();
        for(Integer i=0; i<csvLines.size(); i++){
            csvLines[i] = csvLines[i].replaceAll(':quotes:','').replaceAll(':comma:', ',');
            List<String> csvRowData = new List<String>(csvLines[i].split(','));
            csvRowDataMap.put(String.valueOf(i), csvRowData);
        }
        return csvRowDataMap;
    }

    public static void processInsertRecords(List<SObject> records) {
        // Define the batch size for DML operations
        Integer batchSize = 200;

        for (Integer startRow = 0; startRow < records.size(); startRow += batchSize) {
            Integer endRow = Math.min(startRow + batchSize, records.size());

            List<SObject> batchRecords = new List<SObject>();
            for (Integer i = startRow; i < endRow; i++) {
                batchRecords.add(records[i]);
            }

            try {
                // Perform the DML operation in a batch
                insert batchRecords;
            } catch (DmlException e) {
                // Handle any DML exceptions, such as validation rules or triggers
                for (Integer j = 0; j < e.getNumDml(); j++) {
                    System.debug('Error on record ' + (startRow + j) + ': ' + e.getDmlMessage(j));
                }
            }
        }
    }

    public static void processQuery(String soqlQuery) {
        // Define the batch size for query execution
        Integer batchSize = 200;

        // Execute the SOQL query
        List<SObject> records = Database.query(soqlQuery);

        for (Integer startRow = 0; startRow < records.size(); startRow += batchSize) {
            Integer endRow = Math.min(startRow + batchSize, records.size());
            System.debug('endRow: '+endRow);
            List<SObject> batchRecords = new List<SObject>();
            for (Integer i = startRow; i < endRow; i++) {
                batchRecords.add(records[i]);
            }

            // Process the batch of records
            processUpdateBatch(batchRecords);
        }
    }

    private static void processUpdateBatch(List<SObject> records) {
        System.debug(records);
        String objectName = records[0].getSObjectType().getDescribe().getName();
        // Your processing logic for the batch of records goes here
        List<Account> accList = new List<Account>();
        for (SObject record : records) {
            if(record instanceof Account){
                Account acc = (Account)record; //Process each record with account type instead of creating another list
                // Process each record as needed
                acc.Industry = 'Banking';
                accList.add(acc);
            }
            else{
                System.debug('No Matching sObject to process');
            }
        }
        System.debug(accList);
        System.debug(Limits.getHeapSize());
        update accList;
    }

}
