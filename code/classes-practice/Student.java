public class Student {
    //variables:
  	private String name;
  	private int studentID;
  	private double grade1;
  	private double grade2;


    //constructors:
  	public Student(){ //default constructor
        //the following default values will be assigned to a Pet
        this.name = "John Doe";
    }
    
    public Student(String name, int studentID, double grade1, double grade2){
        this.name = name;
        this.studentID = studentID;
        this.grade1 = grade1;
        this.grade2 = grade2;
    }

  	public void setName(String name){
        this.name = name;
    }
    public void setStudentID(int studentID){
        this.studentID = studentID;
    }
    public void setGrade1(double grade1){
        this.grade1 = grade1;
    }
    public void setGrade2(double grade2){
        this.grade2 = grade2;
    }

    public String getName(){
        return this.name;
    }
    public int getStudentID(){
        return this.studentID;
    }
    public double getGrade1(){
        return this.grade1;
    }
    public double getGrade2(){
        return this.grade2;
    }
    
    public double calculateAverage(){
        return (this.grade1 + this.grade2)/2;
    }
    public String toString(){
        String returnStr;
        returnStr = this.name + " " + this.studentID + " " + this.grade1 + " " + this.grade2;
        return returnStr;
    }
}