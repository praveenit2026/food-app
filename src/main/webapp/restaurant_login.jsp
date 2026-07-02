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
<title>FoodieHub - Partner Login</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Outfit', sans-serif;
}

body {
    background: #f0f4f8;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.login-card {
    background: white;
    padding: 40px;
    border-radius: 24px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    width: 100%;
    max-width: 420px;
}

.logo {
    text-align: center;
    font-size: 32px;
    font-weight: 800;
    color: #4a5568;
    margin-bottom: 5px;
}

.logo span {
    color: #ff4d4d;
}

.tagline {
    text-align: center;
    color: #718096;
    font-size: 14px;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 14px;
    color: #4a5568;
}

input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 12px 16px;
    border-radius: 12px;
    border: 1px solid #cbd5e0;
    font-size: 15px;
    outline: none;
    transition: border-color 0.2s;
}

input[type="email"]:focus,
input[type="password"]:focus {
    border-color: #ff4d4d;
}

.btn-login {
    width: 100%;
    background: #2d3748;
    color: white;
    border: none;
    padding: 14px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s;
    margin-top: 10px;
}

.btn-login:hover {
    background: #1a202c;
}

.switch-page {
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
    color: #718096;
}

.switch-page a {
    color: #ff4d4d;
    text-decoration: none;
    font-weight: 600;
}

.switch-page a:hover {
    text-decoration: underline;
}

.alert {
    padding: 12px 16px;
    border-radius: 12px;
    font-size: 14px;
    margin-bottom: 20px;
    font-weight: 500;
}

.alert-danger {
    background: #fed7d7;
    color: #9b2c2c;
}

.alert-success {
    background: #c6f6d5;
    color: #22543d;
}

.user-login-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    font-size: 13px;
}

.user-login-link a {
    color: #718096;
    text-decoration: none;
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<div class="login-card">
    <div class="logo">Foodie<span>Hub</span> Partner</div>
    <p class="tagline">Restaurant Management Portal</p>

    <% if (errorMessage != null) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <% if (registrationSuccess != null) { %>
        <div class="alert alert-success">Restaurant registered! Please login below.</div>
    <% } %>

    <form action="<%= request.getContextPath() %>/restaurant/login" method="post">
        <div class="form-group">
            <label for="email">Restaurant Email</label>
            <input type="email" id="email" name="email" placeholder="owner@restaurant.com" required>
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-login">Partner Login</button>
    </form>

    <div class="switch-page">
        Want to list your restaurant? <a href="<%= request.getContextPath() %>/restaurant/register">Register Now</a>
    </div>

    <div class="user-login-link">
        <a href="<%= request.getContextPath() %>/login">← Back to Customer Login</a>
    </div>
</div>

</body>
</html>
