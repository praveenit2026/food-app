package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    /** True when the last connection attempt succeeded. */
    private static volatile boolean dbAvailable = true;

    private static String getUrl() {
        String host = System.getenv("PGHOST");
        String port = System.getenv("PGPORT");
        String db   = System.getenv("PGDATABASE");
        if (host != null && port != null && db != null) {
            return "jdbc:postgresql://" + host + ":" + port + "/" + db + "?sslmode=require";
        }
        return "jdbc:postgresql://localhost:5432/food_app";
    }

    private static String getUser() {
        String user = System.getenv("PGUSER");
        return user != null ? user : "postgres";
    }

    private static String getPassword() {
        String pass = System.getenv("PGPASSWORD");
        return pass != null ? pass : "postgres";
    }

    /**
     * Returns a live Connection, or null if the database is unreachable.
     * Never throws — callers should check for null and use FallbackData.
     */
    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(getUrl(), getUser(), getPassword());
            if (!dbAvailable) {
                System.out.println("[DBConnection] Database connection restored.");
            }
            dbAvailable = true;
            return conn;
        } catch (ClassNotFoundException | SQLException e) {
            if (dbAvailable) {
                // Log only on first failure to avoid log spam
                System.err.println("[DBConnection] Database unavailable – serving fallback data. Reason: " + e.getMessage());
            }
            dbAvailable = false;
            return null; // Callers must handle null
        }
    }

    /** Whether the last connection attempt succeeded. */
    public static boolean isAvailable() {
        return dbAvailable;
    }

    // Kept for backward compatibility
    public static void closeConnection() {}
}


