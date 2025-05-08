

public class arrays {
    public static void main(String[] args){
        int[] studentGrades = {90, 50, 78, 99, 100};
        double total = 0;
        for (int i = 0; i < studentGrades.length; i++){
            total += studentGrades[i];
        }
        System.out.println("The average is: " + (total/studentGrades.length));
    }
}
