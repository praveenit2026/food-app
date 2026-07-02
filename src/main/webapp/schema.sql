-- MySQL Database Schema for AntiGravity Food App
-- Database: food_app

CREATE DATABASE IF NOT EXISTS food_app;
USE food_app;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

-- 2. Restaurant Table
CREATE TABLE IF NOT EXISTS restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(100),
    rating FLOAT DEFAULT 0.0,
    address VARCHAR(255),
    eta INT,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);

-- 3. Menu Table
CREATE TABLE IF NOT EXISTS menu (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    is_available TINYINT(1) DEFAULT 1,
    image_path VARCHAR(255),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id) ON DELETE CASCADE
);

-- 4. Cart Table
CREATE TABLE IF NOT EXISTS cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    payment_mode VARCHAR(50) DEFAULT 'COD',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id) ON DELETE SET NULL
);

-- 6. Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_id INT,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE SET NULL
);

-- Sample Data Seeding

-- Insert Restaurants
INSERT INTO restaurant (restaurant_id, name, cuisine_type, rating, address, eta, email, password) 
VALUES 
(1, 'Burger Palace', 'Burgers, Fast Food', 4.5, 'Electronic City, Bangalore', 25, 'burgerpalace@food.com', 'password'),
(2, 'Pizza Corner', 'Pizza, Italian', 4.3, 'Koramangala', 30, 'pizzacorner@food.com', 'password'),
(3, 'Biryani House', 'Biryani, South Indian', 4.7, 'HSR Layout', 35, 'biryanihouse@food.com', 'password'),
(4, 'Chinese Bowl', 'Chinese, Noodles', 4.2, 'BTM Layout', 20, 'chinesebowl@food.com', 'password'),
(5, 'Tandoori Treat', 'North Indian', 4.6, 'Whitefield', 28, 'tandooritreat@food.com', 'password'),
(6, 'Cafe Delight', 'Coffee, Snacks', 4.4, 'Indiranagar', 18, 'cafedelight@food.com', 'password'),
(7, 'South Indian Delights', 'South Indian', 4.8, 'Jayanagar, Bangalore', 15, 'southdelights@food.com', 'password'),
(8, 'Sweet Oasis', 'Desserts, Cakes', 4.5, 'Malleshwaram', 22, 'sweetoasis@food.com', 'password'),
(9, 'Kathi Roll Express', 'Rolls, Fast Food', 4.1, 'BTM Layout', 19, 'rollexpress@food.com', 'password'),
(10, 'Noodle & Sushi House', 'Chinese, Japanese', 4.4, 'Koramangala', 26, 'noodlesushi@food.com', 'password'),
(11, 'Punjabi Rasoi', 'North Indian, Mughlai', 4.7, 'Marathahalli', 32, 'punjabirasoi@food.com', 'password'),
(12, 'Burger Junction', 'Burgers, Fast Food', 4.3, 'HSR Layout', 21, 'burgerjunction@food.com', 'password')
ON DUPLICATE KEY UPDATE name=VALUES(name), cuisine_type=VALUES(cuisine_type), rating=VALUES(rating), address=VALUES(address), eta=VALUES(eta), email=VALUES(email), password=VALUES(password);

-- Insert Menu Items
INSERT INTO menu (menu_id, restaurant_id, name, description, price, is_available, image_path)
VALUES
-- Restaurant 1: Burger Palace
(1, 1, 'Classic Burger', 'Juicy beef patty with lettuce, tomato, and cheese.', 120.00, 1, 'burger.jpg'),
(2, 1, 'Cheese Fries', 'Crispy fries smothered in melted cheddar cheese.', 80.00, 1, 'fries.jpg'),
(3, 1, 'Onion Rings', 'Golden crispy battered onion rings.', 90.00, 1, 'onion_rings.jpg'),
(4, 1, 'Coke', 'Refreshing chilled Coca-Cola.', 40.00, 1, 'coke.jpg'),

-- Restaurant 2: Pizza Corner
(5, 2, 'Margherita Pizza', 'Simple classic pizza with fresh mozzarella and basil.', 250.00, 1, 'pizza.jpg'),
(6, 2, 'Pepperoni Feast', 'Loaded with double pepperoni and extra mozzarella.', 350.00, 1, 'pepperoni.jpg'),
(7, 2, 'Garlic Breadsticks', 'Baked fresh breadsticks seasoned with garlic butter.', 110.00, 1, 'garlic_bread.jpg'),

-- Restaurant 3: Biryani House
(8, 3, 'Chicken Biryani', 'Fragrant basmati rice cooked with spiced chicken and herbs.', 180.00, 1, 'biryani.jpg'),
(9, 3, 'Mutton Biryani', 'Royal spiced rice cooked tender mutton pieces.', 240.00, 1, 'mutton_biryani.jpg'),
(10, 3, 'Veg Biryani', 'Flavourful basmati rice layered with mixed vegetables.', 150.00, 1, 'veg_biryani.jpg'),
(11, 3, 'Sweet Lassi', 'Cooling traditional sweet yogurt drink.', 50.00, 1, 'lassi.jpg'),

-- Restaurant 4: Chinese Bowl
(12, 4, 'Veg Hakka Noodles', 'Stir-fried noodles with crisp vegetables and soy sauce.', 130.00, 1, 'noodles.jpg'),
(13, 4, 'Chicken Manchurian', 'Spiced chicken chunks tossed in tangy manchurian gravy.', 160.00, 1, 'manchurian.jpg'),
(14, 4, 'Spring Rolls', 'Crispy wrapper rolls filled with seasoned vegetables.', 90.00, 1, 'spring_rolls.jpg'),

-- Restaurant 5: Tandoori Treat
(15, 5, 'Tandoori Chicken', 'Chicken marinated in yogurt and spices, roasted in clay oven.', 220.00, 1, 'tandoori_chicken.jpg'),
(16, 5, 'Butter Chicken Curry', 'Tender tandoori chicken cooked in rich buttery tomato gravy.', 240.00, 1, 'butter_chicken.jpg'),
(17, 5, 'Garlic Naan', 'Leavened flatbread topped with garlic and butter.', 45.00, 1, 'garlic_naan.jpg'),

-- Restaurant 6: Cafe Delight
(18, 6, 'Filter Coffee', 'Traditional South Indian frothy milk coffee.', 40.00, 1, 'coffee.jpg'),
(19, 6, 'Club Sandwich', 'Toasted sandwich with layers of cheese, lettuce, and veggies.', 95.00, 1, 'sandwich.jpg'),
(20, 6, 'Chocolate Muffin', 'Soft muffin loaded with chocolate chips.', 70.00, 1, 'muffin.jpg'),

-- Restaurant 7: South Indian Delights
(21, 7, 'Masala Dosa', 'Thin crispy rice crepe stuffed with spiced potato mash.', 80.00, 1, 'dosa.jpg'),
(22, 7, 'Idli Sambar (2 Pcs)', 'Steamed soft rice cakes served with hot sambar and chutney.', 50.00, 1, 'idli.jpg'),
(23, 7, 'Medu Vada (2 Pcs)', 'Crispy deep-fried savory lentil donuts.', 60.00, 1, 'vada.jpg'),
(24, 7, 'Filter Coffee Extra frothy', 'Traditional aromatic south Indian filter coffee.', 45.00, 1, 'coffee.jpg'),

-- Restaurant 8: Sweet Oasis
(225, 8, 'Chocolate Fudge Cake', 'Rich layers of chocolate sponge cake and fudge frosting.', 130.00, 1, 'chocolate_cake.jpg'),
(26, 8, 'Red Velvet Pastry', 'Decadent red velvet slice with cream cheese frosting.', 90.00, 1, 'pastry.jpg'),
(27, 8, 'Gulab Jamun (2 Pcs)', 'Soft milk-solid balls soaked in warm sugar syrup.', 60.00, 1, 'gulab_jamun.jpg'),

-- Restaurant 9: Kathi Roll Express
(28, 9, 'Double Chicken Roll', 'Flaky paratha wrap stuffed with double spiced chicken chunks.', 140.00, 1, 'chicken_roll.jpg'),
(29, 9, 'Paneer Tikka Roll', 'Delicious roll with grilled paneer tikka and mint sauce.', 110.00, 1, 'paneer_roll.jpg'),
(30, 9, 'Egg Roll', 'Classic egg-layered paratha wrap with onions and lime.', 70.00, 1, 'egg_roll.jpg'),

-- Restaurant 10: Noodle & Sushi House
(31, 10, 'Veg Sushi Roll (6 Pcs)', 'Sushi rolls filled with cucumber, avocado, and pickled radish.', 280.00, 1, 'sushi.jpg'),
(32, 10, 'Chicken Hakka Noodles', 'Wok-tossed noodles with chicken strips and veggies.', 150.00, 1, 'chicken_noodles.jpg'),
(33, 10, 'Fried Dumplings (6 Pcs)', 'Pan-fried chicken or veg dumplings with dip.', 120.00, 1, 'dumplings.jpg'),

-- Restaurant 11: Punjabi Rasoi
(34, 11, 'Paneer Butter Masala', 'Cottage cheese cubes in rich creamy tomato cashew gravy.', 200.00, 1, 'paneer_butter.jpg'),
(35, 11, 'Dal Makhani', 'Slow-cooked black lentils in creamy butter and cream.', 185.00, 1, 'dal_makhani.jpg'),
(36, 11, 'Butter Naan', 'Soft clay oven flatbread glazed with butter.', 40.00, 1, 'butter_naan.jpg'),

-- Restaurant 12: Burger Junction
(37, 12, 'Crispy Chicken Burger', 'Crispy chicken patty with mayonnaise and pickles.', 130.00, 1, 'chicken_burger.jpg'),
(38, 12, 'Spicy Paneer Burger', 'Spicy battered cottage cheese slab with chili mayo.', 115.00, 1, 'paneer_burger.jpg'),
(39, 12, 'French Fries Large', 'Golden salted potato fries served with ketchup.', 90.00, 1, 'fries.jpg')
ON DUPLICATE KEY UPDATE name=VALUES(name), price=VALUES(price), description=VALUES(description);
