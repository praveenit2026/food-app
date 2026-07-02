package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static String getUrl() {
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String db   = System.getenv("MYSQLDATABASE");
        if (host != null && port != null && db != null) {
            System.out.println("[DBConnection] Connecting to Aiven: " + host + ":" + port + "/" + db);
            return "jdbc:mysql://" + host + ":" + port + "/" + db
                    + "?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC&verifyServerCertificate=false";
        }
        System.out.println("[DBConnection] Env vars not found, using localhost fallback");
        return "jdbc:mysql://localhost:3306/food_app?useSSL=false&serverTimezone=UTC";
    }

    private static String getUser() {
        String user = System.getenv("MYSQLUSER");
        return user != null ? user : "root";
    }

    private static String getPassword() {
        String pass = System.getenv("MYSQLPASSWORD");
        return pass != null ? pass : "mysql";
    }

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(getUrl(), getUser(), getPassword());
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


