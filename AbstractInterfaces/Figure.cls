//If a class has even one abstract method then the class
//has to be defined as abstract
abstract public class Figure {
	
    protected Decimal dim1, dim2;
    public Figure(Decimal dim1, Decimal dim2){
        this.dim1= dim1;
        this.dim2= dim2;
    }
    //Every sub class must implement abstract methods
    //Otherwise the class has to be declared as abstract
    abstract public Decimal area(); //No Implemtntation
}
