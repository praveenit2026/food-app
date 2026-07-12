-- ============================================================
--  FoodieHub - PostgreSQL Migration (Supabase)
--  Converted from MySQL dump dated 2026-07-04
-- ============================================================

-- Drop tables in reverse FK order
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders      CASCADE;
DROP TABLE IF EXISTS cart_items  CASCADE;
DROP TABLE IF EXISTS cart        CASCADE;
DROP TABLE IF EXISTS menu        CASCADE;
DROP TABLE IF EXISTS restaurant  CASCADE;
DROP TABLE IF EXISTS users       CASCADE;

-- ── users ────────────────────────────────────────────────────
CREATE TABLE users (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(100) NOT NULL,
  email    VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL
);

INSERT INTO users (id, name, email, password) VALUES
  (1, 'Test User',    'test@user.com',               'password'),
  (2, 'PRAVEEN R',    'praveenraj052005@gmail.com',   'praveen@2005'),
  (4, 'praveen',      'praveen@gmail.com',            '123'),
  (5, 'sarath',       'sarath@gmail.com',             '123'),
  (6, 'Tester',       'tester@test.com',              'test');

SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));

-- ── restaurant ───────────────────────────────────────────────
CREATE TABLE restaurant (
  restaurant_id SERIAL PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  cuisine_type  VARCHAR(100),
  rating        FLOAT,
  address       VARCHAR(255),
  eta           INT,
  email         VARCHAR(100) UNIQUE,
  password      VARCHAR(100)
);

INSERT INTO restaurant (restaurant_id, name, cuisine_type, rating, address, eta, email, password) VALUES
  (1,  'Burger Palace',         'Burgers, Fast Food',    4.5, 'Electronic City, Bangalore', 25, 'burgerpalace@food.com',  'password'),
  (2,  'Pizza Corner',          'Pizza, Italian',        4.3, 'Koramangala',                30, 'pizzacorner@food.com',   'password'),
  (3,  'Biryani House',         'Biryani, South Indian', 4.7, 'HSR Layout',                 35, 'biryanihouse@food.com',  'password'),
  (4,  'Chinese Bowl',          'Chinese, Noodles',      4.2, 'BTM Layout',                 20, 'chinesebowl@food.com',   'password'),
  (5,  'Tandoori Treat',        'North Indian',          4.6, 'Whitefield',                 28, 'tandooritreat@food.com', 'password'),
  (6,  'Cafe Delight',          'Coffee, Snacks',        4.4, 'Indiranagar',                18, 'cafedelight@food.com',   'password'),
  (7,  'South Indian Delights', 'South Indian',          4.8, 'Jayanagar, Bangalore',       15, 'southdelights@food.com', 'password'),
  (8,  'Sweet Oasis',           'Desserts, Cakes',       4.5, 'Malleshwaram',               22, 'sweetoasis@food.com',    'password'),
  (9,  'Kathi Roll Express',    'Rolls, Fast Food',      4.1, 'BTM Layout',                 19, 'rollexpress@food.com',   'password'),
  (10, 'Noodle & Sushi House',  'Chinese, Japanese',     4.4, 'Koramangala',                26, 'noodlesushi@food.com',   'password'),
  (11, 'Punjabi Rasoi',         'North Indian, Mughlai', 4.7, 'Marathahalli',               32, 'punjabirasoi@food.com',  'password'),
  (12, 'Burger Junction',       'Burgers, Fast Food',    4.3, 'HSR Layout',                 21, 'burgerjunction@food.com','password');

SELECT setval('restaurant_restaurant_id_seq', (SELECT MAX(restaurant_id) FROM restaurant));

-- ── menu ─────────────────────────────────────────────────────
CREATE TABLE menu (
  menu_id       SERIAL PRIMARY KEY,
  restaurant_id INT REFERENCES restaurant(restaurant_id) ON DELETE CASCADE,
  name          VARCHAR(100) NOT NULL,
  description   TEXT,
  price         DECIMAL(10,2) NOT NULL,
  category      VARCHAR(50),
  image_path    VARCHAR(255),
  is_available  BOOLEAN DEFAULT TRUE
);

INSERT INTO menu (menu_id, restaurant_id, name, description, price, category, image_path, is_available) VALUES
  (1,  1,  'Classic Burger',        'Juicy beef patty with lettuce and tomato',       120.00, 'Main Course', NULL, TRUE),
  (2,  1,  'Cheese Fries',          'Crispy fries loaded with melted cheese',          80.00, 'Sides',       NULL, TRUE),
  (3,  1,  'Onion Rings',           'Golden fried onion rings with dipping sauce',     90.00, 'Sides',       NULL, TRUE),
  (4,  1,  'Coke',                  'Chilled Coca-Cola 300ml',                         40.00, 'Beverages',   NULL, TRUE),
  (5,  2,  'Margherita Pizza',      'Classic tomato and mozzarella pizza',            250.00, 'Main Course', NULL, TRUE),
  (6,  2,  'Pepperoni Feast',       'Loaded pepperoni with extra cheese',             350.00, 'Main Course', NULL, TRUE),
  (7,  2,  'Garlic Breadsticks',    'Oven-baked breadsticks with garlic butter',      110.00, 'Sides',       NULL, TRUE),
  (8,  3,  'Chicken Biryani',       'Aromatic basmati rice with tender chicken',      180.00, 'Main Course', NULL, TRUE),
  (9,  3,  'Mutton Biryani',        'Slow-cooked mutton biryani with raita',          240.00, 'Main Course', NULL, TRUE),
  (10, 3,  'Veg Biryani',           'Fragrant biryani with seasonal vegetables',      150.00, 'Main Course', NULL, TRUE),
  (11, 3,  'Raita',                 'Cool yogurt with cucumber and spices',            40.00, 'Sides',       NULL, TRUE),
  (12, 4,  'Veg Hakka Noodles',     'Stir-fried noodles with vegetables',             130.00, 'Main Course', NULL, TRUE),
  (13, 4,  'Chicken Fried Rice',    'Classic fried rice with egg and chicken',        150.00, 'Main Course', NULL, TRUE),
  (14, 4,  'Manchurian',            'Deep-fried balls in spicy Manchurian sauce',     140.00, 'Starters',    NULL, TRUE),
  (15, 5,  'Butter Chicken',        'Creamy tomato-based chicken curry',              220.00, 'Main Course', NULL, TRUE),
  (16, 5,  'Garlic Naan',           'Soft naan bread with garlic butter',              50.00, 'Bread',       NULL, TRUE),
  (17, 5,  'Lassi',                 'Chilled yogurt drink - sweet or salted',          60.00, 'Beverages',   NULL, TRUE),
  (18, 6,  'Filter Coffee',         'South Indian filter coffee with froth',           40.00, 'Beverages',   NULL, TRUE),
  (19, 6,  'Club Sandwich',         'Multi-layered sandwich with veggies and cheese',  95.00, 'Snacks',      NULL, TRUE),
  (20, 6,  'Chocolate Muffin',      'Freshly baked chocolate muffin',                  70.00, 'Desserts',    NULL, TRUE),
  (21, 7,  'Masala Dosa',           'Crispy dosa with spiced potato filling',          80.00, 'Main Course', NULL, TRUE),
  (22, 7,  'Idli Sambar (2 Pcs)',   'Soft idlis served with sambar and chutney',       50.00, 'Main Course', NULL, TRUE),
  (23, 7,  'Vada',                  'Crispy lentil doughnut with sambar',              45.00, 'Snacks',      NULL, TRUE),
  (24, 8,  'Gulab Jamun (2 Pcs)',   'Soft milk-solid balls soaked in sugar syrup',     60.00, 'Desserts',    NULL, TRUE),
  (25, 8,  'Chocolate Cake Slice',  'Rich moist chocolate cake',                      120.00, 'Desserts',    NULL, TRUE),
  (26, 8,  'Fruit Custard',         'Mixed fruit custard with cream',                   80.00, 'Desserts',    NULL, TRUE),
  (27, 9,  'Paneer Kathi Roll',     'Spicy paneer filling in a flaky paratha roll',   110.00, 'Main Course', NULL, TRUE),
  (28, 9,  'Chicken Kathi Roll',    'Marinated chicken wrapped in a soft roll',       130.00, 'Main Course', NULL, TRUE),
  (29, 10, 'Dragon Roll (Sushi)',   'Spicy tuna and avocado sushi roll',              280.00, 'Japanese',    NULL, TRUE),
  (30, 10, 'Chicken Ramen',         'Japanese noodle soup with soft-boiled egg',      220.00, 'Japanese',    NULL, TRUE),
  (31, 11, 'Dal Makhani',           'Creamy black lentils cooked overnight',          180.00, 'Main Course', NULL, TRUE),
  (32, 11, 'Tandoori Chicken',      'Clay-oven roasted chicken with spices',          260.00, 'Starters',    NULL, TRUE),
  (33, 12, 'Double Smash Burger',   'Double-patty smash burger with special sauce',   180.00, 'Main Course', NULL, TRUE),
  (34, 3,  'Paneer Butter Masala',  'Rich and creamy paneer in tomato gravy',         200.00, 'Main Course', NULL, TRUE),
  (35, 12, 'Loaded Fries',          'Fries topped with cheese, jalapenos, and sauce', 110.00, 'Sides',       NULL, TRUE);

SELECT setval('menu_menu_id_seq', (SELECT MAX(menu_id) FROM menu));

-- ── cart ─────────────────────────────────────────────────────
CREATE TABLE cart (
  cart_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE
);

-- ── cart_items ───────────────────────────────────────────────
CREATE TABLE cart_items (
  cart_item_id  SERIAL PRIMARY KEY,
  cart_id       INT           REFERENCES cart(cart_id) ON DELETE CASCADE,
  menu_id       INT           REFERENCES menu(menu_id) ON DELETE CASCADE,
  quantity      INT           NOT NULL DEFAULT 1,
  price         DECIMAL(10,2) NOT NULL
);

-- ── orders ───────────────────────────────────────────────────
CREATE TABLE orders (
  order_id      SERIAL PRIMARY KEY,
  user_id       INT           REFERENCES users(id),
  restaurant_id INT           REFERENCES restaurant(restaurant_id),
  order_date    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  total_amount  DECIMAL(10,2) NOT NULL,
  status        VARCHAR(50)   DEFAULT 'Pending',
  payment_mode  VARCHAR(50)   DEFAULT 'COD'
);

INSERT INTO orders (order_id, user_id, restaurant_id, order_date, total_amount, status, payment_mode) VALUES
  (1,  4, 1, '2026-06-25 08:02:27',  600.00, 'Pending', 'UPI'),
  (2,  4, 1, '2026-06-25 08:06:59',  480.00, 'Pending', 'COD'),
  (3,  4, 3, '2026-06-25 08:08:15',  540.00, 'Pending', 'Card'),
  (4,  4, 2, '2026-06-25 08:17:54',  810.00, 'Pending', 'UPI'),
  (5,  4, 4, '2026-06-25 08:28:59', 1790.00, 'Pending', 'COD'),
  (6,  4, 3, '2026-06-25 08:34:48', 1250.00, 'Pending', 'COD'),
  (7,  4, 6, '2026-06-25 08:40:49',  325.00, 'Pending', 'COD'),
  (8,  4, 1, '2026-06-25 08:46:12',  400.00, 'Pending', 'COD'),
  (9,  5, 2, '2026-06-26 04:46:56',  770.00, 'Pending', 'COD'),
  (10, 5, 3, '2026-06-26 04:53:05',  900.00, 'Pending', 'COD'),
  (11, 5, 4, '2026-06-26 04:54:14',  520.00, 'Pending', 'COD'),
  (12, 4, 2, '2026-07-02 12:47:03',  680.00, 'Pending', 'COD'),
  (13, 4, 3, '2026-07-02 12:59:26',  420.00, 'Pending', 'UPI');

SELECT setval('orders_order_id_seq', (SELECT MAX(order_id) FROM orders));

-- ── order_items ──────────────────────────────────────────────
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id      INT           REFERENCES orders(order_id) ON DELETE CASCADE,
  menu_id       INT           REFERENCES menu(menu_id),
  name          VARCHAR(100),
  quantity      INT,
  price         DECIMAL(10,2)
);

INSERT INTO order_items (order_item_id, order_id, menu_id, name, quantity, price) VALUES
  (1,  1,  1,  'Classic Burger',       5, 120.00),
  (2,  2,  1,  'Classic Burger',       4, 120.00),
  (3,  3,  4,  'Chicken Biryani',      3, 180.00),
  (4,  4,  3,  'Onion Rings',          3,  90.00),
  (5,  4,  21, 'Masala Dosa',          1,  80.00),
  (6,  4,  6,  'Pepperoni Feast',      1, 350.00),
  (7,  4,  7,  'Garlic Breadsticks',   1, 110.00),
  (8,  5,  3,  'Onion Rings',          3,  90.00),
  (9,  5,  5,  'Margherita Pizza',     1, 250.00),
  (10, 5,  8,  'Chicken Biryani',      5, 180.00),
  (11, 5,  9,  'Mutton Biryani',       1, 240.00),
  (12, 5,  12, 'Veg Hakka Noodles',    1, 130.00),
  (13, 6,  34, 'Paneer Butter Masala', 1, 200.00),
  (14, 6,  8,  'Chicken Biryani',      2, 180.00),
  (15, 6,  9,  'Mutton Biryani',       1, 240.00),
  (16, 6,  10, 'Veg Biryani',          3, 150.00),
  (17, 7,  18, 'Filter Coffee',        4,  40.00),
  (18, 7,  19, 'Club Sandwich',        1,  95.00),
  (19, 7,  20, 'Chocolate Muffin',     1,  70.00),
  (20, 8,  1,  'Classic Burger',       2, 120.00),
  (21, 8,  2,  'Cheese Fries',         2,  80.00),
  (22, 9,  3,  'Onion Rings',          3,  90.00),
  (23, 9,  5,  'Margherita Pizza',     2, 250.00),
  (24, 10, 4,  'Coke',                 3,  40.00),
  (25, 10, 21, 'Masala Dosa',          1,  80.00),
  (26, 10, 22, 'Idli Sambar (2 Pcs)',  2,  50.00),
  (27, 10, 8,  'Chicken Biryani',      2, 180.00),
  (28, 10, 9,  'Mutton Biryani',       1, 240.00),
  (29, 11, 12, 'Veg Hakka Noodles',    4, 130.00),
  (30, 12, 3,  'Onion Rings',          2,  90.00),
  (31, 12, 5,  'Margherita Pizza',     2, 250.00),
  (32, 13, 34, 'Paneer Butter Masala', 1, 200.00),
  (33, 13, 4,  'Coke',                 1,  40.00),
  (34, 13, 8,  'Chicken Biryani',      1, 180.00);

SELECT setval('order_items_order_item_id_seq', (SELECT MAX(order_item_id) FROM order_items));
