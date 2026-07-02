<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>
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
<title>FoodieHub - Shopping Cart</title>
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

/* ── CART LAYOUT ────────────────────────────────────────── */
.cart-wrapper {
    max-width: 1000px;
    margin: 40px auto 80px;
    padding: 0 20px;
}

.cart-title {
    font-size: 26px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 24px;
    letter-spacing: -0.5px;
}

.cart-layout {
    display: grid;
    grid-template-columns: 2fr 1.2fr;
    gap: 30px;
}

@media (max-width: 768px) {
    .cart-layout {
        grid-template-columns: 1fr;
    }
}

.cart-card {
    background: white;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    border: 1px solid var(--border);
}

.cart-item {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 20px 0;
    border-bottom: 1px solid var(--border);
}

.cart-item:first-child {
    padding-top: 0;
}

.cart-item:last-child {
    padding-bottom: 0;
    border-bottom: none;
}

.cart-item-img {
    width: 72px;
    height: 72px;
    border-radius: 12px;
    object-fit: cover;
    flex-shrink: 0;
    background: var(--bg-soft);
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.item-details {
    flex: 1;
}

.item-veg {
    display: inline-block;
    border: 1.5px solid #0f8a65;
    padding: 1px;
    border-radius: 2px;
    margin-bottom: 6px;
}

.item-veg-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #0f8a65;
    display: block;
}

.item-name {
    font-size: 16px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 4px;
}

.item-price {
    font-size: 14px;
    font-weight: 600;
    color: var(--text-mid);
}

.item-actions {
    display: flex;
    align-items: center;
    gap: 20px;
}

.qty-control {
    display: flex;
    align-items: center;
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.02);
}

.qty-btn {
    background: white;
    border: none;
    width: 32px;
    height: 32px;
    font-size: 16px;
    font-weight: 600;
    color: var(--primary);
    cursor: pointer;
}

.qty-btn:hover {
    background: var(--bg-soft);
}

.qty-display {
    width: 36px;
    text-align: center;
    font-size: 14px;
    font-weight: 700;
    color: var(--text-dark);
}

.remove-btn {
    background: none;
    border: none;
    color: #e53e3e;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

.remove-btn:hover {
    color: #c53030;
}

/* ── SUMMARY CARD ─────────────────────────────────────── */
.summary-card {
    background: white;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    border: 1px solid var(--border);
    height: fit-content;
}

.summary-heading {
    font-size: 18px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 18px;
    border-bottom: 1.5px dashed var(--border);
    padding-bottom: 12px;
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
    font-size: 17px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 24px;
}

.checkout-btn {
    display: block;
    width: 100%;
    background: var(--primary);
    color: white;
    text-align: center;
    text-decoration: none;
    padding: 14px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 700;
    box-shadow: 0 4px 12px rgba(252,128,25,0.2);
    transition: background 0.2s;
}

.checkout-btn:hover {
    background: var(--primary-dark);
}

.clear-btn {
    display: block;
    width: 100%;
    background: transparent;
    border: 1px solid var(--border);
    color: var(--text-light);
    padding: 10px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 12px;
    transition: all 0.2s;
}

.clear-btn:hover {
    background: var(--bg-soft);
    color: var(--text-dark);
}

/* ── EMPTY STATE ────────────────────────────────────────── */
.empty-cart-card {
    background: white;
    border-radius: 16px;
    padding: 60px 40px;
    text-align: center;
    border: 1px solid var(--border);
    box-shadow: 0 4px 16px rgba(0,0,0,0.04);
}

.empty-icon {
    font-size: 64px;
    margin-bottom: 16px;
}

.empty-title {
    font-size: 20px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 8px;
}

.empty-desc {
    font-size: 14px;
    color: var(--text-light);
    margin-bottom: 24px;
}

.shop-link {
    display: inline-block;
    background: var(--primary);
    color: white;
    text-decoration: none;
    padding: 12px 28px;
    border-radius: 10px;
    font-weight: 700;
    font-size: 14px;
    box-shadow: 0 4px 12px rgba(252,128,25,0.2);
    transition: background 0.2s;
}

.shop-link:hover {
    background: var(--primary-dark);
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
        <% } else { %>
            <a href="login" class="nav-btn nav-btn-ghost">Sign In</a>
            <a href="register" class="nav-btn nav-btn-primary">Sign Up</a>
            <a href="restaurant/login" class="nav-btn nav-btn-outline">Partner Portal</a>
        <% } %>
    </div>
</nav>

<div class="cart-wrapper">
    <h1 class="cart-title">Your Shopping Cart</h1>

    <% if (cart != null && !cart.getItems().isEmpty()) { %>
        <div class="cart-layout">
            <!-- Items Card -->
            <div class="cart-card">
                <% for (CartItem item : cart.getItems().values()) {
                    // Resolve food image from item name
                    String n = item.getName().toLowerCase();
                    String cImg;
                    if (n.contains("mutton") && n.contains("biryani"))
                        cImg = "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("veg") && n.contains("biryani"))
                        cImg = "https://images.unsplash.com/photo-1645177628172-a94c1f96e6db?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("biryani") || n.contains("pulao") || n.contains("rice"))
                        cImg = "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("pizza"))
                        cImg = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("burger"))
                        cImg = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("noodle") || n.contains("manchurian") || n.contains("chow"))
                        cImg = "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("paneer") || n.contains("dal") || n.contains("curry") || n.contains("naan") || n.contains("roti") || n.contains("tandoori"))
                        cImg = "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("dosa") || n.contains("idli") || n.contains("vada") || n.contains("sambar"))
                        cImg = "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("coffee") || n.contains("tea") || n.contains("lassi") || n.contains("drink") || n.contains("beverage") || n.contains("coke"))
                        cImg = "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("cake") || n.contains("dessert") || n.contains("sweet") || n.contains("pastry") || n.contains("jamun") || n.contains("muffin"))
                        cImg = "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("roll") || n.contains("wrap"))
                        cImg = "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("sushi") || n.contains("dumpling"))
                        cImg = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("sandwich") || n.contains("toast"))
                        cImg = "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("fries") || n.contains("chips"))
                        cImg = "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=144&h=144&fit=crop&auto=format";
                    else if (n.contains("chicken"))
                        cImg = "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=144&h=144&fit=crop&auto=format";
                    else
                        cImg = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=144&h=144&fit=crop&auto=format";
                %>
                    <div class="cart-item">
                        <img class="cart-item-img" src="<%= cImg %>" alt="<%= item.getName() %>" loading="lazy">
                        <div class="item-details">
                            <div class="item-veg">
                                <span class="item-veg-dot"></span>
                            </div>
                            <div class="item-name"><%= item.getName() %></div>
                            <div class="item-price">₹<%= item.getPrice() %></div>
                        </div>
                        
                        <div class="item-actions">
                            <!-- Update Qty Form -->
                            <form action="cart" method="post" style="display: flex;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <div class="qty-control">
                                    <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>" class="qty-btn">-</button>
                                    <div class="qty-display"><%= item.getQuantity() %></div>
                                    <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>" class="qty-btn">+</button>
                                </div>
                            </form>

                            <!-- Remove Form -->
                            <form action="cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <button type="submit" class="remove-btn">Remove</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>

            <!-- Order Summary -->
            <div class="summary-card">
                <h2 class="summary-heading">Bill Details</h2>
                <div class="summary-row">
                    <span>Item Total</span>
                    <span>₹<%= cart.getTotalAmount() %></span>
                </div>
                <div class="summary-row">
                    <span>Delivery Fee</span>
                    <span>₹30</span>
                </div>
                <div class="summary-row">
                    <span>Govt Taxes & Charges</span>
                    <span>₹15</span>
                </div>
                <div class="summary-row total">
                    <span>To Pay</span>
                    <span>₹<%= cart.getTotalAmount() + 45 %></span>
                </div>
                
                <a href="checkout" class="checkout-btn">Proceed to Checkout</a>
                
                <form action="cart" method="post">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="clear-btn">Clear Cart</button>
                </form>
            </div>
        </div>
    <% } else { %>
        <div class="empty-cart-card">
            <div class="empty-icon">🛒</div>
            <h2 class="empty-title">Your cart is empty</h2>
            <p class="empty-desc">Good food is always cooking! Go ahead, explore some top restaurants.</p>
            <a href="callRestaurantServlet" class="shop-link">See Restaurants Near You</a>
        </div>
    <% } %>
</div>

</body>
</html>
