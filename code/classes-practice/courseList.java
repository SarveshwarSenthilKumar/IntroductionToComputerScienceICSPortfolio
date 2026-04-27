package classes-practice;

public import java.util.*;
import java.io.*;

public class CourseList {

    public static void main(String[] args) {

        // =========================
        // ARRAYLIST TO STORE STUDENTS
        // =========================
        ArrayList<Student> students = new ArrayList<>();

        // =========================
        // READ FROM FILE
        // =========================
        try {
            File file = new File("studentinfo.txt");
            Scanner fileScanner = new Scanner(file);

            while (fileScanner.hasNext()) {

                // Read data in order
                String firstName = fileScanner.next();
                String lastName = fileScanner.next();
                int studentNo = fileScanner.nextInt();
                double mark = fileScanner.nextDouble();

                // Create student object
                Student s = new Student(firstName, lastName, studentNo, mark);

                // Add to ArrayList
                students.add(s);
            }

            fileScanner.close();

        } catch (Exception e) {
            System.out.println("Error reading file.");
        }

        // =========================
        // USER MENU
        // =========================
        Scanner input = new Scanner(System.in);
        int choice = -1;

        while (choice != 0) {

            // Display menu
            System.out.println("\n===== MENU =====");
            System.out.println("1. Display Student Information");
            System.out.println("2. Delete Student");
            System.out.println("3. Display Entire Class List");
            System.out.println("4. Display Class Average");
            System.out.println("0. Exit");
            System.out.print("Enter choice: ");

            choice = input.nextInt();

            // =========================
            // OPTION 1: DISPLAY ONE STUDENT
            // =========================
            if (choice == 1) {
                System.out.print("Enter student index: ");
                int index = input.nextInt();

                // Check if index valid
                if (index >= 0 && index < students.size()) {
                    Student s = students.get(index);

                    System.out.println("\n--- Student Info ---");
                    System.out.println("Name: " + s.getFirstName() + " " + s.getLastName());
                    System.out.println("Student No: " + s.getStudentNo());
                    System.out.println("Mark: " + s.getMark());
                } else {
                    System.out.println("Invalid index.");
                }
            }

            // =========================
            // OPTION 2: DELETE STUDENT
            // =========================
            else if (choice == 2) {
                System.out.print("Enter index to delete: ");
                int index = input.nextInt();

                if (index >= 0 && index < students.size()) {
                    students.remove(index);
                    System.out.println("Student removed.");
                } else {
                    System.out.println("Invalid index.");
                }
            }

            // =========================
            // OPTION 3: DISPLAY FULL LIST
            // =========================
            else if (choice == 3) {

                System.out.println("\n===== CLASS LIST =====");

                // Table header
                System.out.printf("%-5s %-10s %-10s %-12s %-8s %-10s\n",
                        "Index", "First", "Last", "StudentNo", "Grade", "Pass");

                // Loop through students
                for (int i = 0; i < students.size(); i++) {
                    Student s = students.get(i);

                    System.out.printf("%-5d %-10s %-10s %-12d %-8.1f %-10s\n",
                            i,
                            s.getFirstName(),
                            s.getLastName(),
                            s.getStudentNo(),
                            s.getMark(),
                            s.isPassing());
                }
            }

            // =========================
            // OPTION 4: CLASS AVERAGE
            // =========================
            else if (choice == 4) {
                double avg = Student.getAverage(students);

                // Print with 1 decimal place
                System.out.printf("The class average is %.1f%%\n", avg);
            }

            // =========================
            // INVALID OPTION
            // =========================
            else if (choice != 0) {
                System.out.println("Invalid choice.");
            }
        }

        input.close();
    }
} {
    
}
