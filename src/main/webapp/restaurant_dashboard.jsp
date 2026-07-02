<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.model.OrderItem" %>
<%@ page import="com.food.implementation.OrderDAOImpl" %>
<%
    Restaurant restaurant = (Restaurant) session.getAttribute("loggedInRestaurant");
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
    List<Order> orderList = (List<Order>) request.getAttribute("orderList");

    String activeTab = request.getParameter("tab");
    if (activeTab == null) {
        activeTab = "menu";
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub Partner - <%= restaurant != null ? restaurant.getName() : "Dashboard" %></title>
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
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.brand {
    font-size: 24px;
    font-weight: 800;
    letter-spacing: -1px;
}

.brand span {
    color: #ff4d4d;
}

.nav-right {
    display: flex;
    gap: 20px;
    align-items: center;
}

.restaurant-badge {
    background: rgba(255, 255, 255, 0.1);
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

.logout-btn {
    background: #ff4d4d;
    color: white;
    text-decoration: none;
    padding: 6px 15px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 14px;
    transition: 0.2s;
}

.logout-btn:hover {
    background: #e03a3a;
}

/* Dashboard Container */
.dashboard-container {
    max-width: 1200px;
    width: 90%;
    margin: 40px auto;
}

/* Tabs */
.tabs-nav {
    display: flex;
    gap: 10px;
    margin-bottom: 30px;
    border-bottom: 2px solid #e2e8f0;
    padding-bottom: 10px;
}

.tab-link {
    text-decoration: none;
    color: #718096;
    padding: 10px 20px;
    font-weight: 600;
    font-size: 16px;
    border-radius: 10px;
    transition: 0.2s;
}

.tab-link:hover {
    background: #edf2f7;
    color: #2d3748;
}

.tab-link.active {
    background: #2d3748;
    color: white;
}

/* Tab Content */
.tab-content {
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
}

.tab-title {
    font-size: 24px;
    font-weight: 800;
    color: #1a202c;
    margin-bottom: 25px;
}

/* Alerts */
.alert {
    padding: 12px 16px;
    border-radius: 12px;
    font-size: 14px;
    margin-bottom: 25px;
    font-weight: 500;
}

.alert-success {
    background: #c6f6d5;
    color: #22543d;
}

.alert-danger {
    background: #fed7d7;
    color: #9b2c2c;
}

/* Tables */
.data-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

.data-table th, .data-table td {
    padding: 14px 20px;
    text-align: left;
    border-bottom: 1px solid #edf2f7;
}

.data-table th {
    background: #f7fafc;
    font-weight: 700;
    color: #4a5568;
    font-size: 14px;
    text-transform: uppercase;
}

.data-table tr:hover {
    background: #f8f9fa;
}

.badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
}

.badge-success {
    background: #c6f6d5;
    color: #22543d;
}

.badge-danger {
    background: #fed7d7;
    color: #9b2c2c;
}

.badge-warning {
    background: #feebc8;
    color: #c05621;
}

/* Forms */
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group.full-width {
    grid-column: 1 / -1;
}

label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    font-size: 14px;
    color: #4a5568;
}

input[type="text"],
input[type="number"],
input[type="email"],
input[type="password"],
textarea,
select {
    width: 100%;
    padding: 10px 14px;
    border-radius: 10px;
    border: 1px solid #cbd5e0;
    font-size: 15px;
    outline: none;
    background: white;
}

input[type="text"]:focus,
input[type="number"]:focus,
input[type="email"]:focus,
input[type="password"]:focus,
textarea:focus,
select:focus {
    border-color: #ff4d4d;
}

.btn-primary {
    background: #2d3748;
    color: white;
    padding: 10px 20px;
    border-radius: 10px;
    font-weight: 700;
    border: none;
    cursor: pointer;
    font-size: 15px;
    transition: 0.2s;
}

.btn-primary:hover {
    background: #1a202c;
}

.btn-danger {
    background: #fed7d7;
    color: #9b2c2c;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 13px;
}

.btn-danger:hover {
    background: #feb2b2;
}

.btn-edit {
    background: #feebc8;
    color: #c05621;
    text-decoration: none;
    padding: 6px 12px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 13px;
    display: inline-block;
}

.btn-edit:hover {
    background: #fbd38d;
}

.order-items-list {
    margin-top: 5px;
    font-size: 13px;
    color: #718096;
}

.order-items-list li {
    list-style: none;
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="brand">Foodie<span>Hub</span> Partner</div>
    <div class="nav-right">
        <% if (restaurant != null) { %>
            <span class="restaurant-badge">🏪 <%= restaurant.getName() %></span>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        <% } %>
    </div>
</header>

<div class="dashboard-container">
    
    <!-- Tab navigation -->
    <div class="tabs-nav">
        <a href="?tab=menu" class="tab-link <%= "menu".equals(activeTab) ? "active" : "" %>">Menu Management</a>
        <a href="?tab=orders" class="tab-link <%= "orders".equals(activeTab) ? "active" : "" %>">Customer Orders</a>
        <a href="?tab=profile" class="tab-link <%= "profile".equals(activeTab) ? "active" : "" %>">Restaurant Profile</a>
    </div>

    <!-- Notifications -->
    <% if (success != null) { %>
        <div class="alert alert-success">
            <% 
                if ("add_menu".equals(success)) out.print("Menu item added successfully!");
                else if ("edit_menu".equals(success)) out.print("Menu item updated successfully!");
                else if ("delete_menu".equals(success)) out.print("Menu item deleted successfully!");
                else if ("update_order_status".equals(success)) out.print("Order status updated successfully!");
                else if ("update_profile".equals(success)) out.print("Restaurant profile updated successfully!");
            %>
        </div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger">
            An error occurred. Please try again.
        </div>
    <% } %>

    <!-- Tab Panels -->
    <% if ("menu".equals(activeTab)) { %>
        <div class="tab-content">
            <div class="tab-title">Manage Menu Items</div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Availability</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (menuList != null && !menuList.isEmpty()) { %>
                        <% for (Menu m : menuList) { %>
                            <tr>
                                <td>
                                    <img src="https://picsum.photos/80/80?<%= m.getMenuId() %>" style="width: 50px; height: 50px; border-radius: 8px; object-fit: cover;" alt="<%= m.getName() %>">
                                </td>
                                <td style="font-weight: 600;"><%= m.getName() %></td>
                                <td style="font-size: 14px; color: #718096;"><%= m.getDescription() %></td>
                                <td style="font-weight: 700; color: #ff4d4d;">₹<%= m.getPrice() %></td>
                                <td>
                                    <% if (m.isAvailable()) { %>
                                        <span class="badge badge-success">Available</span>
                                    <% } else { %>
                                        <span class="badge badge-danger">Out of Stock</span>
                                    <% } %>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 8px;">
                                        <a href="<%= request.getContextPath() %>/restaurant_menu_edit.jsp?menuId=<%= m.getMenuId() %>" class="btn-edit">Edit</a>
                                        <form action="<%= request.getContextPath() %>/restaurant/dashboard" method="post">
                                            <input type="hidden" name="action" value="delete_menu">
                                            <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
                                            <button type="submit" class="btn-danger">Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: #718096; padding: 30px;">No menu items found. Add one below!</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="tab-title" style="margin-top: 40px;">Add New Menu Item</div>
            <form action="<%= request.getContextPath() %>/restaurant/dashboard" method="post">
                <input type="hidden" name="action" value="add_menu">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="menuName">Item Name</label>
                        <input type="text" id="menuName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="menuPrice">Price (₹)</label>
                        <input type="number" step="0.01" id="menuPrice" name="price" required>
                    </div>
                    <div class="form-group full-width">
                        <label for="menuDesc">Description</label>
                        <textarea id="menuDesc" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="menuImage">Image Path (filename/URL)</label>
                        <input type="text" id="menuImage" name="imagePath" placeholder="burger.jpg" value="food.jpg" required>
                    </div>
                    <div class="form-group">
                        <label for="isAvailable">Initial Availability</label>
                        <select id="isAvailable" name="isAvailable">
                            <option value="true">Available</option>
                            <option value="false">Out of Stock</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn-primary">Add Menu Item</button>
            </form>
        </div>

    <% } else if ("orders".equals(activeTab)) { %>
        <div class="tab-content">
            <div class="tab-title">Customer Orders</div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Items Ordered</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (orderList != null && !orderList.isEmpty()) { %>
                        <% for (Order o : orderList) { %>
                            <tr>
                                <td style="font-weight: 700;">#<%= o.getOrderId() %></td>
                                <td style="font-size: 14px; color: #718096;"><%= o.getOrderDate() %></td>
                                <td>
                                    <ul class="order-items-list">
                                        <% 
                                            List<OrderItem> items = new OrderDAOImpl().getOrderItems(o.getOrderId());
                                            if (items != null) {
                                                for (OrderItem item : items) {
                                        %>
                                                    <li><%= item.getName() %> <strong>x<%= item.getQuantity() %></strong></li>
                                        <% 
                                                }
                                            }
                                        %>
                                    </ul>
                                </td>
                                <td style="font-weight: 700; color: #ff4d4d; font-size: 16px;">₹<%= o.getTotalAmount() %></td>
                                <td>
                                    <% 
                                        String badgeClass = "badge-warning";
                                        if ("Delivered".equalsIgnoreCase(o.getStatus())) badgeClass = "badge-success";
                                        else if ("Cancelled".equalsIgnoreCase(o.getStatus())) badgeClass = "badge-danger";
                                    %>
                                    <span class="badge <%= badgeClass %>"><%= o.getStatus() %></span>
                                </td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/restaurant/dashboard" method="post" style="display: flex; gap: 5px;">
                                        <input type="hidden" name="action" value="update_order_status">
                                        <input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
                                        <select name="status" style="width: auto; padding: 4px 8px; font-size: 13px;">
                                            <option value="Pending" <%= "Pending".equals(o.getStatus()) ? "selected" : "" %>>Pending</option>
                                            <option value="Delivered" <%= "Delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                                            <option value="Cancelled" <%= "Cancelled".equals(o.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn-primary" style="padding: 4px 10px; font-size: 13px;">Update</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: #718096; padding: 30px;">No customer orders placed yet.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    <% } else if ("profile".equals(activeTab)) { %>
        <div class="tab-content">
            <div class="tab-title">Restaurant Profile Settings</div>

            <form action="<%= request.getContextPath() %>/restaurant/dashboard" method="post">
                <input type="hidden" name="action" value="update_profile">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="restName">Restaurant Name</label>
                        <input type="text" id="restName" name="name" value="<%= restaurant != null ? restaurant.getName() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label for="cuisine">Cuisine Type</label>
                        <input type="text" id="cuisine" name="cuisineType" value="<%= restaurant != null ? restaurant.getCuisineType() : "" %>" required>
                    </div>
                    <div class="form-group full-width">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" value="<%= restaurant != null ? restaurant.getAddress() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label for="eta">Estimated Delivery Time (mins)</label>
                        <input type="number" id="eta" name="eta" value="<%= restaurant != null ? restaurant.getEta() : 30 %>" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Contact Email</label>
                        <input type="email" id="email" name="email" value="<%= restaurant != null ? restaurant.getEmail() : "" %>" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Change Password (leave blank to keep current)</label>
                        <input type="password" id="password" name="password" placeholder="••••••••">
                    </div>
                </div>
                <button type="submit" class="btn-primary">Update Profile</button>
            </form>
        </div>
    <% } %>

</div>

</body>
</html>
