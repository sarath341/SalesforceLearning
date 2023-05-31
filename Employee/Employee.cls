//private -> Sub Class, Test Class
//public -> Accessed within the org
//global -> Can be accessed from outside org.
//Class name is in PascalCase (First letter capital)
//Add Attributes like Basic, HRA (15% of Basic), DA (10% of Basic), Tax (Based on Gross <5 no tax), Gross, Net

//Pass empployee num, name and Basic
//Define Private Methods calculate tax based on Gross
//Calculate Gross (Basic+DA+HRA-Tax-PF(Deductions))
//Calculate DA
//Calculate HRA
//Calculate PF(12% of Basic)
//Calculate Deductions (PF+Tax)
//Calculate Net (Gross-Deductions)
//Display Data: Gross, Deductions and Net

public class Employee {
    //Defining attributes/properties-> Data/State
    //method without returntype and parameters
	
    //Class variables
    static String companyName='CCT';
    public static String getCompanyName(){
        //The below statement will lead to an error
        //Reason:
        //System.debug(empName);
        return companyName;
    }
    //Instance Variables
    String empName;
    Integer empNo;
    Decimal empBasic;
    
    //Instance Methods
    //When the instance variables names and parameters names are samee, the instance variable
    //will be hidden
    //this is called as 'Instance variable Hiding'
    //To overcome from this issue, we have to use 'this' explicitly 
    public void setData(String empName, Integer empNo, Decimal empBasic){
        this.empName=empName;
        this.empNo = empNo;
        this.empBasic=empBasic;
    }
    private void displayData(){
        System.debug(''+companyName);//Instance methods will have access to both static and non-static variables
        System.debug(''+empName);
        System.debug(''+empNo);
        System.debug(''+empBasic);
    }
    private void gross(){
        
    }
    private void DA(){
        
    }
    private void HRA(){
        
    }
    private void PF(){
        
    }
    private void Deductions(){
        
    }
    private void Net(){
        
    }
}
