public class CollectionDemo {
    //For static method we don't need to create an instance variable instead call by Classname, Eg: classname.methodname()
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
            System.debug(addressMap.get(key));
        }
        else{
            System.Debug('Key not Found');
        }
        Set<String> keys = addressMap.keySet();
        List<String> valuesList = addressMap.values();
        
        System.debug(addressMap);
        System.debug(keys);
        System.debug(valuesList);
        
        for(String x:addressMap.keySet()){
            System.debug(addressMap.get(x));
        }
    }
}
