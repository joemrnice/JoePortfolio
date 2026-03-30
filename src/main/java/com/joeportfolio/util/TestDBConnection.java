package com.joeportfolio.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * TestDBConnection - Singleton JDBC Utility Class
 * ---------------------------------------------------
 * Manages MySQL database connections for DijaPortfolio.
 * Uses direct JDBC (DriverManager) as primary method.
 *
 * Database : joe_portfolio
 * Host     : localhost (XAMPP MySQL)
 * Port     : 3306
 * User     : root
 * Password : (empty — default XAMPP)
 *
 * Author   : Code Zerra
 */
public class TestDBConnection {

    // ── Connection constants ──────────────────────────────────
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String URL      = "jdbc:mysql://localhost:3306/joe_portfolio"
                                         + "?useSSL=false"
                                         + "&serverTimezone=UTC"
                                         + "&useUnicode=true"
                                         + "&characterEncoding=UTF-8"
                                         + "&allowPublicKeyRetrieval=true";
    private static final String USER     = "root";
    private static final String PASSWORD = "";   // Change if you set a root password

    // ── Private constructor — prevent instantiation ───────────
    private TestDBConnection() {}

    /**
     * Returns a fresh JDBC Connection.
     * Caller is responsible for closing the connection.
     *
     * Usage:
     *   Connection conn = TestDBConnection.getConnection();
     *   // ... use conn ...
     *   conn.close();
     *
     * @return  java.sql.Connection
     * @throws  SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL JDBC driver class into JVM
            Class.forName(DRIVER);

            // Create and return a new connection
            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            // Driver JAR missing from WEB-INF/lib or Build Path
            System.err.println("[TestDBConnection] MySQL driver not found: " + e.getMessage());
            throw new SQLException("MySQL JDBC Driver not found. "
                    + "Ensure mysql-connector-j-8.x.x.jar is in WEB-INF/lib.", e);
        }
    }

    /**
     * Safely closes a Connection — silently ignores null or already-closed.
     * Call this in finally blocks to prevent connection leaks.
     *
     * @param conn  the Connection to close (can be null)
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("[TestDBConnection] Error closing connection: " + e.getMessage());
            }
        }
    }

    /**
     * Quick connectivity test — useful during development.
     * Remove or comment out in production.
     */
    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            System.out.println("[TestDBConnection] ✔ Connection to dija_portfolio successful!");
            return true;
        } catch (SQLException e) {
            System.err.println("[TestDBConnection] ✘ Connection failed: " + e.getMessage());
            return false;
        } finally {
            closeConnection(conn);
        }
    }
}