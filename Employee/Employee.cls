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
    Decimal empHra;//15%
    Decimal empDA;//10%
    Decimal empPF;//Deduction 12%
    Decimal empTax;//Deduction (Slabs)
    Decimal empGross;//empBasic+empHra+empDA
    Decimal netSal;//empBasic+empDA+-empTax-empPF
    //Instance Methods
    //When the instance variables names and parameters names are same, the instance variable will be hidden
    //this is called as 'Instance variable Hiding'
    //To overcome from this issue, we have to use 'this' explicitly 
    public void setData(String empName, Integer empNo, Decimal empBasic){
        this.empName=empName;
        this.empNo = empNo;
        this.empBasic=empBasic;
        System.debug('Set data as: '+empName+', '+empNo+', '+empBasic);
    }
    public void displayData(){
        System.debug('Company Name: '+companyName);//Instance methods will have access to both static and non-static variables
        System.debug('Employee Name: '+empName);
        System.debug('Employee No.: '+empNo);
        System.debug('Basic Salary: '+empBasic);
        HRA();
        DA();
        PF();
        //gross();
        Tax();
        grossSal();//with returntype
        netSal();//with returntype
    }

    private void HRA(){
        empHra=empBasic*0.1;
        System.debug('HRA(10%) is: '+empHra);
    }
    private void DA(){
        empDA=empBasic*0.1;
        System.debug('DA(10%) is: '+empDA);
    }
	//Deductions
    private void PF(){
        empPF=empBasic*0.12;
        System.debug('PF(12%) is: '+empPF);
    }
    private void Tax(){
        Decimal taxPercent;
        if(empBasic<300000){
            empTax=0;//Nil
            taxPercent = 0;
        }
        else if(empBasic>300000 && empBasic<600000){
        	empTax=(empBasic*0.05);//5%
            taxPercent = 5;
        }
        else if(empBasic>600000 && empBasic<900000){
        	//empTax=(empBasic*0.10);//10%
            taxPercent = 10;
            empTax=empBasic*(taxPercent/100);//10%
        }
        else if(empBasic>900000 && empBasic<1200000){
        	empTax=(empBasic*0.15);//15%
            taxPercent = 15;
        }
        else if(empBasic>1200000 && empBasic<1500000){
        	empTax=(empBasic*0.20);//20%
            taxPercent = 20;
        }
        else if (empBasic>1500000){
        	empTax=(empBasic*0.30);//30%
            taxPercent = 30;
        }
        
        System.debug('Tax is (Based on Slabs): '+empTax+' Tax % is:'+taxPercent+'%');
    }
    
    public Decimal grossSal(){
      	Decimal grossVar = empBasic+empHra+empDA;
        System.debug('Gross Salary is: '+grossVar);
        return grossVar;
    }
    public Decimal netSal(){
      	Decimal netVar = empBasic+empHra+empDA+-empTax-empPF;
        System.debug('Net Salary is: '+netVar);
        return netVar;
    }
    /*
    private void gross(){
       empGross = empBasic+empHra+empDA-empPF;
       System.debug('Gross is: '+empGross);
    }
    */
}
