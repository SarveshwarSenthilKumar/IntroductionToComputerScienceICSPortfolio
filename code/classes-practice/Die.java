

public class Die {
    int faceValue; 
    int options;
    int minimum;
    
    public Die(){
        this.faceValue = -1;
        this.options = 6;
        this.minimum = 1;
    }
    public Die(int faceValue, int options, int minimum){
        this.faceValue = faceValue;
        this.options = options;
        this.minimum = minimum;
    }
    
    public int roll(){
        this.faceValue = (int)(Math.random()*options) + minimum;
        return this.faceValue;
    }
    public int getRoll(){
        return this.faceValue;
    }
    public void setOptions(int number){
        this.options = number;
    }
    public void setFaceValue(int faceValue){
        this.faceValue = faceValue;
    }
}