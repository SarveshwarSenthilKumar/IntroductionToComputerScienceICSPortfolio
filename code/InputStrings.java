package code;

import java.util.Scanner;

public class InputStrings {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);

        /* 
        //The Amazing Sentence Machine 
        System.out.print("Enter a string: ");
        String st = input.nextLine();

        System.out.println(st.toUpperCase());
        System.out.println(st.toLowerCase());

        System.out.println(st.replace("a", "e"));
        
        String text = "Port Credit Secondary School";
        System.out.print("Enter a word: ");
        String word = input.nextLine();
        System.out.println(text.indexOf(word));

        System.out.println((text.split(" ")).length);
        */

        /* 
        // The Amazing Sentence Machine 2.0
        System.out.print("Enter a string: ");
        String text = input.nextLine();

        for (int i = 0; i < text.length()-1; i+=2){
            System.out.print(text.charAt(i));
        }
        System.out.println();
        */

        /* 
        // The Amazing Sentence Machine 3.0
        System.out.print("Enter a string: ");
        String text = input.nextLine();
        System.out.print("Enter a number: ");
        int num = input.nextInt();
        if (num < text.length())
            for (int i = 0; i < text.length(); i+=num){
                System.out.print(text.charAt(i));
            }
        System.out.println();
        */

        /*
        // Mirror Mirror on the Wall...
        System.out.print("Enter a string: ");
        String text = input.nextLine();
        String reverse = "";

        for (int i = text.length()-1; i >= 0; i--){
            reverse += text.charAt(i);
        }
        System.out.println(reverse);
        */

        /*
        //Remove Vowels
        System.out.print("Enter a string: ");
        String text = input.nextLine();
        String noVowels = "";
        String vowels = "aeiouAEIOU";
        for (int i = 0; i < text.length(); i++){
            if (vowels.indexOf(text.charAt(i)) == -1){
                noVowels += text.charAt(i);
            }
        }
        System.out.println(noVowels);
        */
    }
}
