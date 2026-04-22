public class MyRectangle {
    // Variable:
    private float length;
    private float width;
    private String measurementUnits; 
    
    public MyRectangle(){
        this.length = 1;
        this.width = 1;
        this.measurementUnits = "Inches";
    }
    public MyRectangle(float length, float width, String measurementUnits){
        this.length = length;
        this.width = width;
        this.measurementUnits = measurementUnits;
    }
    
    public float calculateArea(){
        return this.length*this.width;
    }
    public float calculatePerimeter(){
        return 2*this.length + 2*this.width;
    }
    public boolean checkSquare(){
        if (this.width == this.length){
            return true;
        }
        else{
            return false;
        }
    }
    
    
    
    
}