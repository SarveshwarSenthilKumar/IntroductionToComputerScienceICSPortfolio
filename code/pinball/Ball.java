package pinball.game;

import java.awt.*;
import java.awt.geom.Ellipse2D;

/**
 * Represents a pinball with position, velocity, and rendering logic.
 * Physics are handled externally by {@link GameEngine}.
 */
public class Ball {

    /** Radius of the ball in pixels. */
    public static final int RADIUS = 10;
    public static final int DIAMETER = RADIUS * 2;

    /** Ball center position. */
    private double x, y;

    /** Ball velocity in pixels per tick. */
    private double vx, vy;

    /** Whether this ball is currently active on the field. */
    private boolean active = true;

    /**
     * Creates a new ball at the given position with zero velocity.
     *
     * @param x center x
     * @param y center y
     */
    public Ball(double x, double y) {
        this.x = x;
        this.y = y;
        this.vx = 0;
        this.vy = 0;
    }

    /**
     * Creates a ball with an initial velocity.
     *
     * @param x  center x
     * @param y  center y
     * @param vx horizontal speed
     * @param vy vertical speed
     */
    public Ball(double x, double y, double vx, double vy) {
        this(x, y);
        this.vx = vx;
        this.vy = vy;
    }

    // -------------------------------------------------------------------------
    // Getters / setters
    // -------------------------------------------------------------------------

    public double getX() { return x; }
    public double getY() { return y; }
    public void setX(double x) { this.x = x; }
    public void setY(double y) { this.y = y; }

    public double getVx() { return vx; }
    public double getVy() { return vy; }
    public void setVx(double vx) { this.vx = vx; }
    public void setVy(double vy) { this.vy = vy; }

    public boolean isActive() { return active; }
    public void deactivate() { active = false; }

    // -------------------------------------------------------------------------
    // Physics helpers
    // -------------------------------------------------------------------------

    /** Advances the ball by its current velocity. */
    public void move() {
        x += vx;
        y += vy;
    }

    /** Applies gravity acceleration. */
    public void applyGravity(double gravity) {
        vy += gravity;
    }

    /** @return a bounding Ellipse2D for collision detection */
    public Ellipse2D getBounds() {
        return new Ellipse2D.Double(x - RADIUS, y - RADIUS, DIAMETER, DIAMETER);
    }

    /**
     * Renders the ball with a metallic gradient effect.
     *
     * @param g2 the Graphics2D context
     */
    public void draw(Graphics2D g2) {
        if (!active) return;
        int px = (int)(x - RADIUS);
        int py = (int)(y - RADIUS);

        // Metallic gradient
        GradientPaint gp = new GradientPaint(
            px, py, new Color(220, 220, 255),
            px + DIAMETER, py + DIAMETER, new Color(80, 80, 130)
        );
        g2.setPaint(gp);
        g2.fillOval(px, py, DIAMETER, DIAMETER);

        // Shine highlight
        g2.setColor(new Color(255, 255, 255, 160));
        g2.fillOval(px + 2, py + 2, RADIUS - 2, RADIUS - 2);

        // Outline
        g2.setColor(new Color(100, 100, 180));
        g2.setStroke(new BasicStroke(1.5f));
        g2.drawOval(px, py, DIAMETER, DIAMETER);
    }

    /** @return current speed (magnitude of velocity) */
    public double getSpeed() {
        return Math.sqrt(vx * vx + vy * vy);
    }

    /** Clamps the ball speed to a maximum. */
    public void clampSpeed(double maxSpeed) {
        double speed = getSpeed();
        if (speed > maxSpeed && speed > 0) {
            double scale = maxSpeed / speed;
            vx *= scale;
            vy *= scale;
        }
    }
}