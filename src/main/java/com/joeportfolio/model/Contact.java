package com.joeportfolio.model;

import java.sql.Timestamp;

/**
 * Contact - JavaBean / POJO Model
 * ---------------------------------------------------
 * Represents a single contact form submission.
 * Maps directly to the `contacts` table in joe_portfolio.
 *
 * Fields:
 *   id           → contacts.id           (INT AUTO_INCREMENT)
 *   name         → contacts.name         (VARCHAR 100)
 *   email        → contacts.email        (VARCHAR 150)
 *   subject      → contacts.subject      (VARCHAR 200)
 *   message      → contacts.message      (TEXT)
 *   submittedAt  → contacts.submitted_at (DATETIME)
 *   isRead       → contacts.is_read      (TINYINT 0/1)
 *   ipAddress    → contacts.ip_address   (VARCHAR 45)
 *
 * Author : Code Zerra
 */
public class Contact {

    // ── Fields ────────────────────────────────────────────────
    private int       id;
    private String    name;
    private String    email;
    private String    subject;
    private String    message;
    private Timestamp submittedAt;
    private boolean   isRead;
    private String    ipAddress;

    // ── Constructors ──────────────────────────────────────────

    /**
     * Default no-arg constructor (required for JavaBean spec).
     */
    public Contact() {}

    /**
     * Constructor for creating a new contact submission
     * (id and submittedAt are auto-set by the database).
     *
     * @param name      sender's full name
     * @param email     sender's email address
     * @param subject   message subject
     * @param message   message body
     * @param ipAddress sender's IP address
     */
    public Contact(String name, String email, String subject,
                   String message, String ipAddress) {
        this.name      = name;
        this.email     = email;
        this.subject   = subject;
        this.message   = message;
        this.ipAddress = ipAddress;
        this.isRead    = false;  // Default: unread
    }

    /**
     * Full constructor — used when reading records from DB.
     */
    public Contact(int id, String name, String email, String subject,
                   String message, Timestamp submittedAt,
                   boolean isRead, String ipAddress) {
        this.id          = id;
        this.name        = name;
        this.email       = email;
        this.subject     = subject;
        this.message     = message;
        this.submittedAt = submittedAt;
        this.isRead      = isRead;
        this.ipAddress   = ipAddress;
    }

    // ── Getters & Setters ─────────────────────────────────────

    public int getId()                   { return id; }
    public void setId(int id)            { this.id = id; }

    public String getName()              { return name; }
    public void setName(String name)     { this.name = name; }

    public String getEmail()             { return email; }
    public void setEmail(String email)   { this.email = email; }

    public String getSubject()               { return subject; }
    public void setSubject(String subject)   { this.subject = subject; }

    public String getMessage()               { return message; }
    public void setMessage(String message)   { this.message = message; }

    public Timestamp getSubmittedAt()                    { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt)    { this.submittedAt = submittedAt; }

    public boolean isRead()              { return isRead; }
    public void setRead(boolean isRead)  { this.isRead = isRead; }

    public String getIpAddress()                   { return ipAddress; }
    public void setIpAddress(String ipAddress)     { this.ipAddress = ipAddress; }

    // ── Validation Helpers ────────────────────────────────────

    /**
     * Basic validation — checks all required fields are non-empty.
     * Called before saving to DB.
     *
     * @return true if the contact object is valid
     */
    public boolean isValid() {
        return name    != null && !name.trim().isEmpty()
            && email   != null && !email.trim().isEmpty()
            && subject != null && !subject.trim().isEmpty()
            && message != null && !message.trim().isEmpty();
    }

    /**
     * Simple email format check using regex.
     *
     * @return true if email format looks valid
     */
    public boolean isEmailValid() {
        if (email == null) return false;
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }

    // ── toString ─────────────────────────────────────────────

    @Override
    public String toString() {
        return "Contact{"
             + "id="          + id
             + ", name='"     + name      + '\''
             + ", email='"    + email     + '\''
             + ", subject='"  + subject   + '\''
             + ", isRead="    + isRead
             + ", submitted=" + submittedAt
             + '}';
    }
}