package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static String getUrl() {
        String host = System.getenv("PGHOST");
        String port = System.getenv("PGPORT");
        String db   = System.getenv("PGDATABASE");
        if (host != null && port != null && db != null) {
            System.out.println("[DBConnection] Connecting to Supabase PostgreSQL: " + host + ":" + port + "/" + db);
            return "jdbc:postgresql://" + host + ":" + port + "/" + db
                    + "?sslmode=require";
        }
        System.out.println("[DBConnection] Env vars not found, using localhost fallback");
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

    public static Connection getConnection() {
        String host = System.getenv("PGHOST");
        boolean usingEnv = (host != null);

        try {
            Class.forName("org.postgresql.Driver");
            if (usingEnv) {
                try {
                    return DriverManager.getConnection(getUrl(), getUser(), getPassword());
                } catch (SQLException e) {
                    System.err.println("[DBConnection] WARNING: Failed to connect to Supabase (" + e.getMessage() + "). Falling back to localhost...");
                }
            }
            return DriverManager.getConnection("jdbc:postgresql://localhost:5432/food_app", "postgres", "postgres");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("[DBConnection] ERROR: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database connection failed: " + e.getMessage(), e);
        }
    }

    // Kept for backward compatibility - no-op since we no longer use singleton
    public static void closeConnection() {
        // Connections are closed by try-with-resources in each DAO
    }
}


