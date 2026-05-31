package pinball.auth;

/**
 * Represents a registered user of the Pinball Machine.
 * Stores credentials, coin balance, and high score.
 */
public class User {

    private final String username;
    private String passwordHash;
    private int coins;
    private int highScore;

    /**
     * Constructs a new User with the given credentials.
     *
     * @param username     the unique username
     * @param passwordHash SHA-256 hash of the user's password
     * @param coins        starting coin count
     * @param highScore    best recorded score
     */
    public User(String username, String passwordHash, int coins, int highScore) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.coins = coins;
        this.highScore = highScore;
    }

    public String getUsername() { return username; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String hash) { this.passwordHash = hash; }

    public int getCoins() { return coins; }
    public void addCoins(int amount) { this.coins = Math.max(0, this.coins + amount); }
    public void spendCoins(int amount) { this.coins = Math.max(0, this.coins - amount); }

    public int getHighScore() { return highScore; }
    public void updateHighScore(int score) {
        if (score > highScore) this.highScore = score;
    }

    /**
     * Serializes this user to a CSV-style string for file storage.
     *
     * @return comma-separated string: username,passwordHash,coins,highScore
     */
    public String toFileString() {
        return username + "," + passwordHash + "," + coins + "," + highScore;
    }

    /**
     * Deserializes a User from a CSV-style file line.
     *
     * @param line the file line to parse
     * @return a User object, or null if the line is malformed
     */
    public static User fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length != 4) return null;
        try {
            return new User(parts[0], parts[1], Integer.parseInt(parts[2]), Integer.parseInt(parts[3]));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    public String toString() {
        return "User{username='" + username + "', coins=" + coins + ", highScore=" + highScore + "}";
    }
}