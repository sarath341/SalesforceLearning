public class Triangle extends Figure{
    public Triangle(Decimal dim1, Decimal dim2){
        super(dim1,dim2);
    }//End of Constructor
    
    override public Decimal area(){
        return (dim1*dim2)/2;
    }//End of area
    
}//End class Rectangle
