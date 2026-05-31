public class MyProgram
{
    
    public static void main(String[] args)
    {
        /*
         // main method to test written code
         
         // checking the factorial digit sum method for 4
         System.out.println(factorialDigitSum(4));
         
         // initializing an original grid
         char[][] originalGrid = {{'.', '.', '.', '#', '.'}, {'.', '#', '.', '#', '#'}, {'.', '.', '.', '.', '.'}, {'#', '#', '.', '#', '#'}};
         
         // methods to test the FloodFill class with print grid method and fill method
         FloodFill grid1 = new FloodFill(originalGrid);
         grid1.printGrid();
         System.out.println();
         grid1.fill(0,0,'.','@');
         grid1.printGrid();
         
         // testing tribonacci and sumtribonacci methods with the value of 4
         System.out.println("\n" + tribonacci(4));
         System.out.println("\n" + sumTribonacci(4));
         
         // testing the is palindrome method
         System.out.println(isPalindrome("Racecar")); //returns true
         System.out.println(isPalindrome("Hello")); //returns false
         System.out.println(isPalindrome("A man a plan a canal Panama"));  //returns true
         */
    }
    
    //Recursive Factorial Digit Sum: Write a recursive method int factorialDigitSum(int n) that returns the sum of the digits of n!(n factorial).
    
    public static int fact(int n) {
          
          // base cases
          if (n<0){
              return -1;
          }
         
          if (n <= 1) {
               return 1;
          }
          
          // recursive case which gets the factorials from the preceding sequence
        
          else {
               int temp = fact(n-1);
               
               return n * temp;
          }
     }
    
    public static int factorialDigitSum(int n){
        // changing number input into a string
        String num = String.valueOf(fact(n));
        
        // creating a sum counter
        int sum = 0;
        
        // for each digit in the number, the digit is added to the sum variable and returned
        for (int i = 0; i<num.length(); i++){
            sum+=Integer.parseInt(String.valueOf(num.charAt(i)));
        }
        
        return sum;
    }
    
    
    /*Write a recursive method int tribonacci(int n) that returns the n-th Tribonacci number.
The Tribonacci sequence is defined as: T(0) = 0, T(1) = 1, T(2) = 1, and T(n) = T(n-1) + T(n-2) + T(n-3)
B. Write a method int sumTribonacci(int n) that returns the sum of all Tribonacci numbers up to 
index n. For example, sumTribonacci(4) returns 8 (0 + 1 + 1 + 2 + 4).*/
    public static int tribonacci(int n){
        switch (n){
            // initial base cases which recursively gets the last three numbers of the tribonacci index and adds them together
            case 0:
                return 0;
            case 1:
                return 1;
            case 2:
                return 1;
            default:
                return tribonacci(n-1)+tribonacci(n-2)+tribonacci(n-3);
        }
    }
    public static int sumTribonacci(int n){
        switch (n){
            // check for base case 0 and if not get the sum of tribonacci from the last iteration recursively and add the current tribonacci of n to it
            case 0:
                return 0;
            default:
                return sumTribonacci(n-1)+tribonacci(n);
        }
    } 
    
    /*Recursive Palindrome Checker
Create a recursive method boolean isPalindrome(String s) that returnstrue if the inputstring 
is a palindrome (ignoring spaces and case), and false otherwise.*/
    public static boolean isPalindrome(String s){
        // replacing all spaces with blank slot and switch to lower case
        s = s.replace(" ", "").toLowerCase();
        
        // if string length is 1, return true
        if (s.length() == 1){
            return true;
        }
        
        // if first character and last character is not the same, return false
        if (s.charAt(0) != s.charAt(s.length()-1)){
            return false;
        }
        
        // recursively check whether the string going from outer to inner is a palindrome
        return isPalindrome(s.substring(1, s.length()-1));
    }
    
    
}