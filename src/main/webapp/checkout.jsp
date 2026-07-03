<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.User" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - Checkout</title>
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

/* ── CHECKOUT LAYOUT ────────────────────────────────────── */
.checkout-wrapper {
    max-width: 900px;
    margin: 40px auto 80px;
    padding: 0 20px;
}

.checkout-title {
    font-size: 26px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 24px;
    letter-spacing: -0.5px;
}

.checkout-layout {
    display: grid;
    grid-template-columns: 1.5fr 1fr;
    gap: 30px;
}

@media (max-width: 768px) {
    .checkout-layout {
        grid-template-columns: 1fr;
    }
}

.panel-card {
    background: white;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    border: 1px solid var(--border);
}

.panel-title {
    font-size: 18px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 20px;
    border-bottom: 1.5px dashed var(--border);
    padding-bottom: 12px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    font-size: 14px;
    color: var(--text-mid);
}

textarea, select {
    width: 100%;
    padding: 12px 16px;
    border-radius: 10px;
    border: 1px solid var(--border);
    font-size: 15px;
    outline: none;
    background: white;
    font-family: 'Inter', sans-serif;
    color: var(--text-dark);
}

textarea:focus, select:focus {
    border-color: var(--primary);
}

.btn-order {
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
}

.btn-order:hover {
    background: var(--primary-dark);
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 14px;
    color: var(--text-light);
    font-weight: 500;
}

.summary-row.total {
    border-top: 1.5px dashed var(--border);
    padding-top: 16px;
    margin-top: 16px;
    font-size: 16px;
    font-weight: 800;
    color: var(--text-dark);
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
    .checkout-wrapper {
        margin: 20px auto 40px;
        padding: 0 16px;
    }
    .panel-card {
        padding: 16px;
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

<div class="checkout-wrapper">
    <h1 class="checkout-title">Secure Checkout</h1>

    <div class="checkout-layout">
        <!-- Delivery Card -->
        <div class="panel-card">
            <h2 class="panel-title">Delivery Details</h2>
            <form action="order" method="post">
                <div class="form-group">
                    <label for="address">Add Delivery Address</label>
                    <textarea id="address" name="address" rows="4" placeholder="Flat/House no., Street, Area, City..." required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="paymentMode">Choose Payment Method</label>
                    <select id="paymentMode" name="paymentMode">
                        <option value="COD">Cash on Delivery (COD)</option>
                        <option value="UPI">UPI / NetBanking / Wallet</option>
                        <option value="Card">Credit / Debit Card</option>
                    </select>
                </div>

                <button type="submit" class="btn-order">Pay & Place Order</button>
            </form>
        </div>

        <!-- Summary Card -->
        <div class="panel-card" style="height: fit-content;">
            <h2 class="panel-title">Order Details</h2>
            <% if (cart != null) { %>
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<%= cart.getTotalAmount() %></span>
                </div>
                <div class="summary-row">
                    <span>Delivery Charge</span>
                    <span>₹30</span>
                </div>
                <div class="summary-row">
                    <span>Taxes & Fees</span>
                    <span>₹15</span>
                </div>
                <div class="summary-row total">
                    <span>Grand Total</span>
                    <span>₹<%= cart.getTotalAmount() + 45 %></span>
                </div>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>
