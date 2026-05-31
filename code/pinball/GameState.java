package pinball.game;

import java.util.*;
import pinball.store.PowerUpManager;

/**
 * Encapsulates the complete mutable state of a single pinball game session.
 * The {@link GameEngine} reads and mutates this object each tick.
 */
public class GameState {

    // ---- Scoring & economy ----
    private int score        = 0;
    private int coins        = 0;   // earned this session (added to user account on game-over)
    private int ballsRemaining = 3;

    // ---- Entities ----
    private final List<Ball>        balls        = new ArrayList<>();
    private final List<Bumper>      bumpers      = new ArrayList<>();
    private final List<Flipper>     flippers     = new ArrayList<>();
    private final List<ScorePopup>  popups       = new ArrayList<>();
    private Paddle paddle;

    // ---- Power-up state ----
    private final PowerUpManager powerUpManager = new PowerUpManager();

    // ---- Game flow flags ----
    private boolean gameOver    = false;
    private boolean paused      = false;
    private boolean ballInPlay  = false;

    // ---- Field dimensions ----
    private final int fieldWidth;
    private final int fieldHeight;

    /**
     * @param fieldWidth  pixel width of the playfield
     * @param fieldHeight pixel height of the playfield
     */
    public GameState(int fieldWidth, int fieldHeight) {
        this.fieldWidth  = fieldWidth;
        this.fieldHeight = fieldHeight;
    }

    // -------------------------------------------------------------------------
    // Score & coins
    // -------------------------------------------------------------------------

    public int getScore() { return score; }
    public void addScore(int pts) { score += pts; }

    public int getSessionCoins() { return coins; }
    public void addCoins(int c) { coins += c; }

    public int getBallsRemaining() { return ballsRemaining; }
    public void decrementBalls() { ballsRemaining = Math.max(0, ballsRemaining - 1); }
    public void addBall() { ballsRemaining++; }

    // -------------------------------------------------------------------------
    // Entities
    // -------------------------------------------------------------------------

    public List<Ball>       getBalls()    { return balls; }
    public List<Bumper>     getBumpers()  { return bumpers; }
    public List<Flipper>    getFlippers() { return flippers; }
    public List<ScorePopup> getPopups()   { return popups; }

    public Paddle getPaddle() { return paddle; }
    public void   setPaddle(Paddle p) { this.paddle = p; }

    public void addBallEntity(Ball b) { balls.add(b); }
    public void addBumper(Bumper b)   { bumpers.add(b); }
    public void addFlipper(Flipper f) { flippers.add(f); }
    public void addPopup(ScorePopup p) { popups.add(p); }

    // -------------------------------------------------------------------------
    // Power-ups
    // -------------------------------------------------------------------------

    public PowerUpManager getPowerUpManager() { return powerUpManager; }

    // -------------------------------------------------------------------------
    // Flow control
    // -------------------------------------------------------------------------

    public boolean isGameOver()   { return gameOver; }
    public void    setGameOver()  { this.gameOver = true; }

    public boolean isPaused()     { return paused; }
    public void    togglePause()  { paused = !paused; }

    public boolean isBallInPlay()     { return ballInPlay; }
    public void    setBallInPlay(boolean v) { this.ballInPlay = v; }

    // -------------------------------------------------------------------------
    // Field geometry
    // -------------------------------------------------------------------------

    public int getFieldWidth()  { return fieldWidth; }
    public int getFieldHeight() { return fieldHeight; }

    /** @return the number of currently active balls on the field */
    public int activeBallCount() {
        int n = 0;
        for (Ball b : balls) if (b.isActive()) n++;
        return n;
    }
}