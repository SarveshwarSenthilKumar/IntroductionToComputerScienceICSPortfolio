
public class arrays {
    public static void main(String[] args){

        // Calculate the average of an array of student grades
        /* 
        int[] studentGrades = {90, 50, 78, 99, 100};
        double total = 0;
        for (int i = 0; i < studentGrades.length; i++){
            total += studentGrades[i];
        }
        System.out.println("The average is: " + (total/studentGrades.length));
        */

        // Taxk 1
        /* 
        String[] questions = new String[20];
        boolean[] answers = new boolean[20];
        long[] populationSizes = new long[20];
        */

        // Task 2
        /* 
        String[] classes = {"Functions", "Physics", "Computer Science", "French"};
        for (int i =0; i<classes.length; i++){
            System.out.println("Class " + (i+1) + ": " + classes[i]);
        }
        */

        // Task 3
        /* 
        int[] marks = {70, 55, 80, 92, 10};
        while (true){
            Scanner input = new Scanner(System.in);
            System.out.print("Enter a mark to change, and the mark to replace it with (Format: 0 71): ");
            String[] inputArray = (input.nextLine()).split(" ");
            int index = Integer.parseInt(inputArray[0]);
            int newMark = Integer.parseInt(inputArray[1]);
            if (index < 0 || index >= marks.length){
                System.out.println("Invalid index. Please try again.");
                continue;
            }
            marks[index] = newMark;
            System.out.println("Updated marks: ");
            for (int i = 0; i < marks.length; i++){
                System.out.print(marks[i] + " ");
            }
            System.out.println();
            System.out.print("Do you want to change another mark? (yes/no): ");
            String playAgain = (input.nextLine()).toLowerCase();
            if (playAgain.equals("no")){
                System.out.println("Thanks for playing!");
                break;
            }
        }

        System.out.println(marks[3]);

        int highestMark = 0;
        for (int i = 0; i < marks.length; i++){
            if (marks[i] > highestMark){
                highestMark = marks[i];
            }
        }
        System.out.println("The highest mark is: " + highestMark);
        */

        // Task 4
        /* 
        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        while (true){
            Scanner input = new Scanner(System.in);
            System.out.print("Enter a day of the week (1-7): ");
            int dayNumber = input.nextInt();
            System.out.println("The day is: " + days[dayNumber - 1]);
            if (dayNumber < 1 || dayNumber > 7){
                break;
            }
        }
        */

        // Task Maximum... Minimum...
        /* 
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the number of elements in the array: ");
        int n = scanner.nextInt();

        int[] numbers = new int[n];
        System.out.println("Enter " + n + " numbers:");
        for (int i = 0; i < n; i++) {
            numbers[i] = scanner.nextInt();
        }

        int min = numbers[0];
        int max = numbers[0];
        int sum = numbers[0];

        for (int i = 1; i < n; i++) {
            if (numbers[i] < min) {
                min = numbers[i];
            }
            if (numbers[i] > max) {
                max = numbers[i];
            }
            sum += numbers[i];
        }

        double average = (double) sum / n;

        System.out.println("Smallest number: " + min);
        System.out.println("Largest number: " + max);
        System.out.println("Average: " + average);
        */

        // My Favorite Numbers\
        /*
         * Scanner scanner = new Scanner(System.in);
        Random random = new Random();
        boolean restart;

        do {
            System.out.print("How many distinct favorite numbers do you want to input? ");
            int count = scanner.nextInt();

            int[] numbers = new int[count];
            int entered = 0;

            while (entered < count) {
                System.out.print("Enter favorite number " + (entered + 1) + ": ");
                int num = scanner.nextInt();
                boolean isDuplicate = false;

                for (int i = 0; i < entered; i++) {
                    if (numbers[i] == num) {
                        isDuplicate = true;
                        break;
                    }
                }

                if (!isDuplicate) {
                    numbers[entered] = num;
                    entered++;
                } else {
                    System.out.println("Number already entered. Please enter a distinct number.");
                }
            }

            int min = numbers[0];
            int max = numbers[0];

            for (int i = 1; i < count; i++) {
                if (numbers[i] < min) min = numbers[i];
                if (numbers[i] > max) max = numbers[i];
            }

            int randNum = random.nextInt(max - min + 1) + min;

            System.out.println("Random number generated: " + randNum);
            System.out.println("Numbers greater than or equal to the random number:");

            for (int i = 0; i < count; i++) {
                if (numbers[i] >= randNum) {
                    System.out.println(numbers[i]);
                }
            }

            System.out.print("Would you like to restart? (yes/no): ");
            scanner.nextLine(); // consume newline
            String answer = scanner.nextLine().trim().toLowerCase();
            restart = answer.equals("yes");

        } while (restart);

        scanner.close();
        */

    }
}
