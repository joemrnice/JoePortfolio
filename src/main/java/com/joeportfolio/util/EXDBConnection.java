package com.joeportfolio.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * TestDBConnection — Railway-compatible JDBC Utility
 * ─────────────────────────────────────────────────
 * Reads ALL credentials from environment variables.
 * Falls back to localhost defaults for local development.
 *
 * Railway MySQL plugin injects:
 *   MYSQL_HOST, MYSQL_PORT, MYSQL_DATABASE,
 *   MYSQL_USER, MYSQL_PASSWORD
 *
 * Author: Code Zerra
 */
public class EXDBConnection {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // ── Read from environment — fallback to XAMPP defaults ───
    private static final String HOST =
        getEnv("MYSQL_HOST", "localhost");

    private static final String PORT =
        getEnv("MYSQL_PORT", "3306");

    private static final String DATABASE =
        getEnv("MYSQL_DATABASE", "joe_portfolio");

    private static final String USER =
        getEnv("MYSQL_USER", "root");

    private static final String PASSWORD =
        getEnv("MYSQL_PASSWORD", "");

    // ── Build JDBC URL from parts ─────────────────────────────
    private static final String URL =
        "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE
        + "?useSSL=false"
        + "&serverTimezone=UTC"
        + "&useUnicode=true"
        + "&characterEncoding=UTF-8"
        + "&allowPublicKeyRetrieval=true";

    private EXDBConnection() {}

    /**
     * Returns a live JDBC Connection.
     * Caller must close it in a finally block.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            System.out.println("[TestDBConnection] Connecting to: "
                + HOST + ":" + PORT + "/" + DATABASE);
            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            throw new SQLException(
                "MySQL JDBC Driver not found. "
                + "Add mysql-connector-j JAR to WEB-INF/lib.", e);
        }
    }

    /**
     * Safely closes a Connection — null-safe.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); }
            catch (SQLException e) {
                System.err.println("[TestDBConnection] Close error: "
                    + e.getMessage());
            }
        }
    }

    /**
     * Reads an environment variable.
     * Returns the fallback value if not set.
     */
    private static String getEnv(String key, String fallback) {
        String value = System.getenv(key);
        return (value != null && !value.trim().isEmpty())
               ? value.trim()
               : fallback;
    }
}
