package pinball.game;

import java.awt.*;

/**
 * A short-lived floating text label that rises from the point of impact
 * and fades out. Used to show "+points" and "+coins" feedback.
 */
public class ScorePopup {

    private double x, y;
    private final String text;
    private final Color color;
    private int life;           // ticks remaining
    private final int maxLife;

    /**
     * Creates a new score popup.
     *
     * @param x     horizontal center
     * @param y     vertical position (rises upward each tick)
     * @param text  text to display (e.g. "+500")
     * @param color text color
     * @param ticks number of game ticks before disappearing
     */
    public ScorePopup(double x, double y, String text, Color color, int ticks) {
        this.x = x;
        this.y = y;
        this.text = text;
        this.color = color;
        this.life = ticks;
        this.maxLife = ticks;
    }

    /** Advances the popup animation. Call once per game tick. */
    public void tick() {
        y -= 1.2;  // Float upward
        life--;
    }

    /** @return true if this popup has expired and should be removed */
    public boolean isDead() { return life <= 0; }

    /**
     * Draws the popup with alpha fade.
     *
     * @param g2 the Graphics2D context
     */
    public void draw(Graphics2D g2) {
        float alpha = (float) life / maxLife;
        Color c = new Color(color.getRed(), color.getGreen(), color.getBlue(), (int)(alpha * 255));

        g2.setFont(new Font("Impact", Font.PLAIN, 16));
        FontMetrics fm = g2.getFontMetrics();
        int tx = (int) x - fm.stringWidth(text) / 2;
        int ty = (int) y;

        // Shadow
        g2.setColor(new Color(0, 0, 0, (int)(alpha * 150)));
        g2.drawString(text, tx + 1, ty + 1);

        // Text
        g2.setColor(c);
        g2.drawString(text, tx, ty);
    }
}