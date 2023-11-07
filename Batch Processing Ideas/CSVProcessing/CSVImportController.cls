public class CSVImportController {
    
    //To Process Stringified JSON File to List of String and Create a batch apex to process records
    @AuraEnabled
    public static void sendFileToSF(String base64Data){
        System.debug('Stringified--->'+base64Data);
        //Desrialize JOSN with Apex Type as List<String> using .class (Describe whatever passed datatype as its datatype)
        List<String> data = (List<String>) JSON.deserialize(base64Data, List<String>.class);
        System.debug('Deserialized--->'+data);

        //To extract header from CSV File with Index in Map
        Map<Integer,String> headerMap = new Map<Integer, String>();
        String csvHeaderLine = data[0];
        Integer mapID = 0;
        for(String headerString : csvHeaderLine.split(',')){
            headerString = headerString.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
            headerMap.put(mapID, headerString.trim());
            mapID++;
        }
        data.remove(0);
        CSVImportBatch batch = new CSVImportBatch(data, headerMap);
        Database.executeBatch(batch,200);
    }
}
