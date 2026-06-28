package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

/**
 * Utility class for opening new MySQL connections per request.
 * Reads database credentials from db.properties file to keep them secure.
 */
public class DBConnection {

    private static String URL;
    private static String USERNAME;
    private static String PASSWORD;
    private static String DRIVER;

    static {
        try {
            // Read from src/main/java/db.properties
            ResourceBundle rb = ResourceBundle.getBundle("db");
            URL = rb.getString("db.url");
            USERNAME = rb.getString("db.username");
            PASSWORD = rb.getString("db.password");
            DRIVER = rb.getString("db.driver");
            
            Class.forName(DRIVER);
        } catch (Exception e) {
            System.err.println("Error loading DB configuration: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Opens and returns a new database connection.
     * Callers MUST close() it (ideally via try-with-resources).
     */
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            System.err.println("Failed to connect to database: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /** Silently closes a connection (null-safe). */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
