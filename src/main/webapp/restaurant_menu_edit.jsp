<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Restaurant" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.food.DAO.MenuDAO" %>
<%@ page import="com.food.implementation.MenuDAOImpl" %>
<%
    Restaurant restaurant = (Restaurant) session.getAttribute("loggedInRestaurant");
    if (restaurant == null) {
        response.sendRedirect(request.getContextPath() + "/restaurant/login");
        return;
    }

    String menuIdStr = request.getParameter("menuId");
    Menu m = null;
    if (menuIdStr != null) {
        try {
            int menuId = Integer.parseInt(menuIdStr);
            MenuDAO menuDAO = new MenuDAOImpl();
            m = menuDAO.getMenu(menuId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    if (m == null || m.getRestaurantId() != restaurant.getRestaurantId()) {
        response.sendRedirect(request.getContextPath() + "/restaurant/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub Partner - Edit Menu Item</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Outfit', sans-serif;
}

body {
    background: #f4f7f6;
    color: #2d3748;
}

/* Header */
.header {
    background: #2d3748;
    color: white;
    padding: 15px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 100;
}

.brand {
    font-size: 24px;
    font-weight: 800;
    letter-spacing: -1px;
}

.brand span {
    color: #ff4d4d;
}

/* Wrapper */
.edit-wrapper {
    max-width: 600px;
    width: 90%;
    margin: 50px auto;
}

.edit-card {
    background: white;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
}

.title {
    font-size: 26px;
    font-weight: 800;
    color: #1a202c;
    margin-bottom: 25px;
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

input[type="text"],
input[type="number"],
textarea,
select {
    width: 100%;
    padding: 12px 16px;
    border-radius: 12px;
    border: 1px solid #cbd5e0;
    font-size: 15px;
    outline: none;
    background: white;
}

input[type="text"]:focus,
input[type="number"]:focus,
textarea:focus,
select:focus {
    border-color: #ff4d4d;
}

.actions-row {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.btn-save {
    background: #ff4d4d;
    color: white;
    border: none;
    padding: 14px 28px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s;
    flex-grow: 1;
}

.btn-save:hover {
    background: #e03a3a;
}

.btn-cancel {
    background: #edf2f7;
    color: #4a5568;
    text-decoration: none;
    padding: 14px 28px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 700;
    text-align: center;
    transition: background 0.2s;
}

.btn-cancel:hover {
    background: #e2e8f0;
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="brand">Foodie<span>Hub</span> Partner</div>
</header>

<div class="edit-wrapper">
    <div class="edit-card">
        <h1 class="title">Edit Menu Item</h1>

        <form action="<%= request.getContextPath() %>/restaurant/dashboard" method="post">
            <input type="hidden" name="action" value="edit_menu">
            <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">

            <div class="form-group">
                <label for="name">Item Name</label>
                <input type="text" id="name" name="name" value="<%= m.getName() %>" required>
            </div>

            <div class="form-group">
                <label for="price">Price (₹)</label>
                <input type="number" step="0.01" id="price" name="price" value="<%= m.getPrice() %>" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required><%= m.getDescription() %></textarea>
            </div>

            <div class="form-group">
                <label for="imagePath">Image Path (filename/URL)</label>
                <input type="text" id="imagePath" name="imagePath" value="<%= m.getImagePath() %>" required>
            </div>

            <div class="form-group">
                <label for="isAvailable">Availability Status</label>
                <select id="isAvailable" name="isAvailable">
                    <option value="true" <%= m.isAvailable() ? "selected" : "" %>>Available</option>
                    <option value="false" <%= !m.isAvailable() ? "selected" : "" %>>Out of Stock</option>
                </select>
            </div>

            <div class="actions-row">
                <button type="submit" class="btn-save">Save Changes</button>
                <a href="<%= request.getContextPath() %>/restaurant/dashboard" class="btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
