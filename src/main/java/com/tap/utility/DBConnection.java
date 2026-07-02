package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for opening new MySQL connections per request.
 * Uses a new connection for every call — safe for try-with-resources pattern.
 */
public class DBConnection {

    private static final String URL      = "jdbc:mysql://localhost:3306/food_delivery_application?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Krishnan@2005";
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
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
