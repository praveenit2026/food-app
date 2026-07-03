<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page import="com.food.model.User" %>
<%
    List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurants");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieHub - Order Food Online | Best Restaurants Near You</title>
<meta name="description" content="Order food online from the best restaurants near you. Fast delivery, great prices.">
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
    --shadow-hover: 0 8px 24px rgba(0,0,0,0.16);
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

.nav-location {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    font-weight: 600;
    color: var(--text-dark);
    cursor: pointer;
    border-bottom: 2px solid var(--text-dark);
    padding-bottom: 2px;
    white-space: nowrap;
    flex-shrink: 0;
}

.nav-location .city {
    font-weight: 800;
    font-size: 15px;
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
    transition: box-shadow 0.2s, border-color 0.2s;
}

.search-form:focus-within {
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(252,128,25,0.12);
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

.search-input::placeholder {
    color: #ababab;
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
    transition: background 0.2s;
}

.search-btn:hover {
    background: var(--primary-dark);
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
    white-space: nowrap;
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

/* ── HERO BANNER ─────────────────────────────────────── */
.hero {
    background: linear-gradient(135deg, #1C1C1C 0%, #2d2d2d 100%);
    padding: 50px 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    overflow: hidden;
    position: relative;
}

.hero::before {
    content: '';
    position: absolute;
    top: -40px;
    right: -40px;
    width: 300px;
    height: 300px;
    background: radial-gradient(circle, rgba(252,128,25,0.3) 0%, transparent 70%);
    pointer-events: none;
}

.hero-text h1 {
    font-size: 44px;
    font-weight: 900;
    color: white;
    line-height: 1.1;
    letter-spacing: -1.5px;
}

.hero-text h1 span {
    color: var(--primary);
}

.hero-text p {
    color: #aaaaaa;
    font-size: 16px;
    margin-top: 12px;
    font-weight: 400;
}

.hero-badges {
    display: flex;
    gap: 12px;
    margin-top: 24px;
    flex-wrap: wrap;
}

.hero-badge {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 500;
    backdrop-filter: blur(4px);
}

/* ── MAIN CONTENT ──────────────────────────────────────── */
.content-wrapper {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 40px 60px;
}

/* ── CATEGORY SECTION ──────────────────────────────────── */
.section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 40px 0 24px;
}

.section-title {
    font-size: 22px;
    font-weight: 800;
    color: var(--text-dark);
    letter-spacing: -0.5px;
}

.categories-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 12px;
    margin-bottom: 12px;
}

.category-chip {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    text-decoration: none;
}

.category-img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid transparent;
    transition: all 0.25s;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.category-chip:hover .category-img {
    border-color: var(--primary);
    transform: scale(1.06);
    box-shadow: 0 8px 20px rgba(252,128,25,0.25);
}

.category-label {
    font-size: 13px;
    font-weight: 600;
    color: var(--text-dark);
    text-align: center;
}

/* ── DIVIDER ────────────────────────────────────────────── */
.divider {
    border: none;
    border-top: 8px solid var(--bg-soft);
    margin: 36px -40px;
}

/* ── RESTAURANT GRID ─────────────────────────────────────── */
.restaurants-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
}

/* ── RESTAURANT CARD ─────────────────────────────────────── */
.rest-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    text-decoration: none;
    color: inherit;
    display: block;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    cursor: pointer;
}

.rest-card:hover {
    transform: translateY(-6px);
    box-shadow: var(--shadow-hover);
}

.card-img-wrap {
    position: relative;
    width: 100%;
    height: 180px;
    overflow: hidden;
    background: #f0f0f0;
}

.card-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
    display: block;
}

.rest-card:hover .card-img-wrap img {
    transform: scale(1.05);
}

.card-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.75) 0%, transparent 100%);
    padding: 30px 12px 10px;
}

.card-offer-badge {
    background: linear-gradient(135deg, #D14B00 0%, #FF6B00 100%);
    color: white;
    font-size: 11px;
    font-weight: 800;
    padding: 4px 10px;
    border-radius: 4px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    display: inline-block;
}

.card-body {
    padding: 14px 14px 16px;
}

.card-name {
    font-size: 16px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 6px;
    letter-spacing: -0.2px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.card-meta-row {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    margin-bottom: 6px;
}

.rating-pill {
    display: flex;
    align-items: center;
    gap: 3px;
    background: var(--green);
    color: white;
    font-size: 12px;
    font-weight: 700;
    padding: 2px 8px;
    border-radius: 6px;
}

.rating-pill.low {
    background: #f4a623;
}

.meta-dot {
    color: #d9d9d9;
    font-size: 14px;
}

.card-time {
    color: var(--text-mid);
    font-size: 13px;
    font-weight: 500;
}

.card-min {
    color: var(--text-mid);
    font-size: 13px;
    font-weight: 500;
}

.card-cuisine {
    font-size: 13px;
    color: var(--text-light);
    font-weight: 400;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    margin-bottom: 4px;
}

.card-location {
    font-size: 12px;
    color: var(--text-light);
    display: flex;
    align-items: center;
    gap: 4px;
}

.card-divider {
    border: none;
    border-top: 1px solid #f0f0f0;
    margin: 10px 0;
}

/* ── EMPTY STATE ────────────────────────────────────────── */
.empty-state {
    grid-column: 1 / -1;
    text-align: center;
    padding: 80px 20px;
    color: var(--text-light);
}

.empty-state-icon {
    font-size: 60px;
    margin-bottom: 16px;
}

.empty-state h3 {
    font-size: 22px;
    font-weight: 700;
    color: var(--text-mid);
    margin-bottom: 8px;
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
    .nav-location {
        order: 2;
        margin-right: auto;
        font-size: 13px;
    }
    .nav-actions {
        order: 3;
        margin-left: auto;
        gap: 6px;
    }
    .nav-search {
        order: 4;
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
    
    .hero {
        padding: 30px 20px;
    }
    .hero-text h1 {
        font-size: 28px;
    }
    .hero-text p {
        font-size: 14px;
    }
    .hero-badge {
        font-size: 11px;
        padding: 6px 12px;
    }
    
    .content-wrapper {
        padding: 0 16px 40px;
    }
    .divider {
        margin: 24px -16px;
    }
    
    .categories-grid {
        display: flex;
        overflow-x: auto;
        gap: 16px;
        padding: 4px 0 12px;
        scrollbar-width: none;
        -webkit-overflow-scrolling: touch;
    }
    .categories-grid::-webkit-scrollbar {
        display: none;
    }
    .category-chip {
        flex: 0 0 auto;
    }
    .category-img {
        width: 76px;
        height: 76px;
    }
    .category-label {
        font-size: 12px;
    }
    
    .restaurants-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 16px;
    }
    .card-img-wrap {
        height: 140px;
    }
    .card-body {
        padding: 12px;
    }
    .card-name {
        font-size: 15px;
    }
    .card-meta-row {
        font-size: 12px;
        gap: 6px;
    }
}

@media (max-width: 480px) {
    .nav-location {
        display: none;
    }
    .restaurants-grid {
        grid-template-columns: 1fr;
    }
    .card-img-wrap {
        height: 180px;
    }
}
</style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
    <a href="callRestaurantServlet" class="nav-logo">Foodie<span>Hub</span></a>

    <div class="nav-location">
        <span>📍</span>
        <span class="city">Bangalore</span>
        <span>▾</span>
    </div>

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

<!-- ── HERO BANNER ── -->
<div class="hero">
    <div class="hero-text">
        <h1>Hungry? <span>We've got<br>you covered.</span></h1>
        <p>Order from the best restaurants near you — fast delivery, every time.</p>
        <div class="hero-badges">
            <span class="hero-badge">🚴 25–40 min delivery</span>
            <span class="hero-badge">⭐ Top-rated restaurants</span>
            <span class="hero-badge">💳 No extra charges</span>
        </div>
    </div>
</div>

<!-- ── MAIN CONTENT ── -->
<div class="content-wrapper">

    <!-- Category Section -->
    <div class="section-header">
        <h2 class="section-title">What's on your mind?</h2>
    </div>

    <div class="categories-grid">
        <a href="search?q=biryani" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=160&h=160&fit=crop" alt="Biryani" loading="lazy">
            <span class="category-label">Biryani</span>
        </a>
        <a href="search?q=burger" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=160&h=160&fit=crop" alt="Burgers" loading="lazy">
            <span class="category-label">Burgers</span>
        </a>
        <a href="search?q=pizza" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1513104890138-7c749659a591?w=160&h=160&fit=crop" alt="Pizza" loading="lazy">
            <span class="category-label">Pizza</span>
        </a>
        <a href="search?q=chinese" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1585032226651-759b368d7246?w=160&h=160&fit=crop" alt="Chinese" loading="lazy">
            <span class="category-label">Chinese</span>
        </a>
        <a href="search?q=north indian" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=160&h=160&fit=crop" alt="North Indian" loading="lazy">
            <span class="category-label">North Indian</span>
        </a>
        <a href="search?q=south indian" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1630383249896-424e482df921?w=160&h=160&fit=crop" alt="South Indian" loading="lazy">
            <span class="category-label">South Indian</span>
        </a>
        <a href="search?q=desserts" class="category-chip">
            <img class="category-img" src="https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?w=160&h=160&fit=crop" alt="Desserts" loading="lazy">
            <span class="category-label">Desserts</span>
        </a>
    </div>

    <hr class="divider">

    <!-- Restaurants Section -->
    <div class="section-header">
        <h2 class="section-title">Top Restaurants Near You</h2>
        <span style="font-size:13px; color: var(--text-light);"><%= restaurantList != null ? restaurantList.size() : 0 %> places</span>
    </div>

    <div class="restaurants-grid">
        <% if (restaurantList != null && !restaurantList.isEmpty()) {
            // Offer texts to cycle through for variety
            String[] offers = {"Items at ₹120", "20% OFF up to ₹100", "Free Delivery", "Items at ₹89", "30% OFF", "₹50 OFF first order"};
            int i = 0;
            for (Restaurant r : restaurantList) {
                String offer = offers[i % offers.length];
                
                // Comprehensive image mapping based on restaurant name + cuisine keywords
                String img;
                String nameLower = r.getName().toLowerCase();
                String cuisineLower = r.getCuisineType() != null ? r.getCuisineType().toLowerCase() : "";
                String combined = nameLower + " " + cuisineLower;

                if (combined.contains("biryani") || combined.contains("pulao")) {
                    img = "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=400&h=220&fit=crop"; // biryani
                } else if (combined.contains("pizza") || combined.contains("italian")) {
                    img = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=220&fit=crop"; // pizza
                } else if (combined.contains("burger") || combined.contains("junction") || combined.contains("grill")) {
                    img = "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=220&fit=crop"; // burger
                } else if (combined.contains("south indian") || combined.contains("dosa") || combined.contains("idli") || combined.contains("vada") || combined.contains("udupi")) {
                    img = "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=400&h=220&fit=crop"; // dosa
                } else if (combined.contains("north indian") || combined.contains("punjabi") || combined.contains("rasoi") || combined.contains("tandoori") || combined.contains("mughal") || combined.contains("dhaba")) {
                    img = "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&h=220&fit=crop"; // butter chicken
                } else if (combined.contains("chinese") || combined.contains("noodle") || combined.contains("chow") || combined.contains("manchurian") || combined.contains("wok")) {
                    img = "https://images.unsplash.com/photo-1585032226651-759b368d7246?w=400&h=220&fit=crop"; // noodles
                } else if (combined.contains("sushi") || combined.contains("japanese") || combined.contains("asian")) {
                    img = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400&h=220&fit=crop"; // sushi
                } else if (combined.contains("roll") || combined.contains("kathi") || combined.contains("wrap") || combined.contains("frankie")) {
                    img = "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=400&h=220&fit=crop"; // rolls
                } else if (combined.contains("sweet") || combined.contains("dessert") || combined.contains("cake") || combined.contains("oasis") || combined.contains("mithai") || combined.contains("bakery")) {
                    img = "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=220&fit=crop"; // cake/dessert
                } else if (combined.contains("coffee") || combined.contains("cafe") || combined.contains("snack") || combined.contains("delight") || combined.contains("brew")) {
                    img = "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=220&fit=crop"; // coffee & snacks
                } else if (combined.contains("chicken") || combined.contains("fried") || combined.contains("wings")) {
                    img = "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400&h=220&fit=crop"; // chicken
                } else if (combined.contains("seafood") || combined.contains("fish") || combined.contains("prawn")) {
                    img = "https://images.unsplash.com/photo-1580476262798-bddd9f4b7369?w=400&h=220&fit=crop"; // seafood
                } else {
                    // Deterministic food-only fallback images (no restaurant interiors)
                    String[] fallbackImages = {
                        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=220&fit=crop",  // healthy bowl
                        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=220&fit=crop",  // food spread
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=220&fit=crop",  // pizza slice
                        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&h=220&fit=crop",    // grilled food
                        "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=220&fit=crop", // pancakes
                        "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&h=220&fit=crop"  // sandwich
                    };
                    img = fallbackImages[r.getRestaurantId() % fallbackImages.length];
                }
                
                String ratingClass = r.getRating() >= 4.0 ? "rating-pill" : "rating-pill low";
        %>
            <a href="menu?restaurantId=<%= r.getRestaurantId() %>" class="rest-card">
                <div class="card-img-wrap">
                    <img src="<%= img %>" alt="<%= r.getName() %>" loading="lazy">
                    <div class="card-overlay">
                        <span class="card-offer-badge"><%= offer %></span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="card-name"><%= r.getName() %></div>
                    <div class="card-meta-row">
                        <span class="<%= ratingClass %>">★ <%= r.getRating() %></span>
                        <span class="meta-dot">•</span>
                        <span class="card-time"><%= r.getEta() %> mins</span>
                        <span class="meta-dot">•</span>
                        <span class="card-min">Min: ₹150</span>
                    </div>
                    <div class="card-cuisine"><%= r.getCuisineType() %></div>
                    <hr class="card-divider">
                    <div class="card-location">📍 <%= r.getAddress() %></div>
                </div>
            </a>
        <%
                i++;
            }
        } else { %>
            <div class="empty-state">
                <div class="empty-state-icon">🍽️</div>
                <h3>No restaurants found</h3>
                <p>Check back later for new restaurants in your area.</p>
            </div>
        <% } %>
    </div>

</div>

</body>
</html>
