<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - Partner Registration</title>
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
    padding: 40px 0;
}

.signup-card {
    background: white;
    padding: 40px;
    border-radius: 24px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    width: 90%;
    max-width: 460px;
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
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 18px;
}

label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    font-size: 14px;
    color: #4a5568;
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="number"] {
    width: 100%;
    padding: 11px 16px;
    border-radius: 12px;
    border: 1px solid #cbd5e0;
    font-size: 15px;
    outline: none;
    transition: border-color 0.2s;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="password"]:focus,
input[type="number"]:focus {
    border-color: #ff4d4d;
}

.btn-signup {
    width: 100%;
    background: #2d3748;
    color: white;
    border: none;
    padding: 13px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s;
    margin-top: 10px;
}

.btn-signup:hover {
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
    background: #fed7d7;
    color: #9b2c2c;
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<div class="signup-card">
    <div class="logo">Foodie<span>Hub</span> Partner</div>
    <p class="tagline">List your restaurant and grow your business!</p>

    <% if (errorMessage != null) { %>
        <div class="alert"><%= errorMessage %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/restaurant/register" method="post">
        <div class="form-group">
            <label for="name">Restaurant Name</label>
            <input type="text" id="name" name="name" placeholder="Burger Spot" required>
        </div>

        <div class="form-group">
            <label for="cuisineType">Cuisine Type</label>
            <input type="text" id="cuisineType" name="cuisineType" placeholder="Burgers, Beverages, Fast Food" required>
        </div>

        <div class="form-group">
            <label for="address">Restaurant Address</label>
            <input type="text" id="address" name="address" placeholder="123 Food Street, Bangalore" required>
        </div>

        <div class="form-group">
            <label for="eta">Estimated Delivery Time (minutes)</label>
            <input type="number" id="eta" name="eta" placeholder="30" min="5" max="120" required>
        </div>

        <div class="form-group">
            <label for="email">Contact Email</label>
            <input type="email" id="email" name="email" placeholder="manager@burgerspot.com" required>
        </div>
        
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit" class="btn-signup">Register Restaurant</button>
    </form>

    <div class="switch-page">
        Already a partner? <a href="<%= request.getContextPath() %>/restaurant/login">Login here</a>
    </div>
</div>

</body>
</html>
