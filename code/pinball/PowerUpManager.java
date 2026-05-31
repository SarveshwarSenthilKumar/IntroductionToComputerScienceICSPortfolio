package pinball.store;

import java.util.*;

/**
 * Tracks which power-ups are currently active and their remaining duration.
 * The game engine queries this manager each tick to apply power-up effects.
 */
public class PowerUpManager {

    /** Maps active power-up -> expiry timestamp (System.currentTimeMillis). */
    private final Map<PowerUp, Long> activePowerUps = new EnumMap<>(PowerUp.class);

    /** Queue of power-ups purchased but not yet applied (e.g. MULTI_BALL). */
    private final Queue<PowerUp> pendingInstant = new LinkedList<>();

    /**
     * Activates a power-up. Timed power-ups record their expiry;
     * instant power-ups are queued for one-shot processing.
     *
     * @param p the power-up to activate
     */
    public void activate(PowerUp p) {
        if (p.isInstant()) {
            pendingInstant.add(p);
        } else {
            long expiry = System.currentTimeMillis() + p.getDurationMs();
            // If already active, extend the timer
            activePowerUps.merge(p, expiry, Math::max);
        }
    }

    /**
     * Removes expired timed power-ups. Should be called each game tick.
     */
    public void tick() {
        long now = System.currentTimeMillis();
        activePowerUps.entrySet().removeIf(e -> e.getValue() <= now);
    }

    /**
     * @param p the power-up to check
     * @return true if the given timed power-up is currently active
     */
    public boolean isActive(PowerUp p) {
        return activePowerUps.containsKey(p);
    }

    /**
     * Drains and returns all pending instant power-ups.
     *
     * @return list of instant power-ups to process this tick
     */
    public List<PowerUp> drainInstant() {
        List<PowerUp> result = new ArrayList<>(pendingInstant);
        pendingInstant.clear();
        return result;
    }

    /**
     * Returns remaining time (ms) for a timed power-up.
     *
     * @param p the power-up to check
     * @return remaining ms, or 0 if not active
     */
    public long remainingMs(PowerUp p) {
        Long expiry = activePowerUps.get(p);
        if (expiry == null) return 0;
        return Math.max(0, expiry - System.currentTimeMillis());
    }

    /** Clears all active power-ups (called on new game). */
    public void reset() {
        activePowerUps.clear();
        pendingInstant.clear();
    }

    /** @return current score multiplier (1 or 3) */
    public int getScoreMultiplier() {
        return isActive(PowerUp.SCORE_MULTIPLIER) ? 3 : 1;
    }

    /** @return current coin multiplier (1 or 5) */
    public int getCoinMultiplier() {
        return isActive(PowerUp.COIN_MAGNET) ? 5 : 1;
    }

    /** @return ball speed multiplier (0.5 or 1.0) */
    public double getBallSpeedMultiplier() {
        return isActive(PowerUp.SLOW_BALL) ? 0.5 : 1.0;
    }

    /** @return paddle width multiplier (2.0 or 1.0) */
    public double getPaddleWidthMultiplier() {
        return isActive(PowerUp.WIDE_PADDLE) ? 2.0 : 1.0;
    }

    /** @return true if force field is currently protecting the bottom */
    public boolean hasForceField() {
        return isActive(PowerUp.FORCE_FIELD);
    }

    /** @return all currently active timed power-ups */
    public Set<PowerUp> getActivePowerUps() {
        return Collections.unmodifiableSet(activePowerUps.keySet());
    }
}