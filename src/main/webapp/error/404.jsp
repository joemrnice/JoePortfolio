<%@ page language="java" contentType="text/html; charset=UTF-8"
         isErrorPage="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>404 — Page Not Found</title>
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
        .wrap { max-width: 480px; }
        .code {
            font-size: 7rem;
            font-weight: 800;
            background: linear-gradient(135deg, #6366f1, #ec4899);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 16px;
        }
        h1 { font-size: 1.5rem; color: #0f172a; margin-bottom: 10px; }
        p  { color: #64748b; margin-bottom: 28px; line-height: 1.6; }
        a  {
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
            transition: background 0.2s;
        }
        a:hover { background: #4f46e5; }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="code">404</div>
        <h1>Page Not Found</h1>
        <p>
            The page you are looking for doesn't exist,
            was moved, or the URL is incorrect.
        </p>
        <a href="<%= request.getContextPath() %>/">
            &#8592; Go Back Home
        </a>
    </div>
</body>
</html>
