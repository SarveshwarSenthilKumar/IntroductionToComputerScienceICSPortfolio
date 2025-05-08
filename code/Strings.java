

public class Strings {
    public static void main(String[] args) {
        String text = "Port Credit Secondary School";
        System.out.println(text.toUpperCase());
        System.out.println(text.charAt(text.length() - 1));
        System.out.println(text.charAt(5));
        System.out.println(text.replace("o", "*"));
        System.out.println(text.indexOf("Credit"));
        System.out.println(text.length());

        for (int i=0; i<text.length(); i+=2){
            System.out.println(text.charAt(i));
        }
        for (int i=text.length()-1; i>=0; i--){
            System.out.println(text.charAt(i));
        }

        int count = 0;
        for (int i=0; i<text.length(); i++){
            if (text.charAt(i) == 'a'){
                count++;
            }
        }
        System.out.println("\nThe letter 'a' appears " + count + " times in the text.");

        int count2 = 0;
        for (int i=0; i<text.length(); i++){
            if (text.charAt(i) == ' '){
                count2++;
            }
        }
        System.out.println("The number of spaces in the text is " + count2 + ".");

        String newString = "";
        String vowels = "aeiouAEIOU";
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (c != ' ' && vowels.indexOf(c) == -1) {
                newString += c;
            }
        }
        System.out.println("The new string is: " + newString);
    }
}
 