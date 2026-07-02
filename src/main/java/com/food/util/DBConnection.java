package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Read from environment variables (set on Railway/Render)
    // Falls back to localhost defaults for local development
    private static String getUrl() {
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String db   = System.getenv("MYSQLDATABASE");
        if (host != null && port != null && db != null) {
            return "jdbc:mysql://" + host + ":" + port + "/" + db
                    + "?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }
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

    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(getUrl(), getUser(), getPassword());
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

