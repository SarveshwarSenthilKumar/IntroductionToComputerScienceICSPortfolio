package pinball.game;

import java.awt.*;
import java.awt.geom.Rectangle2D;

/**
 * The player-controlled paddle at the bottom of the playfield.
 * Responds to left/right arrow key input and can be resized by power-ups.
 */
public class Paddle {

    /** Base width of the paddle in pixels. */
    public static final int BASE_WIDTH = 90;
    /** Height of the paddle in pixels. */
    public static final int HEIGHT = 14;
    /** Horizontal movement speed in pixels per tick. */
    public static final int SPEED = 8;

    /** Left edge x-coordinate. */
    private double x;
    /** Top edge y-coordinate (fixed). */
    private final double y;

    /** Current width (affected by power-ups). */
    private int width = BASE_WIDTH;

    /** Movement direction flags. */
    private boolean movingLeft = false;
    private boolean movingRight = false;

    /** Playfield boundaries for clamping. */
    private final int fieldLeft;
    private final int fieldRight;

    /**
     * Creates a paddle centered at the given x position.
     *
     * @param centerX    initial horizontal center
     * @param y          fixed vertical position
     * @param fieldLeft  left boundary
     * @param fieldRight right boundary
     */
    public Paddle(double centerX, double y, int fieldLeft, int fieldRight) {
        this.x = centerX - BASE_WIDTH / 2.0;
        this.y = y;
        this.fieldLeft = fieldLeft;
        this.fieldRight = fieldRight;
    }

    // -------------------------------------------------------------------------
    // Update
    // -------------------------------------------------------------------------

    /**
     * Updates paddle position based on current input flags.
     * Should be called once per game tick.
     *
     * @param widthMultiplier power-up width multiplier (1.0 or 2.0)
     */
    public void update(double widthMultiplier) {
        width = (int)(BASE_WIDTH * widthMultiplier);

        if (movingLeft)  x -= SPEED;
        if (movingRight) x += SPEED;

        // Clamp to field
        if (x < fieldLeft) x = fieldLeft;
        if (x + width > fieldRight) x = fieldRight - width;
    }

    // -------------------------------------------------------------------------
    // Input
    // -------------------------------------------------------------------------

    public void setMovingLeft(boolean v)  { movingLeft  = v; }
    public void setMovingRight(boolean v) { movingRight = v; }

    // -------------------------------------------------------------------------
    // Geometry
    // -------------------------------------------------------------------------

    /** @return left edge x */
    public double getX() { return x; }
    /** @return top edge y */
    public double getY() { return y; }
    /** @return current pixel width */
    public int getWidth() { return width; }

    /** @return center x */
    public double getCenterX() { return x + width / 2.0; }

    /** @return bounding Rectangle2D for collision detection */
    public Rectangle2D getBounds() {
        return new Rectangle2D.Double(x, y, width, HEIGHT);
    }

    // -------------------------------------------------------------------------
    // Rendering
    // -------------------------------------------------------------------------

    /**
     * Draws the paddle with a glossy 3-D effect.
     *
     * @param g2 the Graphics2D context
     */
    public void draw(Graphics2D g2) {
        int px = (int) x;
        int py = (int) y;

        // Body gradient
        GradientPaint gp = new GradientPaint(
            px, py, new Color(60, 160, 255),
            px, py + HEIGHT, new Color(0, 80, 180)
        );
        g2.setPaint(gp);
        g2.fillRoundRect(px, py, width, HEIGHT, 10, 10);

        // Top highlight
        g2.setColor(new Color(180, 230, 255, 120));
        g2.fillRoundRect(px + 2, py + 2, width - 4, HEIGHT / 2 - 2, 8, 8);

        // Border
        g2.setColor(new Color(0, 50, 150));
        g2.setStroke(new BasicStroke(1.5f));
        g2.drawRoundRect(px, py, width, HEIGHT, 10, 10);
    }
}