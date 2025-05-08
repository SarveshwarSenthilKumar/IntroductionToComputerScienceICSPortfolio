
import java.io.*;

public class replaced
{
    public static void main(String[] args) throws IOException
    {
        BufferedReader sentenceReader = new BufferedReader(new java.io.FileReader("code/input.txt"));
        PrintWriter sentenceWriter = new PrintWriter(new java.io.FileWriter("code/output.txt", true));
        String currentLine = "";
        while (currentLine != null) {
            currentLine = sentenceReader.readLine();
            String newString = "";
            if (currentLine == null) {
                break;
            }
            for (int i = 0; i<currentLine.length(); i++){
                if (i%2==0){
                    newString+=currentLine.charAt(i);
                }
                else{
                    newString+="+";
                }
            }

            System.out.println(currentLine);
            System.out.println(newString);
            sentenceWriter.println(newString);
        }
           
        sentenceReader.close();
       
    }
}