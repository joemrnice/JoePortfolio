JoePortfolio/
|-- .gitignore
|-- Dockerfile
|-- .dockerignore
|-- startup.sh
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── joeportfolio/
│                   ├── model/
│                   │   └── Contact.java
│                   ├── dao/
│                   │   └── ContactDAO.java
│                   ├── servlet/
│                   │   └── ContactServlet.java
│                   └── util/
│                       └── DBConnection.java
├── WebContent/
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── lib/
│   │       └── mysql-connector-j-8.x.x.jar
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── main.js
│   ├── images/
│   │   └── (placeholder images)
│   └── index.jsp
└── META-INF/
    └── context.xml