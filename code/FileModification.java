package code;

import java.io.*;

public class FileModification {
    public static void main(String[] args) throws IOException{
        /* 
        BufferedReader reader = new BufferedReader(new java.io.FileReader("code/words.txt"));
        String line = reader.readLine();
        System.out.println(line);
        reader.close();
        */

        /* 
        PrintWriter writer = new PrintWriter(new java.io.FileWriter("code/words.txt", true));
        writer.println("his is a new line added to the file.");
        writer.close();
        */

        /* 
        // Reads a nursery rhyme
        BufferedReader nurseryReader = new BufferedReader(new java.io.FileReader("code/rhymes.txt"));
        String currentLine = nurseryReader.readLine();
        while (currentLine != null) {
            System.out.println(currentLine);
            currentLine = nurseryReader.readLine();
        }
            
        nurseryReader.close();
        */

        /* 
        // Opposite Case Conversion
        BufferedReader sentenceReader = new BufferedReader(new java.io.FileReader("code/sentences1.txt"));
        String currentLine = "";
        while (currentLine != null) {
            currentLine = sentenceReader.readLine();
            if (currentLine == null) {
                break;
            }
            for (int i = 0; i<currentLine.length(); i++){
                char c = currentLine.charAt(i);
                if (Character.isUpperCase(c)){
                    System.out.print(Character.toLowerCase(c));
                } else if (Character.isLowerCase(c)){
                    System.out.print(Character.toUpperCase(c));
                } else {
                    System.out.print(c);
                }
                
            }
            System.out.println();

        }
            
        sentenceReader.close();
        */
        
        
        /* 
        //Render Random Student Marks
        int RandomMark = (int)(Math.random()*60) + 40;
        PrintWriter writer = new PrintWriter(new java.io.FileWriter("code/marks.txt", true));
        writer.println("Student: " + RandomMark);
        writer.close();
        */

        /* 
        // Read and print the average length of a sentence
        BufferedReader sentenceReader = new BufferedReader(new java.io.FileReader("code/sentences1.txt"));
        String currentLine = sentenceReader.readLine();
        int totalLength = 0;
        int numberOfLines = 0;
        while (currentLine != null) {
            totalLength += currentLine.length();
            numberOfLines++;
            currentLine = sentenceReader.readLine();
        }
        System.out.println("The average length of a sentence is: " + (double)totalLength/numberOfLines);
            
        sentenceReader.close();
        */
    }
}
