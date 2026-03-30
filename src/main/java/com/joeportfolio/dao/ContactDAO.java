package com.joeportfolio.dao;

import com.joeportfolio.model.Contact;
import com.joeportfolio.util.TestDBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ContactDAO - Data Access Object
 * ---------------------------------------------------
 * Handles all JDBC database operations for the Contact model.
 * All queries use PreparedStatements (SQL-injection safe).
 *
 * Operations:
 *   save()       → INSERT a new contact submission
 *   findAll()    → SELECT all contacts (newest first)
 *   findById()   → SELECT single contact by ID
 *   countUnread()→ COUNT unread contacts
 *
 * Author : Code Zerra
 */
public class ContactDAO {

    // ── SQL Queries ───────────────────────────────────────────

    private static final String SQL_INSERT =
        "INSERT INTO contacts (name, email, subject, message, ip_address) "
      + "VALUES (?, ?, ?, ?, ?)";

    private static final String SQL_FIND_ALL =
        "SELECT id, name, email, subject, message, submitted_at, is_read, ip_address "
      + "FROM contacts "
      + "ORDER BY submitted_at DESC";

    private static final String SQL_FIND_BY_ID =
        "SELECT id, name, email, subject, message, submitted_at, is_read, ip_address "
      + "FROM contacts "
      + "WHERE id = ?";

    private static final String SQL_COUNT_UNREAD =
        "SELECT COUNT(*) FROM contacts WHERE is_read = 0";

    // ── save() ────────────────────────────────────────────────

    /**
     * Inserts a new contact message into the database.
     *
     * @param contact  Contact object populated from the form
     * @return         true if insert was successful, false otherwise
     */
    public boolean save(Contact contact) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn  = TestDBConnection.getConnection();
            pstmt = conn.prepareStatement(SQL_INSERT);

            // Bind parameters — matches (?, ?, ?, ?, ?) in SQL_INSERT
            pstmt.setString(1, contact.getName().trim());
            pstmt.setString(2, contact.getEmail().trim().toLowerCase());
            pstmt.setString(3, contact.getSubject().trim());
            pstmt.setString(4, contact.getMessage().trim());
            pstmt.setString(5, contact.getIpAddress());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("[ContactDAO] Contact saved: " + contact.getEmail());
                return true;
            }
            return false;

        } catch (SQLException e) {
            System.err.println("[ContactDAO] Error saving contact: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            // Always close resources to prevent connection leaks
            closeResources(conn, pstmt, null);
        }
    }

    // ── findAll() ────────────────────────────────────────────

    /**
     * Retrieves all contact submissions, newest first.
     *
     * @return  List of Contact objects (empty list if none found)
     */
    public List<Contact> findAll() {
        Connection conn        = null;
        PreparedStatement pstmt = null;
        ResultSet rs           = null;
        List<Contact> contacts = new ArrayList<>();

        try {
            conn  = TestDBConnection.getConnection();
            pstmt = conn.prepareStatement(SQL_FIND_ALL);
            rs    = pstmt.executeQuery();

            while (rs.next()) {
                contacts.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("[ContactDAO] Error fetching contacts: " + e.getMessage());
            e.printStackTrace();

        } finally {
            closeResources(conn, pstmt, rs);
        }

        return contacts;
    }

    // ── findById() ───────────────────────────────────────────

    /**
     * Finds a single contact by its primary key.
     *
     * @param id  the contact's database ID
     * @return    Contact object, or null if not found
     */
    public Contact findById(int id) {
        Connection conn        = null;
        PreparedStatement pstmt = null;
        ResultSet rs           = null;

        try {
            conn  = TestDBConnection.getConnection();
            pstmt = conn.prepareStatement(SQL_FIND_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {
            System.err.println("[ContactDAO] Error finding contact by ID: " + e.getMessage());
            e.printStackTrace();

        } finally {
            closeResources(conn, pstmt, rs);
        }

        return null;  // Not found
    }

    // ── countUnread() ────────────────────────────────────────

    /**
     * Returns the number of unread contact messages.
     *
     * @return  count of unread messages (is_read = 0)
     */
    public int countUnread() {
        Connection conn        = null;
        PreparedStatement pstmt = null;
        ResultSet rs           = null;

        try {
            conn  = TestDBConnection.getConnection();
            pstmt = conn.prepareStatement(SQL_COUNT_UNREAD);
            rs    = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("[ContactDAO] Error counting unread: " + e.getMessage());

        } finally {
            closeResources(conn, pstmt, rs);
        }

        return 0;
    }

    // ── mapRow() — private helper ─────────────────────────────

    /**
     * Maps a single ResultSet row to a Contact object.
     * Centralizes column-to-field mapping in one place.
     *
     * @param rs  ResultSet positioned at the current row
     * @return    populated Contact object
     * @throws    SQLException if column access fails
     */
    private Contact mapRow(ResultSet rs) throws SQLException {
        return new Contact(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("subject"),
            rs.getString("message"),
            rs.getTimestamp("submitted_at"),
            rs.getBoolean("is_read"),
            rs.getString("ip_address")
        );
    }

    // ── closeResources() — private helper ────────────────────

    /**
     * Closes JDBC resources in the correct order (RS → Stmt → Conn).
     * Safely handles null references and already-closed resources.
     *
     * @param conn   Connection to close (can be null)
     * @param pstmt  PreparedStatement to close (can be null)
     * @param rs     ResultSet to close (can be null)
     */
    private void closeResources(Connection conn,
                                 PreparedStatement pstmt,
                                 ResultSet rs) {
        // Close ResultSet first
        if (rs != null) {
            try { rs.close(); }
            catch (SQLException e) {
                System.err.println("[ContactDAO] Error closing ResultSet: " + e.getMessage());
            }
        }
        // Then PreparedStatement
        if (pstmt != null) {
            try { pstmt.close(); }
            catch (SQLException e) {
                System.err.println("[ContactDAO] Error closing Statement: " + e.getMessage());
            }
        }
        // Finally the Connection — returns it to pool / closes it
        TestDBConnection.closeConnection(conn);
    }
}