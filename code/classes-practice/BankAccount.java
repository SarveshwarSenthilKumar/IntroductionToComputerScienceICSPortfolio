public class BankAccount {
    //variables:
  	private String accountNumber;
  	private String accountHolder;
  	private double balance;
  	private String accountType;

    //constructors:
  	public BankAccount(){ //default constructor
        this.accountNumber = "0001234567";
        this.accountHolder = "John Doe";
        this.balance = 0;
        this.accountType = "Chequing";
    }
    public BankAccount(String accountNumber, String accountHolder, double balance, String accountType){
        this.accountNumber = accountNumber;
        this.accountHolder = accountHolder;
        this.balance = balance;
        this.accountType = accountType;
    }
    public BankAccount(String accountHolder){
        this.accountHolder = accountHolder;
        this.balance = 100;
        this.accountType = "Savings";
    }

  	public void setAccountNumber(String accountNumber){
        this.accountNumber = accountNumber;
    }
    public void setAccountHolder(String accountHolder){
        this.accountHolder = accountHolder;
    }
    public void setBalance(double balance){
        this.balance = balance;
    }
    public void setAccountType(String accountType){
        this.accountType = accountType;
    }

    public String getAccountNumber(){
        return this.accountNumber;
    }
    public String getAccountHolder(){
        return this.accountHolder;
    }
    public double getBalance(){
        return this.balance;
    }
    public String getAccountType(){
        return this.accountType;
    }
    
    public boolean withdrawal(double money){
        if (this.balance < money){
            return false;
        }
        else{
            return true;
        }
    }
    public void deposit(double amount){
        this.balance += amount;
    }
    public void withdraw(double amount){
        if (this.balance<amount){
            System.out.println("Insufficient Funds!");
        }
        else{
            this.balance -= amount;
        }
    }
    public String toString(){
        String returnStr;
        returnStr = accountNumber + " " + accountHolder + " " + balance + " " + accountType;
        return returnStr;
    }
    
    public void closeAccount(){
        this.balance = 0;
        this.accountHolder = "Closed";
    }   
    public void transfer(BankAccount account, double amount){
        if (amount > this.balance){
            System.out.println("Insufficient Funds");
        }
        else {
            this.balance -= amount;
            account.deposit(amount);
        }
    }

  
}