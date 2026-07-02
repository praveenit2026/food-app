<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.food.model.User" %>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>
<%
    String query = (String) request.getAttribute("query");
    List<Restaurant> matchingRestaurants = (List<Restaurant>) request.getAttribute("matchingRestaurants");
    List<Menu> matchingMenus = (List<Menu>) request.getAttribute("matchingMenus");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - Search Results for "<%= query != null ? query : "" %>"</title>
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

/* ── LAYOUT ─────────────────────────────────────────────── */
.container {
    max-width: 1200px;
    margin: 40px auto 80px;
    padding: 0 20px;
}

.search-header-title {
    font-size: 24px;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 30px;
    letter-spacing: -0.5px;
}

.search-header-title span {
    color: var(--primary);
}

.section-title {
    font-size: 18px;
    font-weight: 800;
    color: var(--text-dark);
    margin: 40px 0 20px;
    border-bottom: 2px solid var(--border);
    padding-bottom: 10px;
}

/* ── RESTAURANT GRID ─────────────────────────────────────── */
.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 24px;
}

.rest-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    text-decoration: none;
    color: inherit;
    display: block;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    border: 1px solid var(--border);
}

.rest-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}

.rest-img-wrap {
    width: 100%;
    height: 160px;
    background: #f0f0f0;
}

.rest-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.rest-body {
    padding: 16px;
}

.rest-name {
    font-size: 16px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 4px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.rest-cuisine {
    font-size: 13px;
    color: var(--text-light);
    margin-bottom: 10px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.rest-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 12px;
    font-weight: 700;
}

.rating-pill {
    background: var(--green);
    color: white;
    padding: 2px 6px;
    border-radius: 4px;
}

.eta-text {
    color: var(--text-mid);
}

/* ── MENU GRID ───────────────────────────────────────────── */
.menu-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 24px;
}

.menu-card {
    background: white;
    border-radius: 16px;
    border: 1px solid var(--border);
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.menu-info {
    flex: 1;
    padding-right: 20px;
}

.veg-icon {
    display: inline-block;
    border: 1.5px solid #0f8a65;
    padding: 1px;
    border-radius: 2px;
    margin-bottom: 6px;
}

.veg-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #0f8a65;
    display: block;
}

.menu-name {
    font-size: 16px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 4px;
}

.menu-desc {
    font-size: 12px;
    color: var(--text-light);
    line-height: 1.5;
    margin-bottom: 10px;
}

.menu-price {
    font-size: 15px;
    font-weight: 700;
    color: var(--text-dark);
}

.menu-action {
    position: relative;
    width: 100px;
    height: 100px;
    flex-shrink: 0;
}

.menu-item-img {
    width: 100%;
    height: 100%;
    border-radius: 12px;
    object-fit: cover;
    background: #f5f5f5;
}

.add-action-box {
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 85px;
    background: white;
    border: 1px solid var(--border);
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    border-radius: 6px;
    overflow: hidden;
    display: flex;
}

.qty-select {
    width: 32px;
    border: none;
    border-right: 1px solid var(--border);
    outline: none;
    font-size: 11px;
    font-weight: 700;
    padding: 4px 0;
    text-align: center;
    background: white;
}

.add-btn {
    flex: 1;
    border: none;
    background: white;
    color: var(--green);
    font-size: 11px;
    font-weight: 800;
    text-transform: uppercase;
    cursor: pointer;
    padding: 4px 0;
}

.add-btn:hover {
    background: var(--bg-soft);
}

.no-results {
    background: white;
    border-radius: 16px;
    padding: 40px;
    text-align: center;
    color: var(--text-light);
    border: 1px solid var(--border);
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
            <input type="text" name="q" class="search-input" placeholder="Search for restaurants and food" value="<%= query != null ? query : "" %>" required>
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

<div class="container">
    <h1 class="search-header-title">Search results for "<span><%= query != null ? query : "" %></span>"</h1>

    <!-- Restaurants -->
    <div class="section-title">Matching Restaurants</div>
    <% if (matchingRestaurants != null && !matchingRestaurants.isEmpty()) { 
        int idx = 0;
    %>
        <div class="restaurant-grid">
            <% for (Restaurant r : matchingRestaurants) { 
                // Comprehensive image mapping based on restaurant name + cuisine keywords
                String img;
                String nameLower = r.getName().toLowerCase();
                String cuisineLower = r.getCuisineType() != null ? r.getCuisineType().toLowerCase() : "";
                String combined = nameLower + " " + cuisineLower;

                if (combined.contains("biryani") || combined.contains("pulao")) {
                    img = "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=300&h=180&fit=crop"; // biryani
                } else if (combined.contains("pizza") || combined.contains("italian")) {
                    img = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300&h=180&fit=crop"; // pizza
                } else if (combined.contains("burger") || combined.contains("junction") || combined.contains("grill")) {
                    img = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=180&fit=crop"; // burger
                } else if (combined.contains("south indian") || combined.contains("dosa") || combined.contains("idli") || combined.contains("vada") || combined.contains("udupi")) {
                    img = "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=300&h=180&fit=crop"; // dosa
                } else if (combined.contains("north indian") || combined.contains("punjabi") || combined.contains("rasoi") || combined.contains("tandoori") || combined.contains("mughal") || combined.contains("dhaba")) {
                    img = "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300&h=180&fit=crop"; // butter chicken
                } else if (combined.contains("chinese") || combined.contains("noodle") || combined.contains("chow") || combined.contains("manchurian") || combined.contains("wok")) {
                    img = "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=300&h=180&fit=crop"; // noodles
                } else if (combined.contains("sushi") || combined.contains("japanese") || combined.contains("asian")) {
                    img = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=300&h=180&fit=crop"; // sushi
                } else if (combined.contains("roll") || combined.contains("kathi") || combined.contains("wrap") || combined.contains("frankie")) {
                    img = "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=300&h=180&fit=crop"; // rolls
                } else if (combined.contains("sweet") || combined.contains("dessert") || combined.contains("cake") || combined.contains("oasis") || combined.contains("mithai") || combined.contains("bakery")) {
                    img = "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=300&h=180&fit=crop"; // cake/dessert
                } else if (combined.contains("coffee") || combined.contains("cafe") || combined.contains("snack") || combined.contains("delight") || combined.contains("brew")) {
                    img = "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=300&h=180&fit=crop"; // coffee & snacks
                } else if (combined.contains("chicken") || combined.contains("fried") || combined.contains("wings")) {
                    img = "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=300&h=180&fit=crop"; // chicken
                } else if (combined.contains("seafood") || combined.contains("fish") || combined.contains("prawn")) {
                    img = "https://images.unsplash.com/photo-1580476262798-bddd9f4b7369?w=300&h=180&fit=crop"; // seafood
                } else {
                    // Deterministic food-only fallback images (no restaurant interiors)
                    String[] fallbackImages = {
                        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300&h=180&fit=crop",  // healthy bowl
                        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300&h=180&fit=crop",  // food spread
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&h=180&fit=crop",  // pizza slice
                        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=300&h=180&fit=crop"    // grilled food
                    };
                    img = fallbackImages[idx % fallbackImages.length];
                }
            %>
                <a href="menu?restaurantId=<%= r.getRestaurantId() %>" class="rest-card">
                    <div class="rest-img-wrap">
                        <img src="<%= img %>" alt="<%= r.getName() %>" loading="lazy">
                    </div>
                    <div class="rest-body">
                        <div class="rest-name"><%= r.getName() %></div>
                        <div class="rest-cuisine"><%= r.getCuisineType() %></div>
                        <div class="rest-meta">
                            <span class="rating-pill">★ <%= r.getRating() %></span>
                            <span class="eta-text">🚴 <%= r.getEta() %> mins</span>
                        </div>
                    </div>
                </a>
            <% 
                idx++;
            } %>
        </div>
    <% } else { %>
        <div class="no-results">No restaurants found matching your query.</div>
    <% } %>

    <!-- Food Items -->
    <div class="section-title">Matching Food Items</div>
    <% if (matchingMenus != null && !matchingMenus.isEmpty()) { 
        int idx = 0;
    %>
        <div class="menu-grid">
            <% for (Menu item : matchingMenus) { 
                // Dynamic food item image matching
                String img = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=100&h=100&fit=crop"; // fallback salad
                String itemNameLower = item.getName().toLowerCase();
                
                if (itemNameLower.contains("mutton") && itemNameLower.contains("biryani")) {
                    img = "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("veg") && itemNameLower.contains("biryani")) {
                    img = "https://images.unsplash.com/photo-1645177628172-a94c1f96e6db?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("biryani") || itemNameLower.contains("pulao") || itemNameLower.contains("rice")) {
                    img = "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("pizza")) {
                    img = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("burger")) {
                    img = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("noodles") || itemNameLower.contains("manchurian") || itemNameLower.contains("chinese") || itemNameLower.contains("chow")) {
                    img = "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("paneer") || itemNameLower.contains("dal") || itemNameLower.contains("roti") || itemNameLower.contains("naan") || itemNameLower.contains("curry") || itemNameLower.contains("tandoori")) {
                    img = "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("coke") || itemNameLower.contains("drink") || itemNameLower.contains("beverage") || itemNameLower.contains("lassi") || itemNameLower.contains("soda") || itemNameLower.contains("water")) {
                    img = "https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=100&h=100&fit=crop";
                } else if (itemNameLower.contains("cake") || itemNameLower.contains("ice cream") || itemNameLower.contains("dessert") || itemNameLower.contains("sweet") || itemNameLower.contains("jamun") || itemNameLower.contains("halwa")) {
                    img = "https://images.unsplash.com/photo-1551024601-bec78aea704b?w=100&h=100&fit=crop";
                } else {
                    String[] fallbackMenuImages = {
                        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100&h=100&fit=crop",
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=100&h=100&fit=crop",
                        "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=100&h=100&fit=crop",
                        "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=100&h=100&fit=crop"
                    };
                    img = fallbackMenuImages[idx % fallbackMenuImages.length];
                }
            %>
                <div class="menu-card">
                    <div class="menu-info">
                        <div class="veg-icon"><span class="veg-dot"></span></div>
                        <div class="menu-name"><%= item.getName() %></div>
                        <div class="menu-desc"><%= item.getDescription() %></div>
                        <div class="menu-price">₹<%= item.getPrice() %></div>
                    </div>
                    <div class="menu-action">
                        <img class="menu-item-img" src="<%= img %>" alt="<%= item.getName() %>" loading="lazy">
                        <div class="add-action-box" style="display: flex; align-items: center; justify-content: center;">
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
                                    <button type="submit" class="add-btn" style="width: 100%; text-align: center; border: none; background: white; color: #48c479; font-weight: 800; cursor: pointer; padding: 6px 0; text-transform: uppercase;">Add</button>
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
                                        <button type="submit" style="border: none; background: transparent; padding: 4px 8px; color: #FC8019; font-weight: 800; cursor: pointer; font-size: 12px;">-</button>
                                    </form>
                                    
                                    <span style="font-weight: 800; color: #FC8019; font-size: 11px;"><%= cItem.getQuantity() %></span>
                                    
                                    <!-- Increment Form -->
                                    <form action="<%= request.getContextPath() %>/cart" method="post" style="margin: 0; display: flex;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="itemId" value="<%= item.getMenuId() %>">
                                        <input type="hidden" name="quantity" value="<%= cItem.getQuantity() + 1 %>">
                                        <button type="submit" style="border: none; background: transparent; padding: 4px 8px; color: #FC8019; font-weight: 800; cursor: pointer; font-size: 12px;">+</button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                idx++;
            } %>
        </div>
    <% } else { %>
        <div class="no-results">No food items found matching your query.</div>
    <% } %>
</div>

</body>
</html>
