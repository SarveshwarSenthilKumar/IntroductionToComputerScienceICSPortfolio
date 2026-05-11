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
    private Ball ball;

    public TimerExample() {
        // Initialize countdown display
        countdown = String.valueOf(timerDisplay);
        
        // Create timer that fires every 1 second
        timer = new Timer(1000, this);
        timer.start();
        
        // Create and add the ball
        ball = new Ball();
        this.setLayout(new BorderLayout());
        this.add(ball, BorderLayout.CENTER);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        timerDisplay--;
        countdown = String.valueOf(timerDisplay);
        
        if (timerDisplay <= 0) {
            timer.stop();
            countdown = "Time's Up!";
        }
        
        repaint();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        
        // Set font and color for countdown
        g.setFont(new Font("Arial", Font.BOLD, 24));
        g.setColor(Color.RED);
        
        // Draw countdown string at top of panel
        FontMetrics fm = g.getFontMetrics();
        int x = (getWidth() - fm.stringWidth(countdown)) / 2;
        int y = 30;
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