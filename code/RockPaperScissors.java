
import java.util.*;

public class RockPaperScissors
{
    public static void main(String[] args)
    {

        String[] choices = {"rock", "paper", "scissors"};
        String[] rounds = new String[50];

        int round = 0;

        while (true){
            Scanner input = new Scanner(System.in);
            
            String human = humanChoice();
            String robot = robotChoice();
            
            if (human.equals(robot)){
                System.out.println("Computer chose: " + robot);
                System.out.println("It's a tie!");
            }

            else if (human.equals("rock") && robot.equals("scissors")){
                System.out.println("Computer chose: " + robot);
                System.out.println("You win!");
            }
            else if (human.equals("paper") && robot.equals("rock")){
                System.out.println("Computer chose: " + robot);
                System.out.println("You win!");
            }
            else if (human.equals("scissors") && robot.equals("paper")){
                System.out.println("Computer chose: " + robot);
                System.out.println("You win!");
            }
            else{
                System.out.println("Computer chose: " + robot);
                System.out.println("You lose!");
            }
            
            System.out.print("Play again? (yes/no): ");
            String playAgain = (input.nextLine()).toLowerCase();
            System.out.println();
            
            if (playAgain.equals("no")){
                System.out.println("Thanks for playing!");
                break;
            }

            rounds[round] = "Round " + (round + 1) + ": You chose " + human + ", Computer chose " + robot;
            round++;
        }
        for (int i = 0; i < round; i++){
            System.out.println(rounds[i]);
        }
    }
    
    public static String humanChoice(){
        Scanner input = new Scanner(System.in);
        String move;
        while (true){
            System.out.print("Enter your move (rock, paper, scissors): ");
            move = (input.nextLine()).toLowerCase();
            
            if (move.equals("rock")){
                return move;
            }
            else if (move.equals("paper")){
                return move;
            }
            else if (move.equals("scissors")){
                return move;
            }
        } 
    }
    
    public static String robotChoice(){
        int random = (int)(Math.random()*3+1);
        
        if (random == 1){
            return "rock";
        }
        else if (random == 2){
            return "paper";
        }
        else{
            return "scissors";
        }
    }
}