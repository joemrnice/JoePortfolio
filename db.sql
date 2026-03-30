-- ============================================================
-- DATABASE: joe_portfolio
-- Project:  JoePortfolio
-- Author:   Code Zerra
-- Description: Stores contact form submissions from portfolio
-- ============================================================

-- Step 1: Create & select the database
CREATE DATABASE IF NOT EXISTS joe_portfolio
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE joe_portfolio;

-- ============================================================
-- TABLE: contacts
-- Stores all messages submitted via the contact form
-- ============================================================
CREATE TABLE IF NOT EXISTS contacts (
    id          INT(11)         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100)    NOT NULL,
    email       VARCHAR(150)    NOT NULL,
    subject     VARCHAR(200)    NOT NULL,
    message     TEXT            NOT NULL,
    submitted_at DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read     TINYINT(1)      NOT NULL DEFAULT 0,   -- 0 = unread, 1 = read
    ip_address  VARCHAR(45)     NULL,                 -- supports IPv6

    PRIMARY KEY (id),
    INDEX idx_email       (email),
    INDEX idx_submitted   (submitted_at),
    INDEX idx_is_read     (is_read)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Contact form submissions from JoePortfolio website';

-- ============================================================
-- SAMPLE DATA: contacts (5 realistic entries)
-- ============================================================
INSERT INTO contacts (name, email, subject, message, submitted_at, is_read, ip_address)
VALUES
(
    'Alice Johnson',
    'alice.johnson@email.com',
    'Project Collaboration Inquiry',
    'Hi Joe, I came across your portfolio and I am really impressed with your work. I am building a healthcare startup and would love to discuss a potential collaboration. Please get in touch!',
    '2025-01-10 09:15:00',
    1,
    '192.168.1.101'
),
(
    'Marcus Lee',
    'marcus.dev@techmail.com',
    'Freelance Web Development Opportunity',
    'Hello! We are looking for a skilled web developer to join our remote team on a freelance basis. Your portfolio stood out to us. Would you be open to a quick call this week?',
    '2025-01-18 14:32:00',
    1,
    '10.0.0.55'
),
(
    'Sofia Patel',
    'sofia.patel@designco.io',
    'UI/UX Design Partnership',
    'Hey Joe, love your clean aesthetic. I am a UI/UX designer and I think we could create amazing projects together. Let me know if you are interested in partnering up!',
    '2025-02-05 11:00:00',
    0,
    '172.16.0.22'
),
(
    'James Okoye',
    'j.okoye@bizventures.ng',
    'E-commerce Website Development',
    'Good day. I need a professional e-commerce website built for my fashion business. I was referred to you by a colleague. Please send me your rates and availability.',
    '2025-02-20 16:45:00',
    0,
    '41.58.120.77'
),
(
    'Priya Nair',
    'priya.nair@startup.in',
    'Portfolio Feedback & Question',
    'Hi Joe! Your portfolio is absolutely stunning. I am a junior developer trying to build my own and I wanted to ask how you structured your projects section. Any tips would be appreciated!',
    '2025-03-02 08:20:00',
    0,
    '203.110.45.9'
);

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================
SELECT 'contacts table created successfully' AS status;
SELECT COUNT(*) AS total_contacts FROM contacts;
SELECT id, name, email, subject, submitted_at, is_read FROM contacts ORDER BY submitted_at DESC;