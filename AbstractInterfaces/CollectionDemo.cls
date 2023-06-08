public class CollectionDemo {
    
    public static void listDemo(){
        List<Integer> intList = new List<Integer>();
        intList.add(23);
        intList.add(12);
        intList.add(45);
        intList.add(12);
        
        System.debug(intList);
        
        for(Integer x: intList){
            System.debug(x);
        }
        
    }
    public static void setDemo(){
        Set<Integer> intSet = new Set<Integer>();
        intSet.add(23);
        intSet.add(12);
        intSet.add(45);
        intSet.add(12);
        
        System.debug(intSet);
        
        for(Integer x: intSet){
            System.debug(x);
        }
    }
    public static void mapDemo(){
        Map<String,String> addressMap = new Map<String,String>();
        addressMap.put('street ', 'Wall Street');
        addressMap.put('city ', 'New York');
        addressMap.put('country ', 'USA');
        
        String key = 'street';
        if(addressMap.containsKey(key)){
            System.debug('addressMap get(key): '+addressMap.get(key));
        }
        else{
            System.Debug('Key not Found');
        }
        
        //To get keys from map, we use .keySet();
        Set<String> keys = addressMap.keySet();
        
        //To get keys from map, we use .values();
        List<String> valuesList = addressMap.values();
        
        //addressMap holds whole map values - addressMap: {city =New York, country =USA, street =Wall Street}
        System.debug('addressMap: '+addressMap);
        
        //Keys: {city , country , street }
        System.debug('keys: '+keys);
        
        //valuesList: (Wall Street, New York, USA)
        System.debug('valuesList: '+valuesList);
        
        for(String x:addressMap.keySet()){
            System.debug(addressMap.get(x));
        }
    }
}
