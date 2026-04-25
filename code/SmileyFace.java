

import java.awt.*;
import javax.swing.*;

public class SmileyFace extends JComponent {
    private double scale;
    private int faceX = 1;
    private int faceY = 1;
    private int faceDiameter = 5;
  
    public SmileyFace(){
        super();
        setPreferredSize(new Dimension(300,300));
    }

    // Override the paintComponent method to perform custom drawing
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g); // Ensure the panel is properly rendered
        Graphics2D g2d = (Graphics2D)g;
        g2d.scale(getWidth()/10, getHeight()/10);

        // Draw the face (circle)
        g2d.setColor(Color.YELLOW);
        g2d.fillOval(faceX, faceY, faceDiameter,faceDiameter);

        // Draw the eyes
        g2d.setColor(Color.BLACK);
        g2d.fillOval(faceX + 1, faceY +1, 1, 1); // Left eye
        g2d.fillOval(faceX + 2, faceY + 1, 1, 1); // Right eye

        // Draw the smile (arc)
        g2d.setColor(Color.RED);
        g2d.setStroke(new BasicStroke(0.5F));
        g2d.drawArc(faceX+1, faceY+3, 2, 1, 0, -180);

    }

    public static void main(String[] args) {
        // Create a JFrame to hold the smiley face
        JFrame frame = new JFrame("Smiley Face");
        //JPanel pane = new JPanel();
        SmileyFace smileyFace = new SmileyFace(); // Create a SmileyFace object
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(smileyFace);
        frame.pack();
        frame.setVisible(true); // Make the frame visible
    }
}