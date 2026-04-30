import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Clicker {
    
    public static int counter = 0;
    public static void main(String[] args){
        //Create a JFrame object
        JFrame frame = new JFrame("Button");
        frame.setSize(400,500);
        JPanel contents = new JPanel();
        JLabel label = new JLabel("Number of the button clicks : #" + counter);
        JButton myButton = new JButton("Click Me");
        myButton.setPreferredSize (new Dimension (100, 30));
        
        myButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e){
                counter++;
                if (counter >= 10){
                    label.setText("You over-clicked the button, stop it now!");
                }
                else{
                    label.setText("Number of the button clicks : #" + counter);
                }
            }
        });
        
        //Set contentPane contents.add(label);
        contents.add(label);
        contents.add(myButton);
        // add the 'contents' panel to the frame
        frame.setContentPane (contents);
        // Size and display the frame
        
        frame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE); 
        frame.setSize(300, 400);
        frame.setLocationRelativeTo(null); // Center on screen
        frame.setVisible(true);

        
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null); // Center on screen
        frame.setVisible(true);
        
    }
}