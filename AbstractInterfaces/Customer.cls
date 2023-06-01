public class Customer extends Person{
	String phoneNumber;//Additional variable as required
    String custID;//Additional variable as required
    //Method Overloading -> Signature Differs
    public void setData(String name, Integer age, String gender, String phoneNumber, String custID){
        super.setData(name,age,gender);
        this.phoneNumber = phoneNumber;
        this.custId = custID;
    }
    //To Override super type method use override keyword
    override public void displayData(){
        super.displayData();
        System.debug('Phone Number '+this.phoneNumber);
        System.debug('Customer Id '+this.custId);
    }
}
