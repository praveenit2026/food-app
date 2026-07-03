<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page import="com.food.model.User" %>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>
<%
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - <%= restaurant != null ? restaurant.getName() : "Menu" %></title>
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
    background: #ffffff;
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

.nav-search {
    flex: 1;
    max-width: 480px;
    margin: 0 20px;
}

.search-form {
    display: flex;
    align-items: center;
    background: var(--bg-soft);
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
}

.search-icon {
    padding: 0 12px;
    font-size: 16px;
    color: var(--text-light);
}

.search-input {
    flex: 1;
    border: none;
    background: transparent;
    padding: 11px 8px;
    font-size: 14px;
    font-family: 'Inter', sans-serif;
    color: var(--text-dark);
    outline: none;
}

.search-btn {
    background: var(--primary);
    border: none;
    color: white;
    padding: 11px 18px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Inter', sans-serif;
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

/* ── RESTAURANT BANNER ───────────────────────────────── */
.restaurant-details {
    max-width: 800px;
    margin: 40px auto 0;
    padding: 0 20px;
}

.breadcrumb {
    font-size: 10px;
    color: var(--text-light);
    margin-bottom: 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.breadcrumb a {
    color: inherit;
    text-decoration: none;
}

.breadcrumb a:hover {
    color: var(--primary);
}

.rest-header-card {
    border-bottom: 1.5px dashed var(--border);
    padding-bottom: 24px;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.rest-info h1 {
    font-size: 28px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 8px;
    letter-spacing: -0.5px;
}

.rest-cuisine {
    font-size: 14px;
    color: var(--text-light);
    margin-bottom: 6px;
}

.rest-address {
    font-size: 13px;
    color: var(--text-light);
}

.rest-rating-box {
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 8px;
    text-align: center;
    background: white;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.rating-stars {
    font-size: 15px;
    font-weight: 800;
    color: var(--green);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
    border-bottom: 1px solid var(--border);
    padding-bottom: 6px;
    margin-bottom: 6px;
}

.rating-count {
    font-size: 10px;
    color: var(--text-light);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* ── DETAILS ROW ─────────────────────────────────────────── */
.rest-meta-row {
    display: flex;
    gap: 30px;
    padding: 16px 0;
    font-size: 14px;
    font-weight: 700;
    color: var(--text-dark);
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 8px;
}

.meta-item span.icon {
    font-size: 18px;
}

.divider-line {
    border: none;
    border-top: 1px solid var(--border);
    margin: 0;
}

/* ── MENU LIST ───────────────────────────────────────────── */
.menu-section {
    max-width: 800px;
    margin: 30px auto 80px;
    padding: 0 20px;
}

.menu-title {
    font-size: 18px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 24px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.menu-count {
    background: var(--bg-soft);
    font-size: 13px;
    font-weight: 600;
    padding: 2px 10px;
    border-radius: 12px;
    color: var(--text-light);
}

.menu-item-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 24px 0;
    border-bottom: 1px solid var(--border);
}

.menu-item-details {
    flex: 1;
    padding-right: 30px;
}

.veg-icon {
    display: inline-block;
    border: 1.5px solid #0f8a65;
    padding: 2px;
    border-radius: 3px;
    margin-bottom: 8px;
}

.veg-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #0f8a65;
    display: block;
}

.menu-item-name {
    font-size: 17px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 4px;
}

.menu-item-price {
    font-size: 15px;
    font-weight: 600;
    color: var(--text-dark);
    margin-bottom: 12px;
}

.menu-item-desc {
    font-size: 13px;
    color: var(--text-light);
    line-height: 1.5;
}

.menu-item-action {
    position: relative;
    width: 120px;
    height: 120px;
    flex-shrink: 0;
}

.menu-item-img {
    width: 100%;
    height: 100%;
    border-radius: 12px;
    object-fit: cover;
    background: #f5f5f5;
}

.add-action-container {
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    background: white;
    border: 1px solid var(--border);
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
}

.add-form-menu {
    display: flex;
}

.qty-select {
    width: 40px;
    border: none;
    border-right: 1px solid var(--border);
    outline: none;
    font-size: 12px;
    font-weight: 700;
    padding: 6px 0;
    text-align: center;
    background: white;
    cursor: pointer;
}

.add-submit-btn {
    flex: 1;
    border: none;
    background: white;
    color: var(--green);
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    cursor: pointer;
    padding: 6px 0;
}

.add-submit-btn:hover {
    background: var(--bg-soft);
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
    .nav-search {
        order: 3;
        flex: 1 0 100%;
        margin: 0;
        max-width: 100%;
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
    
    .restaurant-details {
        margin-top: 20px;
    }
    .rest-info h1 {
        font-size: 22px;
    }
    .rest-meta-row {
        gap: 16px;
        font-size: 12px;
    }
}

@media (max-width: 600px) {
    .rest-header-card {
        flex-direction: column;
        gap: 16px;
        align-items: stretch;
    }
    .rest-rating-box {
        align-self: flex-start;
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 6px 12px;
    }
    .rating-stars {
        border-bottom: none;
        padding-bottom: 0;
        margin-bottom: 0;
    }
}

@media (max-width: 480px) {
    .menu-section {
        margin-bottom: 40px;
    }
    .menu-item-card {
        gap: 16px;
        padding: 16px 0;
    }
    .menu-item-details {
        padding-right: 0;
    }
    .menu-item-action {
        width: 96px;
        height: 96px;
    }
    .menu-item-name {
        font-size: 15px;
    }
    .menu-item-desc {
        font-size: 12px;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
}
</style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
    <a href="callRestaurantServlet" class="nav-logo">Foodie<span>Hub</span></a>

    <div class="nav-search">
        <form action="search" method="get" class="search-form">
            <span class="search-icon">🔍</span>
            <input type="text" name="q" class="search-input" placeholder="Search for restaurants and food" required>
            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>

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

<!-- ── RESTAURANT DETAILS ── -->
<div class="restaurant-details">
    <div class="breadcrumb">
        <a href="callRestaurantServlet">Home</a> / 
        <span><%= restaurant != null ? restaurant.getName() : "Restaurant" %></span>
    </div>

    <% if (restaurant != null) { %>
        <div class="rest-header-card">
            <div class="rest-info">
                <h1><%= restaurant.getName() %></h1>
                <div class="rest-cuisine"><%= restaurant.getCuisineType() %></div>
                <div class="rest-address"><%= restaurant.getAddress() %></div>
            </div>
            <div class="rest-rating-box">
                <div class="rating-stars">★ <%= restaurant.getRating() %></div>
                <div class="rating-count">100+ ratings</div>
            </div>
        </div>

        <div class="rest-meta-row">
            <div class="meta-item">
                <span class="icon">🚴</span>
                <span><%= restaurant.getEta() %> MINS</span>
            </div>
            <div class="meta-item">
                <span class="icon">🪙</span>
                <span>₹150 MIN ORDER</span>
            </div>
        </div>
    <% } %>
</div>

<hr class="divider-line" style="max-width: 800px; margin: 0 auto;">

<!-- ── MENU ITEMS ── -->
<div class="menu-section">
    <div class="menu-title">
        <span>Recommended Items</span>
        <span class="menu-count"><%= menuList != null ? menuList.size() : 0 %> items</span>
    </div>

    <% if (menuList != null && !menuList.isEmpty()) {
        int idx = 0;
        for (Menu item : menuList) {

            // ── Primary: map DB image_path filenames to curated Unsplash food photos ──
            java.util.Map<String, String> imgMap = new java.util.LinkedHashMap<>();
            imgMap.put("burger.jpg",         "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=240&h=240&fit=crop&auto=format");
            imgMap.put("chicken_burger.jpg", "https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=240&h=240&fit=crop&auto=format");
            imgMap.put("paneer_burger.jpg",  "https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=240&h=240&fit=crop&auto=format");
            imgMap.put("fries.jpg",          "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=240&h=240&fit=crop&auto=format");
            imgMap.put("onion_rings.jpg",    "https://images.unsplash.com/photo-1639024471283-03518883512d?w=240&h=240&fit=crop&auto=format");
            imgMap.put("coke.jpg",           "https://images.unsplash.com/photo-1554866585-cd94860890b7?w=240&h=240&fit=crop&auto=format");
            imgMap.put("pizza.jpg",          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=240&h=240&fit=crop&auto=format");
            imgMap.put("pepperoni.jpg",      "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=240&h=240&fit=crop&auto=format");
            imgMap.put("garlic_bread.jpg",   "https://images.unsplash.com/photo-1619531040576-f9416740661e?w=240&h=240&fit=crop&auto=format");
            imgMap.put("biryani.jpg",        "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=240&h=240&fit=crop&auto=format");
            imgMap.put("mutton_biryani.jpg", "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=240&h=240&fit=crop&auto=format");
            imgMap.put("veg_biryani.jpg",    "https://images.unsplash.com/photo-1645177628172-a94c1f96e6db?w=240&h=240&fit=crop&auto=format");
            imgMap.put("lassi.jpg",          "https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=240&h=240&fit=crop&auto=format");
            imgMap.put("noodles.jpg",        "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=240&h=240&fit=crop&auto=format");
            imgMap.put("chicken_noodles.jpg","https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=240&h=240&fit=crop&auto=format");
            imgMap.put("manchurian.jpg",     "https://images.unsplash.com/photo-1633947456581-5b2f40f32adc?w=240&h=240&fit=crop&auto=format");
            imgMap.put("spring_rolls.jpg",   "https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=240&h=240&fit=crop&auto=format");
            imgMap.put("tandoori_chicken.jpg","https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=240&h=240&fit=crop&auto=format");
            imgMap.put("butter_chicken.jpg", "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=240&h=240&fit=crop&auto=format");
            imgMap.put("garlic_naan.jpg",    "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=240&h=240&fit=crop&auto=format");
            imgMap.put("butter_naan.jpg",    "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=240&h=240&fit=crop&auto=format");
            imgMap.put("coffee.jpg",         "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=240&h=240&fit=crop&auto=format");
            imgMap.put("sandwich.jpg",       "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=240&h=240&fit=crop&auto=format");
            imgMap.put("muffin.jpg",         "https://images.unsplash.com/photo-1558303893-9a581a2d0090?w=240&h=240&fit=crop&auto=format");
            imgMap.put("dosa.jpg",           "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=240&h=240&fit=crop&auto=format");
            imgMap.put("idli.jpg",           "https://images.unsplash.com/photo-1630383249896-381b927ccff1?w=240&h=240&fit=crop&auto=format");
            imgMap.put("vada.jpg",           "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=240&h=240&fit=crop&auto=format");
            imgMap.put("chocolate_cake.jpg", "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=240&h=240&fit=crop&auto=format");
            imgMap.put("pastry.jpg",         "https://images.unsplash.com/photo-1551024601-bec78aea704b?w=240&h=240&fit=crop&auto=format");
            imgMap.put("gulab_jamun.jpg",    "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=240&h=240&fit=crop&auto=format");
            imgMap.put("chicken_roll.jpg",   "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=240&h=240&fit=crop&auto=format");
            imgMap.put("paneer_roll.jpg",    "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=240&h=240&fit=crop&auto=format");
            imgMap.put("egg_roll.jpg",       "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=240&h=240&fit=crop&auto=format");
            imgMap.put("sushi.jpg",          "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=240&h=240&fit=crop&auto=format");
            imgMap.put("dumplings.jpg",      "https://images.unsplash.com/photo-1563245372-f21724e3856d?w=240&h=240&fit=crop&auto=format");
            imgMap.put("paneer_butter.jpg",  "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=240&h=240&fit=crop&auto=format");
            imgMap.put("dal_makhani.jpg",    "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=240&h=240&fit=crop&auto=format");

            // ── Look up by DB image_path filename ──
            String dbImgPath = item.getImagePath();
            String mImg = (dbImgPath != null && imgMap.containsKey(dbImgPath.trim()))
                          ? imgMap.get(dbImgPath.trim()) : null;

            // ── If it's a full URL, use it directly ──
            if (mImg == null && dbImgPath != null && (dbImgPath.startsWith("http://") || dbImgPath.startsWith("https://"))) {
                mImg = dbImgPath;
            }

            // ── Keyword fallback based on item name ──
            if (mImg == null) {
                String n = item.getName().toLowerCase();
                if (n.contains("biryani") || n.contains("pulao") || n.contains("rice"))
                    mImg = "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("pizza"))
                    mImg = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("burger"))
                    mImg = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("noodle") || n.contains("manchurian") || n.contains("chow"))
                    mImg = "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("paneer") || n.contains("dal") || n.contains("curry") || n.contains("naan") || n.contains("roti") || n.contains("tandoori"))
                    mImg = "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("dosa") || n.contains("idli") || n.contains("vada") || n.contains("sambar"))
                    mImg = "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("coffee") || n.contains("tea") || n.contains("lassi") || n.contains("drink") || n.contains("beverage"))
                    mImg = "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("cake") || n.contains("dessert") || n.contains("sweet") || n.contains("pastry") || n.contains("jamun"))
                    mImg = "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("roll") || n.contains("wrap"))
                    mImg = "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("sushi") || n.contains("dumpling"))
                    mImg = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("sandwich") || n.contains("toast"))
                    mImg = "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=240&h=240&fit=crop&auto=format";
                else if (n.contains("fries") || n.contains("chips"))
                    mImg = "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=240&h=240&fit=crop&auto=format";
                else {
                    // Last resort: cycle through a fallback array
                    String[] fallback = {
                        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=240&h=240&fit=crop&auto=format",
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=240&h=240&fit=crop&auto=format",
                        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=240&h=240&fit=crop&auto=format",
                        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=240&h=240&fit=crop&auto=format"
                    };
                    mImg = fallback[idx % fallback.length];
                }
            }
    %>
        <div class="menu-item-card">
            <div class="menu-item-details">
                <div class="veg-icon">
                    <span class="veg-dot"></span>
                </div>
                <div class="menu-item-name"><%= item.getName() %></div>
                <div class="menu-item-price">₹<%= item.getPrice() %></div>
                <div class="menu-item-desc"><%= item.getDescription() %></div>
            </div>
            
            <div class="menu-item-action">
                <img class="menu-item-img" src="<%= mImg %>" alt="<%= item.getName() %>" loading="lazy">
                
                <div class="add-action-container" style="display: flex; align-items: center; justify-content: center;">
                    <%
                        Cart cart = (Cart) session.getAttribute("cart");
                        com.food.model.CartItem cItem = (cart != null) ? cart.getItems().get(item.getMenuId()) : null;
                        if (cItem == null) {
                    %>
                        <!-- Add Button -->
                        <form action="<%= request.getContextPath() %>/cart" method="post" style="display: flex; width: 100%; margin: 0;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="add-submit-btn" style="width: 100%; text-align: center; border: none; background: white; color: #48c479; font-weight: 800; cursor: pointer; padding: 8px 0; text-transform: uppercase;">Add</button>
                        </form>
                    <% } else { %>
                        <!-- - Qty + Controls -->
                        <div style="display: flex; width: 100%; align-items: center; justify-content: space-between; background: white;">
                            <!-- Decrement Form -->
                            <form action="<%= request.getContextPath() %>/cart" method="post" style="margin: 0; display: flex;">
                                <% if (cItem.getQuantity() > 1) { %>
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="quantity" value="<%= cItem.getQuantity() - 1 %>">
                                <% } else { %>
                                    <input type="hidden" name="action" value="remove">
                                <% } %>
                                <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                                <button type="submit" class="qty-btn" style="border: none; background: transparent; padding: 8px 12px; color: #FC8019; font-weight: 800; cursor: pointer; font-size: 14px;">-</button>
                            </form>
                            
                            <span style="font-weight: 800; color: #FC8019; font-size: 13px;"><%= cItem.getQuantity() %></span>
                            
                            <!-- Increment Form -->
                            <form action="<%= request.getContextPath() %>/cart" method="post" style="margin: 0; display: flex;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="quantity" value="<%= cItem.getQuantity() + 1 %>">
                                <button type="submit" class="qty-btn" style="border: none; background: transparent; padding: 8px 12px; color: #FC8019; font-weight: 800; cursor: pointer; font-size: 14px;">+</button>
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    <%
            idx++;
        }
    } else { %>
        <p style="text-align: center; color: var(--text-light); padding: 40px 0;">No items available on the menu right now.</p>
    <% } %>
</div>

</body>
</html>
