/**
 *Create a program that displays countdown on the screen
 * Hint : use Timer object
 */

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class TimerExample extends JPanel implements ActionListener {
    private int timerDisplay = 3; // 3 seconds
    private Timer timer;
    private String countdown;

    public TimerExample() {
        
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        
        
        // draw a string (countdown)
        g.drawString(countdown, x, y);
    }
    //main method to test our program
    public static void main(String[] args) {
        //Create a JFrame
        JFrame frame = new JFrame("Countdown Timer");
        TimerExample panel = new TimerExample();
        //add it to the frame.
        frame.add(panel);
        frame.setSize(400, 400);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null); // Center the window
        frame.setVisible(true);
    }
}