
import java.util.*;

public class MyProgram {
    public static void main(String[] args) {
        // Declaring and printing out pet constructs
        Pet pet1 = new Pet();
        Pet pet2 = new Pet("Adam", "Duck", 12, 1);

        pet2.eat(0.25);
        pet2.play(30);
        
        System.out.println(pet2.toString());
        
        
        // Declaring and printing out bank accounts
        BankAccount acc = new BankAccount();
        BankAccount acc2 = new BankAccount("4374504378", "Sarveshwar Senthil Kumar", 46.23, "Chequing");
        
        acc2.withdraw(5.65);
        acc2.deposit(50);
        
        System.out.println(acc2.toString());
        
        
        // Declaring and printing out students
        Student student = new Student();
        Student student2 = new Student("Sarveshwar Senthil Kumar", 997933, 90, 93);
        
        System.out.println("Average Before: " + student2.calculateAverage());
        student2.setGrade1(99);
        student2.setGrade2(78);
        System.out.println("Average After: " + student2.calculateAverage());

        System.out.println(student2.toString());
        
        
        
    }
}