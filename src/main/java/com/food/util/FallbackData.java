package com.food.util;

import com.food.model.Menu;
import com.food.model.Restaurant;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * In-memory static fallback data served when the database is unavailable.
 * Mirrors the seed data in supabase_migration.sql exactly.
 */
public class FallbackData {

    // ── Restaurants ──────────────────────────────────────────────────────────
    private static final List<Restaurant> RESTAURANTS = new ArrayList<>(Arrays.asList(
        new Restaurant(1,  "Burger Palace",         "Burgers, Fast Food",    4.5f, "Electronic City, Bangalore", 25, "burgerpalace@food.com",  "password"),
        new Restaurant(2,  "Pizza Corner",          "Pizza, Italian",        4.3f, "Koramangala",                30, "pizzacorner@food.com",   "password"),
        new Restaurant(3,  "Biryani House",         "Biryani, South Indian", 4.7f, "HSR Layout",                 35, "biryanihouse@food.com",  "password"),
        new Restaurant(4,  "Chinese Bowl",          "Chinese, Noodles",      4.2f, "BTM Layout",                 20, "chinesebowl@food.com",   "password"),
        new Restaurant(5,  "Tandoori Treat",        "North Indian",          4.6f, "Whitefield",                 28, "tandooritreat@food.com", "password"),
        new Restaurant(6,  "Cafe Delight",          "Coffee, Snacks",        4.4f, "Indiranagar",                18, "cafedelight@food.com",   "password"),
        new Restaurant(7,  "South Indian Delights", "South Indian",          4.8f, "Jayanagar, Bangalore",       15, "southdelights@food.com", "password"),
        new Restaurant(8,  "Sweet Oasis",           "Desserts, Cakes",       4.5f, "Malleshwaram",               22, "sweetoasis@food.com",    "password"),
        new Restaurant(9,  "Kathi Roll Express",    "Rolls, Fast Food",      4.1f, "BTM Layout",                 19, "rollexpress@food.com",   "password"),
        new Restaurant(10, "Noodle & Sushi House",  "Chinese, Japanese",     4.4f, "Koramangala",                26, "noodlesushi@food.com",   "password"),
        new Restaurant(11, "Punjabi Rasoi",         "North Indian, Mughlai", 4.7f, "Marathahalli",               32, "punjabirasoi@food.com",  "password"),
        new Restaurant(12, "Burger Junction",       "Burgers, Fast Food",    4.3f, "HSR Layout",                 21, "burgerjunction@food.com","password")
    ));

    // ── Menus ─────────────────────────────────────────────────────────────────
    private static final List<Menu> MENUS = new ArrayList<>(Arrays.asList(
        new Menu(1,  1,  "Classic Burger",        "Juicy beef patty with lettuce and tomato",       120.00, true, null),
        new Menu(2,  1,  "Cheese Fries",          "Crispy fries loaded with melted cheese",          80.00, true, null),
        new Menu(3,  1,  "Onion Rings",           "Golden fried onion rings with dipping sauce",     90.00, true, null),
        new Menu(4,  1,  "Coke",                  "Chilled Coca-Cola 300ml",                         40.00, true, null),
        new Menu(5,  2,  "Margherita Pizza",      "Classic tomato and mozzarella pizza",            250.00, true, null),
        new Menu(6,  2,  "Pepperoni Feast",       "Loaded pepperoni with extra cheese",             350.00, true, null),
        new Menu(7,  2,  "Garlic Breadsticks",    "Oven-baked breadsticks with garlic butter",      110.00, true, null),
        new Menu(8,  3,  "Chicken Biryani",       "Aromatic basmati rice with tender chicken",      180.00, true, null),
        new Menu(9,  3,  "Mutton Biryani",        "Slow-cooked mutton biryani with raita",          240.00, true, null),
        new Menu(10, 3,  "Veg Biryani",           "Fragrant biryani with seasonal vegetables",      150.00, true, null),
        new Menu(11, 3,  "Raita",                 "Cool yogurt with cucumber and spices",            40.00, true, null),
        new Menu(12, 4,  "Veg Hakka Noodles",     "Stir-fried noodles with vegetables",             130.00, true, null),
        new Menu(13, 4,  "Chicken Fried Rice",    "Classic fried rice with egg and chicken",        150.00, true, null),
        new Menu(14, 4,  "Manchurian",            "Deep-fried balls in spicy Manchurian sauce",     140.00, true, null),
        new Menu(15, 5,  "Butter Chicken",        "Creamy tomato-based chicken curry",              220.00, true, null),
        new Menu(16, 5,  "Garlic Naan",           "Soft naan bread with garlic butter",              50.00, true, null),
        new Menu(17, 5,  "Lassi",                 "Chilled yogurt drink - sweet or salted",          60.00, true, null),
        new Menu(18, 6,  "Filter Coffee",         "South Indian filter coffee with froth",           40.00, true, null),
        new Menu(19, 6,  "Club Sandwich",         "Multi-layered sandwich with veggies and cheese",  95.00, true, null),
        new Menu(20, 6,  "Chocolate Muffin",      "Freshly baked chocolate muffin",                  70.00, true, null),
        new Menu(21, 7,  "Masala Dosa",           "Crispy dosa with spiced potato filling",          80.00, true, null),
        new Menu(22, 7,  "Idli Sambar (2 Pcs)",   "Soft idlis served with sambar and chutney",       50.00, true, null),
        new Menu(23, 7,  "Vada",                  "Crispy lentil doughnut with sambar",              45.00, true, null),
        new Menu(24, 8,  "Gulab Jamun (2 Pcs)",   "Soft milk-solid balls soaked in sugar syrup",     60.00, true, null),
        new Menu(25, 8,  "Chocolate Cake Slice",  "Rich moist chocolate cake",                      120.00, true, null),
        new Menu(26, 8,  "Fruit Custard",         "Mixed fruit custard with cream",                   80.00, true, null),
        new Menu(27, 9,  "Paneer Kathi Roll",     "Spicy paneer filling in a flaky paratha roll",   110.00, true, null),
        new Menu(28, 9,  "Chicken Kathi Roll",    "Marinated chicken wrapped in a soft roll",       130.00, true, null),
        new Menu(29, 10, "Dragon Roll (Sushi)",   "Spicy tuna and avocado sushi roll",              280.00, true, null),
        new Menu(30, 10, "Chicken Ramen",         "Japanese noodle soup with soft-boiled egg",      220.00, true, null),
        new Menu(31, 11, "Dal Makhani",           "Creamy black lentils cooked overnight",          180.00, true, null),
        new Menu(32, 11, "Tandoori Chicken",      "Clay-oven roasted chicken with spices",          260.00, true, null),
        new Menu(33, 12, "Double Smash Burger",   "Double-patty smash burger with special sauce",   180.00, true, null),
        new Menu(34, 3,  "Paneer Butter Masala",  "Rich and creamy paneer in tomato gravy",         200.00, true, null),
        new Menu(35, 12, "Loaded Fries",          "Fries topped with cheese, jalapenos, and sauce", 110.00, true, null)
    ));

    /** Returns a copy of all restaurants. */
    public static List<Restaurant> getAllRestaurants() {
        return new ArrayList<>(RESTAURANTS);
    }

    /** Returns the restaurant with the given ID, or null. */
    public static Restaurant getRestaurant(int id) {
        for (Restaurant r : RESTAURANTS) {
            if (r.getRestaurantId() == id) return r;
        }
        return null;
    }

    /** Returns all menu items for a given restaurant. */
    public static List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> result = new ArrayList<>();
        for (Menu m : MENUS) {
            if (m.getRestaurantId() == restaurantId) result.add(m);
        }
        return result;
    }

    /** Returns all menu items. */
    public static List<Menu> getAllMenus() {
        return new ArrayList<>(MENUS);
    }

    /**
     * Case-insensitive search across restaurants (name, cuisine_type)
     * and menus (name, description).
     */
    public static List<Restaurant> searchRestaurants(String query) {
        String q = query.toLowerCase();
        List<Restaurant> result = new ArrayList<>();
        for (Restaurant r : RESTAURANTS) {
            if ((r.getName()        != null && r.getName().toLowerCase().contains(q)) ||
                (r.getCuisineType() != null && r.getCuisineType().toLowerCase().contains(q))) {
                result.add(r);
            }
        }
        return result;
    }

    public static List<Menu> searchMenus(String query) {
        String q = query.toLowerCase();
        List<Menu> result = new ArrayList<>();
        for (Menu m : MENUS) {
            if ((m.getName()        != null && m.getName().toLowerCase().contains(q)) ||
                (m.getDescription() != null && m.getDescription().toLowerCase().contains(q))) {
                result.add(m);
            }
        }
        return result;
    }
}
