import java.awt.*;
import javax.swing.*;

public class GUI {
    public static void main(String[] args) {
        // Create a JFrame
        JFrame frame = new JFrame("My Swing Application");

        //Create a panel
        JPanel contents = new JPanel();
        contents.setBackground(Color.yellow);

        //create other components
        JLabel label = new JLabel("Hello, Swing!");
        JButton myButton = new JButton("Click Me");
        JTextField text = new JTextField(30);

        //Set contentPane
        contents.ad
        d(label);
        contents.add(myButton);
        contents.add(text);

        // Size and display the frame
        frame.setContentPane(contents);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();;
        frame.setLocationRelativeTo(null); // Center on screen
        frame.setVisible(true);

    }
}