<%@ page language="java" contentType="text/html; charset=UTF-8"
         isErrorPage="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>500 — Server Error</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 24px;
        }
        .wrap  { max-width: 500px; }
        .code  {
            font-size: 7rem;
            font-weight: 800;
            background: linear-gradient(135deg, #ef4444, #f97316);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 16px;
        }
        h1 { font-size: 1.5rem; color: #0f172a; margin-bottom: 10px; }
        p  { color: #64748b; margin-bottom: 10px; line-height: 1.6; }
        .detail {
            background: #fee2e2;
            border: 1px solid #fca5a5;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.8rem;
            color: #b91c1c;
            text-align: left;
            margin-bottom: 24px;
            word-break: break-all;
        }
        a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 24px;
            background: #6366f1;
            color: #fff;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
        }
        a:hover { background: #4f46e5; }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="code">500</div>
        <h1>Internal Server Error</h1>
        <p>
            Something went wrong on our end.
            Please try again in a moment.
        </p>
        <%-- Show error detail in development only — remove in production --%>
        <% if (exception != null) { %>
        <div class="detail">
            <strong>Error:</strong> <%= exception.getMessage() %>
        </div>
        <% } %>
        <a href="<%= request.getContextPath() %>/">
            &#8592; Go Back Home
        </a>
    </div>
</body>
</html>
