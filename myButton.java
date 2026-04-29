/*
 Lesson Example : Let's try this together
*/
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class myButton {
    
    
    public static void main(String[] args){
        //Create a JFrame object
        JFrame frame = new JFrame("Button");
        frame.setSize(400,300);
        JPanel contents = new JPanel();
        JLabel label = new JLabel("Message");
        JButton myButton = new JButton("Submit");
        JTextField text = new JTextField(30);
        myButton.setPreferredSize (new Dimension (100, 30));
        
        myButton.addActionListener(e -> {
            String data = text.getText(); // Captures text when button is clicked
            System.out.println("User entered: " + data);
        });
        
        //Set contentPane contents.add(label);
        contents.add(label);
        contents.add(text);
        contents.add(myButton);
        // add the 'contents' panel to the frame
        frame.setContentPane (contents);
        // Size and display the frame
        
        frame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE); 
        frame.setSize(300, 200);
        frame.setLocationRelativeTo(null); // Center on screen
        frame.setVisible(true);

        
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null); // Center on screen
        frame.setVisible(true);
        
    }
    
    
}