package pinball.game;

import java.awt.*;
import java.awt.geom.Ellipse2D;

/**
 * A circular bumper on the playfield.
 * When struck by the ball, the bumper awards points and coins, then
 * repels the ball away. A brief flash animation plays on each hit.
 */
public class Bumper {

    /** Radius of a regular bumper in pixels. */
    public static final int RADIUS = 22;

    /** Points awarded per hit (base value). */
    private final int pointValue;

    /** Coins awarded per hit (base value, subject to multiplier). */
    private final int coinValue;

    /** Center position. */
    private final double x, y;

    /** Flash timer: ticks remaining for the hit animation. */
    private int flashTicks = 0;

    /** Total number of times this bumper has been hit this session. */
    private int hitCount = 0;

    /** Unique display label shown inside the bumper. */
    private final String label;

    /** Base hue color for this bumper. */
    private final Color baseColor;

    /**
     * Creates a bumper.
     *
     * @param x          center x
     * @param y          center y
     * @param pointValue score awarded per hit
     * @param coinValue  coins awarded per hit
     * @param label      label displayed on the bumper
     * @param baseColor  fill color
     */
    public Bumper(double x, double y, int pointValue, int coinValue, String label, Color baseColor) {
        this.x = x;
        this.y = y;
        this.pointValue = pointValue;
        this.coinValue = coinValue;
        this.label = label;
        this.baseColor = baseColor;
    }

    // -------------------------------------------------------------------------
    // Update
    // -------------------------------------------------------------------------

    /** Decrements the flash timer each game tick. */
    public void tick() {
        if (flashTicks > 0) flashTicks--;
    }

    /**
     * Called when the ball hits this bumper.
     * Starts the flash animation and increments the hit counter.
     */
    public void onHit() {
        flashTicks = 10;
        hitCount++;
    }

    // -------------------------------------------------------------------------
    // Collision
    // -------------------------------------------------------------------------

    /** @return true if the ball is overlapping this bumper */
    public boolean isColliding(Ball ball) {
        double dx = ball.getX() - x;
        double dy = ball.getY() - y;
        double dist = Math.sqrt(dx * dx + dy * dy);
        return dist < (RADIUS + Ball.RADIUS);
    }

    /**
     * Reflects the ball away from the bumper center and adds impulse.
     *
     * @param ball the ball to reflect
     */
    public void reflect(Ball ball) {
        double dx = ball.getX() - x;
        double dy = ball.getY() - y;
        double dist = Math.sqrt(dx * dx + dy * dy);
        if (dist == 0) dist = 1;

        double nx = dx / dist; // Normal direction
        double ny = dy / dist;

        // Minimum separation
        double overlap = (RADIUS + Ball.RADIUS) - dist;
        ball.setX(ball.getX() + nx * overlap);
        ball.setY(ball.getY() + ny * overlap);

        // Reflect velocity and add impulse
        double speed = Math.max(ball.getSpeed(), 5.0) + 2.0;
        ball.setVx(nx * speed);
        ball.setVy(ny * speed);
    }

    // -------------------------------------------------------------------------
    // Getters
    // -------------------------------------------------------------------------

    public double getX() { return x; }
    public double getY() { return y; }
    public int getPointValue() { return pointValue; }
    public int getCoinValue() { return coinValue; }
    public int getHitCount() { return hitCount; }
    public boolean isFlashing() { return flashTicks > 0; }

    public Ellipse2D getBounds() {
        return new Ellipse2D.Double(x - RADIUS, y - RADIUS, RADIUS * 2, RADIUS * 2);
    }

    // -------------------------------------------------------------------------
    // Rendering
    // -------------------------------------------------------------------------

    /**
     * Draws the bumper with a neon glow effect. Flashes bright white on hit.
     *
     * @param g2 the Graphics2D context
     */
    public void draw(Graphics2D g2) {
        Color fill = isFlashing() ? Color.WHITE : baseColor;
        Color glow = isFlashing()
            ? new Color(255, 255, 200, 180)
            : new Color(baseColor.getRed(), baseColor.getGreen(), baseColor.getBlue(), 80);

        int px = (int)(x - RADIUS);
        int py = (int)(y - RADIUS);
        int d  = RADIUS * 2;

        // Outer glow
        g2.setColor(glow);
        g2.fillOval(px - 6, py - 6, d + 12, d + 12);

        // Body gradient
        GradientPaint gp = new GradientPaint(
            px, py, fill.brighter(),
            px + d, py + d, fill.darker()
        );
        g2.setPaint(gp);
        g2.fillOval(px, py, d, d);

        // Ring
        g2.setColor(fill.darker().darker());
        g2.setStroke(new BasicStroke(2.5f));
        g2.drawOval(px, py, d, d);

        // Inner ring
        g2.setColor(new Color(255, 255, 255, 100));
        g2.setStroke(new BasicStroke(1.5f));
        g2.drawOval(px + 4, py + 4, d - 8, d - 8);

        // Label
        g2.setColor(isFlashing() ? Color.BLACK : Color.WHITE);
        g2.setFont(new Font("Monospaced", Font.BOLD, 11));
        FontMetrics fm = g2.getFontMetrics();
        int lx = (int)x - fm.stringWidth(label) / 2;
        int ly = (int)y + fm.getAscent() / 2 - 2;
        g2.drawString(label, lx, ly);

        // Coin value badge
        String coinStr = "+" + coinValue + "¢";
        g2.setFont(new Font("SansSerif", Font.PLAIN, 9));
        fm = g2.getFontMetrics();
        g2.setColor(new Color(255, 215, 0));
        g2.drawString(coinStr, (int)x - fm.stringWidth(coinStr) / 2, (int)y + RADIUS - 3);
    }
}