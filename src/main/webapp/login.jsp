<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String registrationSuccess = request.getParameter("registrationSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - Welcome Back</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*, *::before, *::after {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #FC8019;
    --primary-dark: #e07016;
    --accent: #ff4d4d;
    --text-dark: #1C1C1C;
    --text-mid: #4a4a4a;
    --text-light: #686b78;
    --bg: #ffffff;
    --bg-soft: #f5f5f5;
    --border: #e8e8e8;
    --shadow: 0 4px 20px rgba(0,0,0,0.06);
}

body {
    font-family: 'Inter', sans-serif;
    background: var(--bg-soft);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
}

.login-card {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: var(--shadow);
    width: 100%;
    max-width: 420px;
    border: 1px solid var(--border);
}

.logo {
    text-align: center;
    font-size: 32px;
    font-weight: 900;
    color: var(--primary);
    margin-bottom: 8px;
    letter-spacing: -1px;
}

.logo span {
    color: var(--accent);
}

.tagline {
    text-align: center;
    color: var(--text-light);
    font-size: 14px;
    margin-bottom: 30px;
    font-weight: 500;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 13px;
    color: var(--text-mid);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 12px 16px;
    border-radius: 10px;
    border: 1px solid var(--border);
    font-size: 15px;
    outline: none;
    background: white;
    font-family: 'Inter', sans-serif;
}

input[type="email"]:focus,
input[type="password"]:focus {
    border-color: var(--primary);
}

.btn-login {
    width: 100%;
    background: var(--primary);
    color: white;
    border: none;
    padding: 14px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(252,128,25,0.2);
    transition: background 0.2s;
    margin-top: 10px;
}

.btn-login:hover {
    background: var(--primary-dark);
}

.switch-page {
    text-align: center;
    margin-top: 24px;
    font-size: 14px;
    color: var(--text-light);
    font-weight: 500;
}

.switch-page a {
    color: var(--primary);
    text-decoration: none;
    font-weight: 700;
}

.switch-page a:hover {
    text-decoration: underline;
}

.alert {
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 13px;
    margin-bottom: 20px;
    font-weight: 600;
}

.alert-danger {
    background: #fed7d7;
    color: #9b2c2c;
    border: 1px solid #feb2b2;
}

.alert-success {
    background: #c6f6d5;
    color: #22543d;
    border: 1px solid #9ae6b4;
}
</style>
</head>
<body>

<div class="login-card">
    <div class="logo">Foodie<span>Hub</span></div>
    <p class="tagline">Welcome back! Please login to your account.</p>

    <% if (errorMessage != null) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <% if (registrationSuccess != null) { %>
        <div class="alert alert-success">Registration successful! Please login below.</div>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="john@example.com" required autocomplete="email">
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-login">Login</button>
    </form>

    <div class="switch-page">
        Don't have an account? <a href="register">Sign Up</a>
    </div>
</div>

</body>
</html>
