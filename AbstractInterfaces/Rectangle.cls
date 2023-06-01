public class Rectangle extends Figure {
    
    public Rectangle(Decimal dim1, Decimal dim2){
        super(dim1,dim2);
    }//End of Constructor
    
    override public Decimal area(){
        return dim1*dim2;
    }//End of area
    
}//End class Rectangle
