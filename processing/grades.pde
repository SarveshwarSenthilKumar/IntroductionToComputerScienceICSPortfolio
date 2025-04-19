int grade = 90;

void setup(){
  println(returnLetterGrade(grade));
}

String returnLetterGrade(int grade){
  IntDict grades = new IntDict();
  
  //Creating a Grades Dictionary
  grades.set("F", 50);
  grades.set("D", 59);
  grades.set("C", 69);
  grades.set("B", 79);
  grades.set("A", 89);
  grades.set("A+", 100);
  
  if (grade<grades.get("F")){
    return "F";
  }
  else if (grade<=grades.get("D")){
    return "D";
  }
  else if (grade<=grades.get("C")){
    return "C";
  }
  else if (grade<=grades.get("B")){
    return "B";
  }
  else if (grade<=grades.get("A")){
    return "A";
  }
  else {
    return "A+";
  }
 }