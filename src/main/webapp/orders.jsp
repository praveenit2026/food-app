<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.model.User" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    String orderSuccess = request.getParameter("orderSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - My Orders</title>
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
    --green: #48c479;
    --shadow: 0 2px 8px rgba(0,0,0,0.12);
}

body {
    font-family: 'Inter', sans-serif;
    background: var(--bg-soft);
    color: var(--text-dark);
    min-height: 100vh;
}

/* ── NAVBAR ─────────────────────────────────────────── */
.navbar {
    background: white;
    border-bottom: 1px solid var(--border);
    padding: 0 40px;
    height: 68px;
    display: flex;
    align-items: center;
    gap: 24px;
    position: sticky;
    top: 0;
    z-index: 1000;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}

.nav-logo {
    font-size: 26px;
    font-weight: 900;
    color: var(--primary);
    text-decoration: none;
    letter-spacing: -1px;
    white-space: nowrap;
    flex-shrink: 0;
}

.nav-logo span {
    color: var(--accent);
}

.nav-actions {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-left: auto;
    flex-shrink: 0;
}

.nav-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 9px 18px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.2s;
}

.nav-btn-ghost {
    color: var(--text-dark);
    background: transparent;
}

.nav-btn-ghost:hover {
    background: var(--bg-soft);
}

.nav-btn-primary {
    background: var(--primary);
    color: white;
}

.nav-btn-primary:hover {
    background: var(--primary-dark);
}

.nav-btn-outline {
    border: 1.5px solid var(--border);
    color: var(--text-dark);
    background: white;
}

.nav-btn-outline:hover {
    border-color: var(--primary);
    color: var(--primary);
}

.nav-user-pill {
    display: flex;
    align-items: center;
    gap: 8px;
    background: var(--bg-soft);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 8px 14px;
    font-size: 13px;
    font-weight: 600;
    color: var(--text-dark);
}

.nav-user-avatar {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
    color: white;
    font-size: 12px;
    font-weight: 700;
    display: flex;
    align-items: center;
    justify-content: center;
    text-transform: uppercase;
}

/* ── ORDERS LAYOUT ──────────────────────────────────────── */
.orders-wrapper {
    max-width: 750px;
    margin: 40px auto 80px;
    padding: 0 20px;
}

.orders-title {
    font-size: 26px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 24px;
    letter-spacing: -0.5px;
}

.success-alert {
    background: #e6fffa;
    color: #0f766e;
    padding: 16px 20px;
    border-radius: 12px;
    font-weight: 600;
    margin-bottom: 24px;
    border: 1px solid #b2f5ea;
    font-size: 14px;
}

.order-card {
    background: white;
    border-radius: 16px;
    padding: 24px;
    margin-bottom: 20px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    border: 1px solid var(--border);
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1.5px dashed var(--border);
    padding-bottom: 16px;
    margin-bottom: 16px;
}

.order-id {
    font-size: 16px;
    font-weight: 800;
    color: var(--text-dark);
}

.order-date {
    font-size: 13px;
    color: var(--text-light);
    font-weight: 500;
}

.order-details {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    font-size: 14px;
}

.detail-row {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.detail-label {
    color: var(--text-light);
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.detail-value {
    color: var(--text-dark);
    font-weight: 700;
}

.status-badge {
    align-self: flex-start;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 11px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-pending {
    background: #feebc8;
    color: #c05621;
}

.status-delivered {
    background: #c6f6d5;
    color: #22543d;
}

.status-cancelled {
    background: #fed7d7;
    color: #9b2c2c;
}

.order-total-row {
    grid-column: 1 / -1;
    border-top: 1px solid var(--border);
    padding-top: 14px;
    margin-top: 6px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.order-total-price {
    font-size: 18px;
    font-weight: 900;
    color: var(--primary);
}

/* ── EMPTY STATE ────────────────────────────────────────── */
.no-orders-card {
    background: white;
    border-radius: 16px;
    padding: 60px 40px;
    text-align: center;
    border: 1px solid var(--border);
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
}

.no-orders-icon {
    font-size: 64px;
    margin-bottom: 16px;
}

.no-orders-title {
    font-size: 20px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 8px;
}

.explore-link {
    display: inline-block;
    background: var(--primary);
    color: white;
    text-decoration: none;
    padding: 12px 28px;
    border-radius: 10px;
    font-weight: 700;
    font-size: 14px;
    box-shadow: 0 4px 12px rgba(252,128,25,0.2);
    margin-top: 16px;
    transition: background 0.2s;
}

.explore-link:hover {
    background: var(--primary-dark);
}

/* ── RESPONSIVE DESIGN ───────────────────────────────────── */
@media (max-width: 768px) {
    .navbar {
        height: auto;
        padding: 12px 16px;
        flex-wrap: wrap;
        gap: 12px;
    }
    .nav-logo {
        order: 1;
    }
    .nav-actions {
        order: 2;
        margin-left: auto;
        gap: 6px;
    }
    .nav-btn {
        padding: 8px 12px;
        font-size: 12px;
        gap: 4px;
    }
    .nav-user-pill {
        padding: 6px 10px;
        font-size: 12px;
        gap: 6px;
    }
    .nav-user-avatar {
        width: 24px;
        height: 24px;
        font-size: 11px;
    }
    .orders-wrapper {
        margin: 20px auto 40px;
        padding: 0 16px;
    }
    .order-card {
        padding: 16px;
    }
}

@media (max-width: 480px) {
    .order-details {
        grid-template-columns: 1fr;
    }
    .order-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 6px;
    }
}
</style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
    <a href="callRestaurantServlet" class="nav-logo">Foodie<span>Hub</span></a>

    <div class="nav-actions">
        <% if (loggedInUser != null) { %>
            <div class="nav-user-pill">
                <div class="nav-user-avatar"><%= loggedInUser.getName().substring(0,1) %></div>
                <%= loggedInUser.getName().split(" ")[0] %>
            </div>
            <a href="profile" class="nav-btn nav-btn-ghost">Profile</a>
            <a href="cart" class="nav-btn nav-btn-outline">🛒 Cart</a>
            <a href="order" class="nav-btn nav-btn-ghost">Orders</a>
            <a href="logout" class="nav-btn nav-btn-primary">Logout</a>
        <% } %>
    </div>
</nav>

<div class="orders-wrapper">
    <h1 class="orders-title">Your Orders</h1>

    <% if (orderSuccess != null) { %>
        <div class="success-alert">
            🎉 Order placed successfully! The kitchen is preparing your delicious meal.
        </div>
    <% } %>

    <% if (orders != null && !orders.isEmpty()) { %>
        <% for (Order o : orders) { %>
            <div class="order-card">
                <div class="order-header">
                    <span class="order-id">Order ID: #<%= o.getOrderId() %></span>
                    <span class="order-date"><%= o.getOrderDate() %></span>
                </div>
                <div class="order-details">
                    <div class="detail-row">
                        <span class="detail-label">Payment Mode</span>
                        <span class="detail-value"><%= o.getPaymentMode() %></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Status</span>
                        <% 
                            String statusClass = "status-pending";
                            if ("Delivered".equalsIgnoreCase(o.getStatus())) {
                                statusClass = "status-delivered";
                            } else if ("Cancelled".equalsIgnoreCase(o.getStatus())) {
                                statusClass = "status-cancelled";
                            }
                        %>
                        <span class="status-badge <%= statusClass %>"><%= o.getStatus() %></span>
                    </div>
                    <div class="order-total-row">
                        <span class="detail-label">Total Bill Amount</span>
                        <span class="order-total-price">₹<%= o.getTotalAmount() %></span>
                    </div>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <div class="no-orders-card">
            <div class="no-orders-icon">📂</div>
            <h2 class="no-orders-title">No orders found</h2>
            <p style="color: var(--text-light); font-size: 14px;">Looks like you haven't placed any orders yet.</p>
            <a href="callRestaurantServlet" class="explore-link">Explore Restaurants</a>
        </div>
    <% } %>
</div>

</body>
</html>
