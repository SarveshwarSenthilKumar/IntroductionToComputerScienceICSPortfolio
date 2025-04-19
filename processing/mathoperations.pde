//This is a template for your task

// Declare variables
float radius;           // For the circle
float base;             // For the triangle
float height;           // For the triangle
float rectangleWidth;   // For the rectangle
float rectangleHeight;  // For the rectangle

void setup() {
    //Task 1
    // Initialize the variables, notice they are decimal values
    radius = 5.0;  
    base = 4.0;    
    height = 3.0;  
    rectangleWidth = 6.0;  
    rectangleHeight = 2.0;  
    
    // Determine the following:
    println("Circumference: " + 2*PI*radius);
    println("Area of Triangle: " + base*height/2);
    println("Area of Rectangle: " + rectangleWidth*rectangleHeight);
    println("Perimeter of Rectangle: " + (rectangleWidth*2+rectangleHeight*2));  
    
    //Task 2
    float x = 5.0; //initialize x to 5
    float y; 
    
    y = pow(x,2); //initialize y to squared x
    println(y); // 25.0 will be printed - 5.0 times 5.0
    //type the given expressions below:
    println(pow(x,2));
    println(pow(4,2));
    println(pow(x,2)+5);
    println(pow(x-2,4));
    println(pow(x-4,2)/3);
    
    //Task 3
    //sqrt(x) practice
    //declare variables x, y
    float x2 = 25.0; //initialize x to 25.0
    float y2; 
    
    y2 = sqrt(x2); //initialize y to square root of x
    //type the given expressions below:
    println(y2);
    println(sqrt(16));
    println(sqrt(x2));
    println(pow(sqrt(x2), 2));
    println(sqrt(pow(3,2)));
    println(sqrt(pow(3,2)+pow(5,2)));
    println(sqrt(pow(x2-2,2)+pow(x2+2,2)));
    
    //Task 4
    //Declare variables
    float C = 25.0; //initialize the temp in Celcius to 25.0
    float F; //variable for the temp in Fahrenheit
    // Your code goes below:
    F = ((9.0/5.0)*C)+32;

    println(F);
    
    //Task 5
    //Declare variables
    float C2;
    float F2 = 75.0; 
    //Your code goes below:
    C2 = (F2-32)*((5.0/9.0));
  
    println(C2);
    
    //Task 6
    //Declare variables
    int birth_year = 1999; 
    int current_year = 2025;
    int age; 
    //Your code goes below
    age = current_year-birth_year;
    
    println(age);

}