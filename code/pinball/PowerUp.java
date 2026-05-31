package pinball.store;

import java.awt.Color;

/**
 * Enumeration of all purchasable power-ups available in the in-game store.
 * Each power-up has a name, description, price, duration, and visual tint color.
 */
public enum PowerUp {

    /**
     * Widens the player's paddle for easier ball control.
     */
    WIDE_PADDLE(
        "Wide Paddle",
        "Doubles paddle width for 30 seconds",
        150,
        30_000,
        new Color(0, 200, 255)
    ),

    /**
     * Slows down ball movement to give more reaction time.
     */
    SLOW_BALL(
        "Slow Motion",
        "Halves ball speed for 20 seconds",
        200,
        20_000,
        new Color(255, 200, 0)
    ),

    /**
     * Multiplies all scoring by 3x.
     */
    SCORE_MULTIPLIER(
        "3x Score Boost",
        "Triples all points for 15 seconds",
        300,
        15_000,
        new Color(255, 50, 200)
    ),

    /**
     * Adds an extra ball to the field.
     */
    MULTI_BALL(
        "Multi-Ball",
        "Launches 2 extra balls instantly",
        400,
        0,   // instant
        new Color(255, 120, 0)
    ),

    /**
     * Creates a force field at the bottom to prevent ball loss.
     */
    FORCE_FIELD(
        "Force Field",
        "Bottom barrier prevents ball loss for 10 seconds",
        350,
        10_000,
        new Color(0, 255, 100)
    ),

    /**
     * Makes bumpers award 5x coins for a limited time.
     */
    COIN_MAGNET(
        "Coin Magnet",
        "Bumpers award 5x coins for 25 seconds",
        250,
        25_000,
        new Color(255, 215, 0)
    ),

    /**
     * Grants an extra life (ball save).
     */
    EXTRA_LIFE(
        "Extra Life",
        "Gain one additional ball",
        500,
        0,   // instant
        new Color(255, 50, 50)
    );

    // -------------------------------------------------------------------------

    private final String displayName;
    private final String description;
    private final int price;
    private final long durationMs;
    private final Color color;

    PowerUp(String displayName, String description, int price, long durationMs, Color color) {
        this.displayName = displayName;
        this.description = description;
        this.price = price;
        this.durationMs = durationMs;
        this.color = color;
    }

    public String getDisplayName() { return displayName; }
    public String getDescription() { return description; }
    public int getPrice() { return price; }
    public long getDurationMs() { return durationMs; }
    public Color getColor() { return color; }

    /** @return true if this power-up applies instantly rather than over time */
    public boolean isInstant() { return durationMs == 0; }
}