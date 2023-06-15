public class FutureDemo {
    public static void getReady(){
        System.debug('Getting Ready...');
    }
    public static void doBreakfast(){
        System.debug('Completing my breakfast...');
    }
    public static void doWork(){
        System.debug('Busy doing work in the office...');
    }
    @future
    public static void printPhotoAlbum(){
        System.debug('Photo Album is getting printed...');
    }
    @future
    public static void deoVehicleService(){
        System.debug('Vehicle is getting serviced...');
        //printPhotoAlbum(); //Future Method cannot call another future method
    }    
}
