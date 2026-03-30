package com.joeportfolio.servlet;

import com.joeportfolio.dao.ContactDAO;
import com.joeportfolio.model.Contact;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ContactServlet - MVC Controller for Contact Form
 * ---------------------------------------------------
 * Handles form submission (POST) from the portfolio contact section.
 * Validates input, creates a Contact object, delegates save to DAO,
 * then redirects with success/error feedback via session attribute.
 *
 * URL Mapping : /contact  (configured in web.xml)
 * Methods     : GET  → redirect to homepage#contact
 *               POST → process form submission
 *
 * Author : Code Zerra
 */
//@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // DAO instance — created once per servlet lifecycle
    private ContactDAO contactDAO;

    // ── init() ───────────────────────────────────────────────

    @Override
    public void init() throws ServletException {
        super.init();
        contactDAO = new ContactDAO();
        System.out.println("[ContactServlet] Initialized successfully.");
    }

    // ── doGet() ──────────────────────────────────────────────

    /**
     * GET /contact
     * Not used for form processing — redirects to the portfolio
     * homepage with the contact section anchor.
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect to homepage contact section
        response.sendRedirect(request.getContextPath() + "/index.jsp#contact");
    }

    // ── doPost() ─────────────────────────────────────────────

    /**
     * POST /contact
     * Processes the contact form submission:
     *   1. Read & sanitize form parameters
     *   2. Validate all required fields
     *   3. Build Contact model object
     *   4. Delegate to ContactDAO.save()
     *   5. Set feedback message in session
     *   6. Redirect back to homepage (Post/Redirect/Get pattern)
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Set character encoding FIRST — before reading parameters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ── Step 1: Read form parameters ──────────────────────
        String name    = getParam(request, "name");
        String email   = getParam(request, "email");
        String subject = getParam(request, "subject");
        String message = getParam(request, "message");

        // Capture sender's IP address (handles proxies)
        String ipAddress = getClientIp(request);

        // ── Step 2: Server-side validation ────────────────────
        String validationError = validateInput(name, email, subject, message);

        if (validationError != null) {
            // Validation failed — redirect back with error
            setSessionMessage(request, "error", validationError);
            response.sendRedirect(request.getContextPath() + "/index.jsp#contact");
            return;
        }

        // ── Step 3: Build Contact model ───────────────────────
        Contact contact = new Contact(name, email, subject, message, ipAddress);

        // ── Step 4: Save via DAO ──────────────────────────────
        boolean saved = contactDAO.save(contact);

        // ── Step 5 & 6: Set feedback and redirect ─────────────
        if (saved) {
            setSessionMessage(request, "success",
                "Thank you, " + escapeHtml(name) + "! "
              + "Your message has been sent successfully. "
              + "I'll get back to you soon. 💜");
        } else {
            setSessionMessage(request, "error",
                "Oops! Something went wrong while sending your message. "
              + "Please try again or email me directly.");
        }

        // Post/Redirect/Get — prevents form resubmission on refresh
        response.sendRedirect(request.getContextPath() + "/index.jsp#contact");
    }

    // ── Private Helper Methods ────────────────────────────────

    /**
     * Reads and trims a request parameter.
     * Returns empty string if parameter is null.
     *
     * @param request  HttpServletRequest
     * @param param    parameter name
     * @return         trimmed value or empty string
     */
    private String getParam(HttpServletRequest request, String param) {
        String value = request.getParameter(param);
        return (value != null) ? value.trim() : "";
    }

    /**
     * Validates all required contact form fields.
     * Returns null if valid, or an error message string if invalid.
     *
     * @param name     sender name
     * @param email    sender email
     * @param subject  message subject
     * @param message  message body
     * @return         null if valid, error string if invalid
     */
    private String validateInput(String name, String email,
                                  String subject, String message) {
        // Check for empty required fields
        if (name.isEmpty()) {
            return "Please enter your full name.";
        }
        if (name.length() > 100) {
            return "Name must not exceed 100 characters.";
        }
        if (email.isEmpty()) {
            return "Please enter your email address.";
        }
        if (!isValidEmail(email)) {
            return "Please enter a valid email address.";
        }
        if (email.length() > 150) {
            return "Email must not exceed 150 characters.";
        }
        if (subject.isEmpty()) {
            return "Please enter a subject.";
        }
        if (subject.length() > 200) {
            return "Subject must not exceed 200 characters.";
        }
        if (message.isEmpty()) {
            return "Please enter your message.";
        }
        if (message.length() < 10) {
            return "Message is too short. Please write at least 10 characters.";
        }
        if (message.length() > 5000) {
            return "Message is too long. Please keep it under 5000 characters.";
        }
        // All checks passed
        return null;
    }

    /**
     * Validates email format using a standard regex pattern.
     *
     * @param email  the email string to check
     * @return       true if format is valid
     */
    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }

    /**
     * Stores a feedback message in the HTTP session.
     * JSP reads and removes it after display.
     *
     * @param request  HttpServletRequest (for session access)
     * @param type     "success" or "error"
     * @param message  the message text
     */
    private void setSessionMessage(HttpServletRequest request,
                                    String type, String message) {
        request.getSession().setAttribute("contactMsgType", type);
        request.getSession().setAttribute("contactMsg",     message);
    }

    /**
     * Retrieves the real client IP, checking for proxy headers.
     * Handles X-Forwarded-For, X-Real-IP, etc.
     *
     * @param request  HttpServletRequest
     * @return         client IP address string
     */
    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // X-Forwarded-For can contain multiple IPs — take the first one
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }

    /**
     * Minimal HTML escaping to prevent XSS in response messages.
     * Escapes < > & " ' characters.
     *
     * @param input  raw string
     * @return       HTML-safe string
     */
    private String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }

    // ── destroy() ────────────────────────────────────────────

    @Override
    public void destroy() {
        System.out.println("[ContactServlet] Destroyed.");
        super.destroy();
    }
}
/**```

---

## 🔁 Data Flow Summary
```
Browser (Form POST)
      │
      ▼
ContactServlet.doPost()
  ├─ Read & trim parameters
  ├─ validateInput() ──── FAIL ──→ session error msg → redirect #contact
  │                                                              │
  ├─ Build Contact object                                        │
  │                                                              │
  ├─ ContactDAO.save()                                           │
  │     ├─ TestDBConnection.getConnection()                          │
  │     ├─ PreparedStatement.executeUpdate()                     │
  │     └─ closeResources()                                      │
  │                                                              │
  ├─ saved=true  → session success msg → redirect #contact ──────┤
  └─ saved=false → session error msg  → redirect #contact ───────┘
                                                │
                                                ▼
                                    index.jsp reads session msg
                                    displays success/error alert
                                    removes msg from session
*/