import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class SimpleTimer extends JPanel implements ActionListener {
    private int timerDisplay = 3;
    private Timer timer;
    private String countdown;
    private int ballX = 50, ballY = 100;
    private int speedX = 3, speedY = 2;

    public SimpleTimer() {
        countdown = String.valueOf(timerDisplay);
        
        timer = new Timer(1000, this);
        timer.start();
        
        Timer ballTimer = new Timer(20, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                ballX += speedX;
                ballY += speedY;
                
                if (ballX >= getWidth() - 50 || ballX <= 0) {
                    speedX *= -1;
                }
                if (ballY >= getHeight() - 50 || ballY <= 50) {
                    speedY *= -1;
                }
                repaint();
            }
        });
        ballTimer.start();
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
        
        g.setFont(new Font("Arial", Font.BOLD, 24));
        g.setColor(Color.RED);
        
        FontMetrics fm = g.getFontMetrics();
        int x = (getWidth() - fm.stringWidth(countdown)) / 2;
        int y = 30;
        g.drawString(countdown, x, y);
        
        g.setColor(Color.BLUE);
        g.fillOval(ballX, ballY, 50, 50);
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Countdown Timer");
        SimpleTimer panel = new SimpleTimer();
        frame.add(panel);
        frame.setSize(400, 400);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
