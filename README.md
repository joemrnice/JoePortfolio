# JoePortfolio

<video src="https://github.com/joemrnice/JoePortfolio/blob/main/assets/joes.webm" width="600" controls></video>

A professional, responsive personal portfolio website for a male
web developer named Joe — built with pure J2EE (Servlets + JSP + JDBC).

---

## Tech Stack

| Layer      | Technology                      |
|------------|---------------------------------|
| Backend    | Java EE 8, Servlets, JDBC       |
| Frontend   | JSP, CSS3, Vanilla JS, jQuery   |
| Database   | MySQL 8.0 (XAMPP)               |
| Server     | Apache Tomcat 9.0               |
| IDE        | Eclipse IDE (Dynamic Web Project)|
| Driver     | MySQL Connector/J 8.x           |

---

## Project Structure
```
JoePortfolio/
├── src/com/joeportfolio/
│   ├── util/DBConnection.java & (EXDBConnection.java for production)
│   ├── model/Contact.java
│   ├── dao/ContactDAO.java
│   └── servlet/ContactServlet.java
├── webapp/
│   ├── index.jsp
│   ├── error/
│   │   ├── 404.jsp
│   │   └── 500.jsp
│   ├── css/style.css
│   ├── js/main.js
│   └── WEB-INF/
│       ├── web.xml
│       └── lib/mysql-connector-j-8.x.x.jar
└── META-INF/context.xml
```

---

## Prerequisites

- Java JDK 11 or 17
- Apache Tomcat 9.0
- XAMPP (MySQL 8.0)
- Eclipse IDE for Enterprise Java Developers
- MySQL Connector/J 8.x JAR

---

## Setup Instructions

### Step 1 — Clone / Import Project

1. Open Eclipse
2. File → Import → Existing Projects into Workspace
3. Select JoePortfolio root folder → Finish

### Step 2 — Add MySQL JAR to Build Path

1. Download mysql-connector-j-8.x.x.jar
2. Copy to webapp/WEB-INF/lib/
3. Right-click project → Build Path → Add JARs
4. Select the JAR → OK

### Step 3 — Configure Tomcat in Eclipse

1. Window → Preferences → Server → Runtime Environments
2. Add → Apache Tomcat v9.0
3. Browse to Tomcat installation folder
4. Select JDK (not JRE) → Finish

### Step 4 — Database Setup

1. Start XAMPP → Start MySQL
2. Open phpMyAdmin → http://localhost/phpmyadmin
3. Click SQL tab
4. Paste and run the contents of sql/joe_portfolio.sql

### Step 5 — Run the Application

1. Right-click project → Run As → Run on Server
2. Select Tomcat 9.0 → Finish
3. Browser opens at: http://localhost:8080/JoePortfolio/

---

## Database Configuration

Edit `src/com/joeportfolio/util/DBConnection.java`:
```java
private static final String URL      = "jdbc:mysql://localhost:3306/joe_portfolio...";
private static final String USER     = "root";
private static final String PASSWORD = "";  // your MySQL password
```

---

## Features

- Responsive single-page portfolio (Hero, About, Skills, Projects, Contact)
- Typing animation in hero section
- Animated skill progress bars
- Project grid with modal detail views
- Project filter tabs (All / Web App / UI/UX / Database)
- Contact form saves to MySQL (server-side + client-side validation)
- Session-based toast notifications (success / error)
- Mobile-friendly hamburger navigation

---

## URLs

| Page             | URL                                        |
|------------------|--------------------------------------------|
| Portfolio Home   | http://localhost:8080/JoePortfolio/       |
| Contact Endpoint | http://localhost:8080/JoePortfolio/contact|

---

## Deploying as WAR

1. Right-click project → Export → WAR File
2. Destination: DijaPortfolio.war
3. Copy to: C:\apache-tomcat-9.0.x\webapps\
4. Start Tomcat → access at http://localhost:8080/JoePortfolio/

---

## Author

Built by Code Zerra
