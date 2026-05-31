package pinball.auth;

import java.io.*;
import java.nio.file.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * Manages user authentication, registration, and persistence.
 * Users are stored in a plain-text file (users.txt) with hashed passwords.
 *
 * <p>File format per line: username,sha256hash,coins,highScore</p>
 */
public class AuthManager {

    private static final String USERS_FILE = "data/users.txt";
    private static final String SCORES_FILE = "data/scores.txt";

    /** In-memory map of username -> User for quick lookup. */
    private final Map<String, User> users = new HashMap<>();

    /** Currently logged-in user. */
    private User currentUser;

    public AuthManager() {
        ensureDataDirectory();
        loadUsers();
    }

    // -------------------------------------------------------------------------
    // Public API
    // -------------------------------------------------------------------------

    /**
     * Registers a new user if the username is not already taken.
     *
     * @param username plaintext username
     * @param password plaintext password (will be hashed)
     * @return true if registration succeeded, false if username already exists
     */
    public boolean register(String username, String password) {
        if (username == null || username.isBlank()) return false;
        if (password == null || password.length() < 4) return false;
        if (users.containsKey(username.toLowerCase())) return false;

        String hash = sha256(password);
        User user = new User(username, hash, 0, 0);
        users.put(username.toLowerCase(), user);
        saveUsers();
        return true;
    }

    /**
     * Attempts to log in with the given credentials.
     *
     * @param username plaintext username
     * @param password plaintext password
     * @return true if login succeeded
     */
    public boolean login(String username, String password) {
        User user = users.get(username.toLowerCase());
        if (user == null) return false;
        if (!user.getPasswordHash().equals(sha256(password))) return false;
        currentUser = user;
        return true;
    }

    /** Logs out the current user. */
    public void logout() {
        currentUser = null;
    }

    /** @return the currently logged-in User, or null if none */
    public User getCurrentUser() { return currentUser; }

    /**
     * Persists the current user's coin balance and high score to disk.
     * Called after each game session.
     */
    public void saveCurrentUser() {
        if (currentUser != null) saveUsers();
    }

    /**
     * Appends a score entry to the scores file.
     *
     * @param username  the player's name
     * @param score     the score achieved
     */
    public void saveScore(String username, int score) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(SCORES_FILE, true))) {
            bw.write(username + "," + score + "," + System.currentTimeMillis());
            bw.newLine();
        } catch (IOException e) {
            System.err.println("Failed to save score: " + e.getMessage());
        }
    }

    /**
     * Reads the top 10 all-time scores from the scores file.
     *
     * @return list of String[] {username, score} sorted descending
     */
    public List<String[]> getTopScores() {
        List<int[]> rawScores = new ArrayList<>();
        List<String> names = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(SCORES_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2) {
                    names.add(parts[0]);
                    rawScores.add(new int[]{ Integer.parseInt(parts[1]), names.size() - 1 });
                }
            }
        } catch (IOException | NumberFormatException ignored) {}

        rawScores.sort((a, b) -> b[0] - a[0]);

        List<String[]> result = new ArrayList<>();
        for (int i = 0; i < Math.min(10, rawScores.size()); i++) {
            int[] entry = rawScores.get(i);
            result.add(new String[]{ names.get(entry[1]), String.valueOf(entry[0]) });
        }
        return result;
    }

    // -------------------------------------------------------------------------
    // Private helpers
    // -------------------------------------------------------------------------

    private void ensureDataDirectory() {
        try {
            Files.createDirectories(Paths.get("data"));
        } catch (IOException e) {
            System.err.println("Cannot create data directory: " + e.getMessage());
        }
    }

    private void loadUsers() {
        users.clear();
        File f = new File(USERS_FILE);
        if (!f.exists()) return;

        try (BufferedReader br = new BufferedReader(new FileReader(f))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    User u = User.fromFileString(line);
                    if (u != null) users.put(u.getUsername().toLowerCase(), u);
                }
            }
        } catch (IOException e) {
            System.err.println("Failed to load users: " + e.getMessage());
        }
    }

    private void saveUsers() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(USERS_FILE))) {
            for (User u : users.values()) {
                bw.write(u.toFileString());
                bw.newLine();
            }
        } catch (IOException e) {
            System.err.println("Failed to save users: " + e.getMessage());
        }
    }

    private static String sha256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }
}