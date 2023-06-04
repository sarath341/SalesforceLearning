public class SimpleCalculator {
//Define methods to perform basic Arithmetic Operations

    //Public Method (accessed within your org) without Returntype and Parameter
    public void add(){
        //Defining Attributes
        Integer x=20, y= 10;
        
        //Performing Operations
        Integer z = x+y;
        
        //Display the result on log
        System.debug('Result of Addition: '+z);
    }
    
    //Public Method (within your org) without Parameter and Returntype
    public void sub(){
        Integer x = 20, y=10;
        Integer z=x-y;
        System.debug('Result of Subtraction: '+z);
    }
    
    //Public Method (within your org) without Parameter and Returntype
    public void multiply(){
        Integer x = 30, y=2;
        Integer z = x*y;
        System.debug('Result of Multiplication: '+z);
    }
    
    //Public Method (within your org) without Parameter and Returntype
    public void divide(){
        Integer a = 20, b= 2;
        Integer c = a/b;
        System.debug('Result of Division: '+c);
    }
    
    //Public Method (within your org) with Parameters and No Returntype(void)
    public void paraAdd(Integer a,Integer b){
	Integer c=a+b;
        System.debug('Result of Add with Parameter: '+c);
    }
    
    //Public Method (within your org) with Parameter and Returntype
    public Integer paraSub(Integer i,Integer j){
        Integer num = i-j;
        return num;
    }
}
