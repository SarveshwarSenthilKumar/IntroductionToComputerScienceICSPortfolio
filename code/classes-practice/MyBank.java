
import java.util.*;

public class MyBank {
    public static void main(String[] args) {
        boolean viewBalance = false;
        BankAccount currentAcc = new BankAccount();
        while (true){
            System.out.print("\033[H\033[2J");
            System.out.flush();
            
            System.out.println("Welcome to " + currentAcc.getAccountHolder() + "'s Bank Account\n");
            if (viewBalance){
                System.out.println("Your current balance is " + currentAcc.getBalance());
                viewBalance = false;
            } 
            System.out.println("1. Deposit Money");
            System.out.println("2. Withdraw Money");
            System.out.println("3. View Balance");
            System.out.println("4. Change name of Account Holder");
            System.out.println("5. Quit Program\n");
            System.out.print("Enter the number of the option you would like: ");
            
            Scanner scanner = new Scanner(System.in);
            int option = scanner.nextInt();
            
            if (option == 1){
                System.out.print("Enter the money to deposit: ");
                int amount = scanner.nextInt();
                currentAcc.deposit(amount);
            }
            else if (option == 2){
                System.out.print("Enter the money to withdraw: ");
                int amount = scanner.nextInt();
                currentAcc.withdraw(amount);
            }
            else if (option == 3){
                   viewBalance = true;
            }
            else if (option == 4){
                System.out.print("Enter the name to change to: ");
                Scanner scanner2 = new Scanner(System.in);
                String name = scanner2.nextLine();
                currentAcc.setAccountHolder(name);
            }
            else if (option == 5){
                break;
            }
            
            
        }
    }
}