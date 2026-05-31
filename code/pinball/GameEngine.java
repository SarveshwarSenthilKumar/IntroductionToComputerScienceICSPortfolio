package pinball.game;

import java.awt.*;
import java.util.*;
import java.util.List;
import pinball.store.PowerUp;
import pinball.store.PowerUpManager;

/**
 * The core simulation engine for the pinball game.
 *
 * <p>Responsibilities:
 * <ul>
 *   <li>Initializing the playfield (bumpers, flippers, paddle)</li>
 *   <li>Running one physics tick per frame</li>
 *   <li>Detecting and resolving collisions</li>
 *   <li>Applying power-up effects</li>
 *   <li>Managing ball lifecycle (launch, drain, multi-ball)</li>
 * </ul>
 *
 * <p>The engine does NOT own a game loop thread — that lives in
 * {@link pinball.ui.GamePanel}. The engine exposes a single
 * {@link #tick()} method called by the panel's timer.
 */
public class GameEngine {

    // ---- Physics constants ----
    private static final double GRAVITY    = 0.25;
    private static final double MAX_SPEED  = 18.0;
    private static final double WALL_DAMPING = 0.85;

    // ---- Coin / score config ----
    private static final int BUMPER_SCORE_BASE = 100;

    private final GameState state;

    /** Callback interface so the engine can notify the UI of important events. */
    public interface EngineListener {
        void onBallDrained(int ballsLeft);
        void onGameOver(int finalScore, int coinsEarned);
        void onCoinsEarned(int delta, int total);
    }

    private EngineListener listener;

    public GameEngine(int fieldWidth, int fieldHeight) {
        state = new GameState(fieldWidth, fieldHeight);
        buildPlayfield();
    }

    public void setListener(EngineListener l) { this.listener = l; }
    public GameState getState() { return state; }

    // =========================================================================
    // Playfield construction
    // =========================================================================

    /**
     * Populates the playfield with bumpers, flippers, and the paddle.
     * Called once during construction.
     */
    private void buildPlayfield() {
        int W = state.getFieldWidth();
        int H = state.getFieldHeight();

        // --- Bumpers ---
        Color[] colors = {
            new Color(255, 60, 100),   // red-pink
            new Color(255, 160, 0),    // orange
            new Color(0, 200, 255),    // cyan
            new Color(160, 0, 255),    // purple
            new Color(0, 230, 100),    // green
            new Color(255, 220, 0),    // gold
            new Color(255, 80, 200),   // magenta
        };
        String[] labels = {"A", "B", "C", "D", "E", "F", "G"};
        int[] pts       = {100, 150, 200, 100, 250, 150, 300};
        int[] cns       = {10,  15,  20,  10,  25,  15,  30};

        // Three rows of bumpers
        int[][] positions = {
            {W/2,            H/5},
            {W/4,            H/4},
            {3*W/4,          H/4},
            {W/6,            H*2/5},
            {5*W/6,          H*2/5},
            {W/3,            H/3},
            {2*W/3,          H/3},
        };

        for (int i = 0; i < positions.length; i++) {
            state.addBumper(new Bumper(
                positions[i][0], positions[i][1],
                pts[i], cns[i], labels[i], colors[i % colors.length]
            ));
        }

        // --- Flippers ---
        int flipperY = H - 80;
        int leftPivot  = W / 2 - 80;
        int rightPivot = W / 2 + 80;
        state.addFlipper(new Flipper(leftPivot,  flipperY, true));
        state.addFlipper(new Flipper(rightPivot, flipperY, false));

        // --- Paddle ---
        int paddleY = H - 50;
        state.setPaddle(new Paddle(W / 2.0, paddleY, 20, W - 20));
    }

    // =========================================================================
    // Game tick
    // =========================================================================

    /**
     * Advances the simulation by one frame. Handles physics, collisions,
     * power-up ticks, and game-over detection.
     */
    public void tick() {
        if (state.isGameOver() || state.isPaused()) return;

        PowerUpManager pum = state.getPowerUpManager();
        pum.tick();

        // Process instant power-ups (multi-ball, extra life)
        for (PowerUp p : pum.drainInstant()) {
            applyInstantPowerUp(p);
        }

        // Update paddle
        double widthMult = pum.getPaddleWidthMultiplier();
        state.getPaddle().update(widthMult);

        // Update flippers
        for (Flipper f : state.getFlippers()) f.update();

        // Update bumpers
        for (Bumper b : state.getBumpers()) b.tick();

        // Update balls
        double speedMult = pum.getBallSpeedMultiplier();
        List<Ball> balls = state.getBalls();
        for (Ball ball : balls) {
            if (!ball.isActive()) continue;
            moveBall(ball, speedMult);
            handleWallCollisions(ball);
            handlePaddleCollision(ball);
            handleFlipperCollisions(ball);
            handleBumperCollisions(ball, pum);
            checkBallDrained(ball);
        }

        // Remove dead balls from list
        balls.removeIf(b -> !b.isActive());

        // Check for ball-in-play loss
        if (state.isBallInPlay() && state.activeBallCount() == 0) {
            handleBallDrain();
        }

        // Advance popups
        state.getPopups().removeIf(p -> { p.tick(); return p.isDead(); });
    }

    // =========================================================================
    // Ball physics
    // =========================================================================

    private void moveBall(Ball ball, double speedMult) {
        ball.applyGravity(GRAVITY * speedMult);
        ball.setVx(ball.getVx() * speedMult);
        ball.setVy(ball.getVy() * speedMult);
        ball.move();
        // Restore velocity (speedMult already applied)
        ball.setVx(ball.getVx() / speedMult);
        ball.setVy(ball.getVy() / speedMult);
        ball.clampSpeed(MAX_SPEED);
    }

    private void handleWallCollisions(Ball ball) {
        int W = state.getFieldWidth();

        // Left wall
        if (ball.getX() - Ball.RADIUS < 20) {
            ball.setX(20 + Ball.RADIUS);
            ball.setVx(Math.abs(ball.getVx()) * WALL_DAMPING);
        }
        // Right wall
        if (ball.getX() + Ball.RADIUS > W - 20) {
            ball.setX(W - 20 - Ball.RADIUS);
            ball.setVx(-Math.abs(ball.getVx()) * WALL_DAMPING);
        }
        // Top wall
        if (ball.getY() - Ball.RADIUS < 20) {
            ball.setY(20 + Ball.RADIUS);
            ball.setVy(Math.abs(ball.getVy()) * WALL_DAMPING);
        }
    }

    private void handlePaddleCollision(Ball ball) {
        Paddle paddle = state.getPaddle();
        if (ball.getVy() <= 0) return; // only collide when falling

        java.awt.geom.Rectangle2D pb = paddle.getBounds();
        if (pb.contains(ball.getX(), ball.getY() + Ball.RADIUS) ||
            pb.intersects(ball.getX() - Ball.RADIUS, ball.getY(), Ball.DIAMETER, Ball.DIAMETER)) {

            // Angle the bounce based on hit position on paddle
            double hitPos = (ball.getX() - paddle.getCenterX()) / (paddle.getWidth() / 2.0);
            hitPos = Math.max(-1, Math.min(1, hitPos));

            double speed = Math.max(ball.getSpeed(), 8);
            ball.setVx(hitPos * speed * 0.8);
            ball.setVy(-Math.abs(ball.getVy()) - 1.0);
            ball.setY(paddle.getY() - Ball.RADIUS - 1);

            // Score small amount for paddle save
            int pts = 10 * state.getPowerUpManager().getScoreMultiplier();
            state.addScore(pts);
            spawnPopup(ball.getX(), ball.getY() - 20, "+" + pts, new Color(150, 255, 150));
        }
    }

    private void handleFlipperCollisions(Ball ball) {
        for (Flipper f : state.getFlippers()) {
            if (f.isColliding(ball)) {
                f.reflect(ball);
                spawnPopup(ball.getX(), ball.getY() - 20, "+20", Color.CYAN);
                state.addScore(20 * state.getPowerUpManager().getScoreMultiplier());
                break;
            }
        }
    }

    private void handleBumperCollisions(Ball ball, PowerUpManager pum) {
        for (Bumper bumper : state.getBumpers()) {
            if (!bumper.isColliding(ball)) continue;

            bumper.onHit();
            bumper.reflect(ball);

            int scoreMult = pum.getScoreMultiplier();
            int coinMult  = pum.getCoinMultiplier();

            int pts   = bumper.getPointValue() * scoreMult;
            int coins = bumper.getCoinValue()  * coinMult;

            state.addScore(pts);
            state.addCoins(coins);

            if (listener != null) listener.onCoinsEarned(coins, state.getSessionCoins());

            spawnPopup(bumper.getX() - 20, bumper.getY() - 30,
                "+" + pts, new Color(255, 200, 50));
            spawnPopup(bumper.getX() + 10, bumper.getY() - 15,
                "+" + coins + "¢", new Color(255, 215, 0));
        }
    }

    private void checkBallDrained(Ball ball) {
        boolean forceField = state.getPowerUpManager().hasForceField();
        if (ball.getY() - Ball.RADIUS > state.getFieldHeight()) {
            if (forceField) {
                // Bounce back up
                ball.setVy(-Math.abs(ball.getVy()) - 2);
                ball.setY(state.getFieldHeight() - Ball.RADIUS - 5);
                spawnPopup(ball.getX(), state.getFieldHeight() - 60,
                    "SAVED!", new Color(0, 255, 120));
            } else {
                ball.deactivate();
            }
        }
    }

    // =========================================================================
    // Ball lifecycle
    // =========================================================================

    /**
     * Launches a new ball from the right gutter area.
     */
    public void launchBall() {
        if (state.isGameOver()) return;
        int W = state.getFieldWidth();
        Ball b = new Ball(W - 35, 200, -2, -8);
        state.addBallEntity(b);
        state.setBallInPlay(true);
    }

    private void handleBallDrain() {
        state.setBallInPlay(false);
        state.decrementBalls();

        if (listener != null) listener.onBallDrained(state.getBallsRemaining());

        if (state.getBallsRemaining() <= 0) {
            state.setGameOver();
            if (listener != null) {
                listener.onGameOver(state.getScore(), state.getSessionCoins());
            }
        }
    }

    // =========================================================================
    // Power-up application
    // =========================================================================

    /**
     * Processes an instant power-up effect immediately.
     *
     * @param p the instant power-up to apply
     */
    private void applyInstantPowerUp(PowerUp p) {
        switch (p) {
            case MULTI_BALL -> {
                // Launch two additional balls at random angles
                int W = state.getFieldWidth();
                int H = state.getFieldHeight();
                Random rnd = new Random();
                for (int i = 0; i < 2; i++) {
                    double vx = (rnd.nextDouble() * 8 - 4);
                    double vy = -(6 + rnd.nextDouble() * 4);
                    Ball b = new Ball(W / 2.0 + (i == 0 ? -50 : 50), H / 3.0, vx, vy);
                    state.addBallEntity(b);
                }
                state.setBallInPlay(true);
                spawnPopup(state.getFieldWidth() / 2.0, state.getFieldHeight() / 2.0,
                    "MULTI-BALL!", new Color(255, 120, 0));
            }
            case EXTRA_LIFE -> {
                state.addBall();
                spawnPopup(state.getFieldWidth() / 2.0, state.getFieldHeight() / 3.0,
                    "+1 LIFE!", new Color(255, 50, 50));
            }
            default -> {} // Non-instant power-ups handled by PowerUpManager
        }
    }

    /**
     * Activates a purchased power-up on the current game state.
     *
     * @param p the power-up to activate
     */
    public void activatePowerUp(PowerUp p) {
        state.getPowerUpManager().activate(p);
        spawnPopup(state.getFieldWidth() / 2.0, state.getFieldHeight() / 2.0 - 30,
            p.getDisplayName() + " ACTIVE!", p.getColor());
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private void spawnPopup(double x, double y, String text, Color color) {
        state.addPopup(new ScorePopup(x, y, text, color, 60));
    }

    // =========================================================================
    // Input delegation
    // =========================================================================

    public void setLeftFlipperPressed(boolean v) {
        for (Flipper f : state.getFlippers()) if (f instanceof Flipper ff && isLeftFlipper(ff)) ff.setPressed(v);
        // Simpler approach: index-based
        List<Flipper> fl = state.getFlippers();
        if (!fl.isEmpty()) fl.get(0).setPressed(v);
    }

    public void setRightFlipperPressed(boolean v) {
        List<Flipper> fl = state.getFlippers();
        if (fl.size() > 1) fl.get(1).setPressed(v);
    }

    public void setPaddleLeft(boolean v)  { state.getPaddle().setMovingLeft(v); }
    public void setPaddleRight(boolean v) { state.getPaddle().setMovingRight(v); }

    private boolean isLeftFlipper(Flipper f) {
        return f.getPivotX() < state.getFieldWidth() / 2.0;
    }
}