import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Ball extends JComponent implements ActionListener{
    private int x = 0; // X position of the image
    private int y = 50; // Y position of the image
    private Image image;
    private Timer timer;
    private int speedX = 4;
    private int speedY = 5;

    public Ball(){
        // Try to load the image, fallback to colored circle if not found
        try {
            image = new ImageIcon("ball.png").getImage();
        } catch (Exception e) {
            image = null; // Will draw circle instead
        }
        
        // Create a timer that updates the position every 10ms
        timer = new Timer(10, this);
        timer.start();
    } // Paint the image
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        
        if (image != null) {
            g.drawImage(image, x, y, 100, 100, this);
        } else {
            // Draw a red circle if image doesn't work
            g.setColor(Color.RED);
            g.fillOval(x, y, 100, 100);
        }
    }

    // Update position of image - You must override the following method which will be
    // called by the timer.
    @Override
    public void actionPerformed(ActionEvent e) {
        x += speedX; // Move image 2px to the right
        y += speedY; 

        // Reset position if it goes off-screen
        if (x >= getWidth() -100 || x <= 0) {
            speedX *= -1;
        }
        if (y > getHeight() - 100|| y <=0 ){
            speedY *= -1;
        }

        repaint(); // Repaint panel
    }

    // Main method to run it
    public static void main(String[] args) {
        JFrame frame = new JFrame("Moving Image on JPanel");
        Ball ball = new Ball();
        frame.add(ball);
        frame.setSize(500, 500);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}

