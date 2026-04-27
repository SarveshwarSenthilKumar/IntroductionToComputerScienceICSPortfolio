import java.util.ArrayList;

public class Student2 {

    // =========================
    // INSTANCE VARIABLES
    // =========================
    private String firstName;
    private String lastName;
    private int studentNo;
    private double mark;

    // =========================
    // CONSTRUCTOR
    // =========================
    public Student2(String firstName, String lastName, int studentNo, double mark) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.studentNo = studentNo;
        this.mark = mark;
    }

    // =========================
    // GETTERS (ACCESSORS)
    // =========================
    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public int getStudentNo() {
        return studentNo;
    }

    public double getMark() {
        return mark;
    }

    // =========================
    // PASS / FAIL METHOD
    // =========================
    public String isPassing() {
        // If mark >= 50 → passing
        if (mark >= 50) {
            return "Yes";
        } else {
            return "No";
        }
    }

    // =========================
    // STATIC METHOD → CLASS AVERAGE
    // =========================
    public static double getAverage(ArrayList<Student2> students) {

        // Edge case: no students
        if (students.size() == 0) return 0;

        double total = 0;

        // Loop through all students
        for (Student2 s : students) {
            total += s.getMark();
        }

        // Return average
        return total / students.size();
    }
}