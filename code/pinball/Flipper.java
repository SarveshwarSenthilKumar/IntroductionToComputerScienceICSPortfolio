package pinball.game;

import java.awt.*;
import java.awt.geom.*;

/**
 * A flipper arm controlled by the player (Z = left, / = right).
 * Rotates between a resting angle and an active angle when pressed.
 */
public class Flipper {

    /** Length of the flipper arm in pixels. */
    public static final int LENGTH = 60;
    /** Thickness of the flipper tip. */
    public static final int THICKNESS = 12;

    /** Rotation speed in radians per tick. */
    private static final double ROTATION_SPEED = Math.toRadians(18);

    /** True = this is the left flipper; false = right flipper. */
    private final boolean isLeft;

    /** Pivot point. */
    private final double pivotX, pivotY;

    /** Current rotation angle in radians. */
    private double angle;

    /** Resting angle (down position). */
    private final double restAngle;

    /** Active angle (up/flipped position). */
    private final double activeAngle;

    /** Whether the flip key is currently held. */
    private boolean pressed = false;

    /**
     * Creates a flipper.
     *
     * @param pivotX   x-coordinate of the pivot
     * @param pivotY   y-coordinate of the pivot
     * @param isLeft   true for left flipper
     */
    public Flipper(double pivotX, double pivotY, boolean isLeft) {
        this.pivotX = pivotX;
        this.pivotY = pivotY;
        this.isLeft = isLeft;

        if (isLeft) {
            restAngle  = Math.toRadians(30);   // pointing down-right
            activeAngle = Math.toRadians(-30);  // pointing up-right
        } else {
            restAngle  = Math.toRadians(150);  // pointing down-left
            activeAngle = Math.toRadians(210); // pointing up-left
        }
        this.angle = restAngle;
    }

    // -------------------------------------------------------------------------
    // Update
    // -------------------------------------------------------------------------

    /** Animates the flipper toward its target angle. Call once per game tick. */
    public void update() {
        double target = pressed ? activeAngle : restAngle;
        double diff = target - angle;
        if (Math.abs(diff) < ROTATION_SPEED) {
            angle = target;
        } else {
            angle += Math.signum(diff) * ROTATION_SPEED;
        }
    }

    // -------------------------------------------------------------------------
    // Input
    // -------------------------------------------------------------------------

    public void setPressed(boolean p) { this.pressed = p; }
    public boolean isPressed() { return pressed; }

    // -------------------------------------------------------------------------
    // Geometry
    // -------------------------------------------------------------------------

    public double getPivotX() { return pivotX; }
    public double getPivotY() { return pivotY; }
    public double getAngle() { return angle; }

    /** @return the tip (free end) of the flipper */
    public Point2D getTip() {
        return new Point2D.Double(
            pivotX + Math.cos(angle) * LENGTH,
            pivotY + Math.sin(angle) * LENGTH
        );
    }

    /**
     * Tests whether the ball is close enough to be deflected by this flipper.
     * Uses a simplified segment-circle test.
     *
     * @param ball the ball to test
     * @return true if the ball intersects this flipper
     */
    public boolean isColliding(Ball ball) {
        Point2D tip = getTip();
        double bx = ball.getX();
        double by = ball.getY();

        // Project ball onto flipper segment
        double dx = tip.getX() - pivotX;
        double dy = tip.getY() - pivotY;
        double lenSq = dx * dx + dy * dy;
        if (lenSq == 0) return false;

        double t = ((bx - pivotX) * dx + (by - pivotY) * dy) / lenSq;
        t = Math.max(0, Math.min(1, t));

        double closestX = pivotX + t * dx;
        double closestY = pivotY + t * dy;

        double distSq = (bx - closestX) * (bx - closestX) + (by - closestY) * (by - closestY);
        int threshold = Ball.RADIUS + THICKNESS / 2;
        return distSq < threshold * threshold;
    }

    /**
     * Reflects the ball off the flipper surface.
     * Adds extra upward velocity when actively pressed.
     *
     * @param ball the ball to deflect
     */
    public void reflect(Ball ball) {
        // Flipper normal is perpendicular to the arm
        double nx = -Math.sin(angle);
        double ny =  Math.cos(angle);

        // Ensure normal points away from pivot (upward)
        if (ny > 0) { nx = -nx; ny = -ny; }

        double dot = ball.getVx() * nx + ball.getVy() * ny;
        double baseSpeed = 10.0;
        double launchSpeed = pressed ? baseSpeed + 3 : baseSpeed - 2;

        ball.setVx(nx * launchSpeed);
        ball.setVy(ny * launchSpeed - (pressed ? 3 : 0));

        // Push ball clear of flipper to avoid tunneling
        ball.setX(ball.getX() + nx * (Ball.RADIUS + THICKNESS / 2 + 2));
        ball.setY(ball.getY() + ny * (Ball.RADIUS + THICKNESS / 2 + 2));
    }

    // -------------------------------------------------------------------------
    // Rendering
    // -------------------------------------------------------------------------

    /**
     * Draws the flipper as a tapered arm with a glossy finish.
     *
     * @param g2 the Graphics2D context
     */
    public void draw(Graphics2D g2) {
        Point2D tip = getTip();

        // Build a tapered polygon
        double nx = -Math.sin(angle);
        double ny =  Math.cos(angle);

        int baseHalf = THICKNESS;
        int tipHalf  = 5;

        int[] xs = {
            (int)(pivotX + nx * baseHalf),
            (int)(pivotX - nx * baseHalf),
            (int)(tip.getX() - nx * tipHalf),
            (int)(tip.getX() + nx * tipHalf)
        };
        int[] ys = {
            (int)(pivotY + ny * baseHalf),
            (int)(pivotY - ny * baseHalf),
            (int)(tip.getY() - ny * tipHalf),
            (int)(tip.getY() + ny * tipHalf)
        };

        // Body
        Color flipColor = pressed ? new Color(100, 220, 255) : new Color(60, 140, 220);
        g2.setColor(flipColor);
        g2.fillPolygon(xs, ys, 4);

        // Highlight
        g2.setColor(new Color(200, 240, 255, 100));
        g2.drawPolygon(xs, ys, 4);

        // Pivot dot
        g2.setColor(new Color(0, 60, 150));
        g2.fillOval((int)pivotX - 5, (int)pivotY - 5, 10, 10);
    }
}