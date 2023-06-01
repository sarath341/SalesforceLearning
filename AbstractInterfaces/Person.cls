virtual public class Person {
    //Instance Variables
    String name;
    Integer age;
    String gender;
    
    public void setData(String name, Integer age, String gender){
        this.name = name;
        this.age = age;
        this.gender = gender;
    }//end of setData
    //To override this method in sub type use virtual
    virtual public void displayData(){
        System.debug('Name: '+this.name);
        System.debug('Age: '+this.age);
        System.debug('Gender: '+this.gender);
    }//End of displayData
}//End of Class
