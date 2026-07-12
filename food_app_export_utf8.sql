-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: food_app
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `id` int NOT NULL,
  `e_name` varchar(10) DEFAULT NULL,
  `e_email` varchar(20) DEFAULT NULL,
  `e_phone` int DEFAULT NULL,
  `e_address` varchar(20) DEFAULT NULL,
  `e_salary` int DEFAULT NULL,
  `e_salaryy` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES (1,'praveen','kumar@gmail.com',93452,NULL,NULL,11000),(2,'sarath','sarath@gmail.com',1239,NULL,NULL,15000);
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_customer`
--

DROP TABLE IF EXISTS `m_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_customer` (
  `id` int DEFAULT NULL,
  `orders` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_customer`
--

LOCK TABLES `m_customer` WRITE;
/*!40000 ALTER TABLE `m_customer` DISABLE KEYS */;
INSERT INTO `m_customer` VALUES (1,'Yes'),(2,'No'),(3,'yes');
/*!40000 ALTER TABLE `m_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Classic Burger','Juicy beef patty with lettuce, tomato, and cheese.',120.00,1,'burger.jpg'),(2,1,'Cheese Fries','Crispy fries smothered in melted cheddar cheese.',80.00,1,'fries.jpg'),(3,2,'Onion Rings','Golden crispy battered onion rings.',90.00,1,'pizza.jpg'),(4,3,'Coke','Refreshing chilled Coca-Cola.',40.00,1,'biryani.jpg'),(5,2,'Margherita Pizza','Simple classic pizza with fresh mozzarella and basil.',250.00,1,'pizza.jpg'),(6,2,'Pepperoni Feast','Loaded with double pepperoni and extra mozzarella.',350.00,1,'pepperoni.jpg'),(7,2,'Garlic Breadsticks','Baked fresh breadsticks seasoned with garlic butter.',110.00,1,'garlic_bread.jpg'),(8,3,'Chicken Biryani','Fragrant basmati rice cooked with spiced chicken and herbs.',180.00,1,'biryani.jpg'),(9,3,'Mutton Biryani','Royal spiced rice cooked tender mutton pieces.',240.00,1,'mutton_biryani.jpg'),(10,3,'Veg Biryani','Flavourful basmati rice layered with mixed vegetables.',150.00,1,'veg_biryani.jpg'),(11,3,'Sweet Lassi','Cooling traditional sweet yogurt drink.',50.00,1,'lassi.jpg'),(12,4,'Veg Hakka Noodles','Stir-fried noodles with crisp vegetables and soy sauce.',130.00,1,'noodles.jpg'),(13,4,'Chicken Manchurian','Spiced chicken chunks tossed in tangy manchurian gravy.',160.00,1,'manchurian.jpg'),(14,4,'Spring Rolls','Crispy wrapper rolls filled with seasoned vegetables.',90.00,1,'spring_rolls.jpg'),(15,5,'Tandoori Chicken','Chicken marinated in yogurt and spices, roasted in clay oven.',220.00,1,'tandoori_chicken.jpg'),(16,5,'Butter Chicken Curry','Tender tandoori chicken cooked in rich buttery tomato gravy.',240.00,1,'butter_chicken.jpg'),(17,5,'Garlic Naan','Leavened flatbread topped with garlic and butter.',45.00,1,'garlic_naan.jpg'),(18,6,'Filter Coffee','Traditional South Indian frothy milk coffee.',40.00,1,'coffee.jpg'),(19,6,'Club Sandwich','Toasted sandwich with layers of cheese, lettuce, and veggies.',95.00,1,'sandwich.jpg'),(20,6,'Chocolate Muffin','Soft muffin loaded with chocolate chips.',70.00,1,'muffin.jpg'),(21,7,'Masala Dosa','Thin crispy rice crepe stuffed with spiced potato mash.',80.00,1,'dosa.jpg'),(22,7,'Idli Sambar (2 Pcs)','Steamed soft rice cakes served with hot sambar and chutney.',50.00,1,'idli.jpg'),(23,7,'Medu Vada (2 Pcs)','Crispy deep-fried savory lentil donuts.',60.00,1,'vada.jpg'),(24,7,'Filter Coffee Extra frothy','Traditional aromatic south Indian filter coffee.',45.00,1,'coffee.jpg'),(26,8,'Red Velvet Pastry','Decadent red velvet slice with cream cheese frosting.',90.00,1,'pastry.jpg'),(27,8,'Gulab Jamun (2 Pcs)','Soft milk-solid balls soaked in warm sugar syrup.',60.00,1,'gulab_jamun.jpg'),(28,9,'Double Chicken Roll','Flaky paratha wrap stuffed with double spiced chicken chunks.',140.00,1,'chicken_roll.jpg'),(29,9,'Paneer Tikka Roll','Delicious roll with grilled paneer tikka and mint sauce.',110.00,1,'paneer_roll.jpg'),(30,9,'Egg Roll','Classic egg-layered paratha wrap with onions and lime.',70.00,1,'egg_roll.jpg'),(31,10,'Veg Sushi Roll (6 Pcs)','Sushi rolls filled with cucumber, avocado, and pickled radish.',280.00,1,'sushi.jpg'),(32,10,'Chicken Hakka Noodles','Wok-tossed noodles with chicken strips and veggies.',150.00,1,'chicken_noodles.jpg'),(33,10,'Fried Dumplings (6 Pcs)','Pan-fried chicken or veg dumplings with dip.',120.00,1,'dumplings.jpg'),(34,11,'Paneer Butter Masala','Cottage cheese cubes in rich creamy tomato cashew gravy.',200.00,1,'paneer_butter.jpg'),(35,11,'Dal Makhani','Slow-cooked black lentils in creamy butter and cream.',185.00,1,'dal_makhani.jpg'),(36,11,'Butter Naan','Soft clay oven flatbread glazed with butter.',40.00,1,'butter_naan.jpg'),(37,12,'Crispy Chicken Burger','Crispy chicken patty with mayonnaise and pickles.',130.00,1,'chicken_burger.jpg'),(38,12,'Spicy Paneer Burger','Spicy battered cottage cheese slab with chili mayo.',115.00,1,'paneer_burger.jpg'),(39,12,'French Fries Large','Golden salted potato fries served with ketchup.',90.00,1,'fries.jpg'),(225,8,'Chocolate Fudge Cake','Rich layers of chocolate sponge cake and fudge frosting.',130.00,1,'chocolate_cake.jpg');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `menu_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'Classic Burger',5,120.00),(2,2,1,'Classic Burger',4,120.00),(3,3,4,'Chicken Biryani',3,180.00),(4,4,3,'Onion Rings',3,90.00),(5,4,21,'Masala Dosa',1,80.00),(6,4,6,'Pepperoni Feast',1,350.00),(7,4,7,'Garlic Breadsticks',1,110.00),(8,5,3,'Onion Rings',3,90.00),(9,5,5,'Margherita Pizza',1,250.00),(10,5,8,'Chicken Biryani',5,180.00),(11,5,9,'Mutton Biryani',1,240.00),(12,5,12,'Veg Hakka Noodles',1,130.00),(13,6,34,'Paneer Butter Masala',1,200.00),(14,6,8,'Chicken Biryani',2,180.00),(15,6,9,'Mutton Biryani',1,240.00),(16,6,10,'Veg Biryani',3,150.00),(17,7,18,'Filter Coffee',4,40.00),(18,7,19,'Club Sandwich',1,95.00),(19,7,20,'Chocolate Muffin',1,70.00),(20,8,1,'Classic Burger',2,120.00),(21,8,2,'Cheese Fries',2,80.00),(22,9,3,'Onion Rings',3,90.00),(23,9,5,'Margherita Pizza',2,250.00),(24,10,4,'Coke',3,40.00),(25,10,21,'Masala Dosa',1,80.00),(26,10,22,'Idli Sambar (2 Pcs)',2,50.00),(27,10,8,'Chicken Biryani',2,180.00),(28,10,9,'Mutton Biryani',1,240.00),(29,11,12,'Veg Hakka Noodles',4,130.00),(30,12,3,'Onion Rings',2,90.00),(31,12,5,'Margherita Pizza',2,250.00),(32,13,34,'Paneer Butter Masala',1,200.00),(33,13,4,'Coke',1,40.00),(34,13,8,'Chicken Biryani',1,180.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `payment_mode` varchar(50) DEFAULT 'COD',
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,4,1,'2026-06-25 08:02:27',600.00,'Pending','UPI'),(2,4,1,'2026-06-25 08:06:59',480.00,'Pending','COD'),(3,4,3,'2026-06-25 08:08:15',540.00,'Pending','Card'),(4,4,2,'2026-06-25 08:17:54',810.00,'Pending','UPI'),(5,4,4,'2026-06-25 08:28:59',1790.00,'Pending','COD'),(6,4,3,'2026-06-25 08:34:48',1250.00,'Pending','COD'),(7,4,6,'2026-06-25 08:40:49',325.00,'Pending','COD'),(8,4,1,'2026-06-25 08:46:12',400.00,'Pending','COD'),(9,5,2,'2026-06-26 04:46:56',770.00,'Pending','COD'),(10,5,3,'2026-06-26 04:53:05',900.00,'Pending','COD'),(11,5,4,'2026-06-26 04:54:14',520.00,'Pending','COD'),(12,4,2,'2026-07-02 12:47:03',680.00,'Pending','COD'),(13,4,3,'2026-07-02 12:59:26',420.00,'Pending','UPI');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `praveen`
--

DROP TABLE IF EXISTS `praveen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `praveen` (
  `e_id` int DEFAULT NULL,
  `e_name` varchar(10) DEFAULT NULL,
  `e_mail` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `praveen`
--

LOCK TABLES `praveen` WRITE;
/*!40000 ALTER TABLE `praveen` DISABLE KEYS */;
INSERT INTO `praveen` VALUES (1,'Praveen','praveen@gmal.com'),(2,'sarath','sarath@gamil.com'),(3,'sithej','kumara@gmail.com'),(3,'sithej','kumara@gmail.com'),(4,'Mallika','mallika@gmail.com');
/*!40000 ALTER TABLE `praveen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `cuisine_type` varchar(100) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `eta` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Burger Palace','Burgers, Fast Food',4.5,'Electronic City, Bangalore',25,'burgerpalace@food.com','password'),(2,'Pizza Corner','Pizza, Italian',4.3,'Koramangala',30,'pizzacorner@food.com','password'),(3,'Biryani House','Biryani, South Indian',4.7,'HSR Layout',35,'biryanihouse@food.com','password'),(4,'Chinese Bowl','Chinese, Noodles',4.2,'BTM Layout',20,'chinesebowl@food.com','password'),(5,'Tandoori Treat','North Indian',4.6,'Whitefield',28,'tandooritreat@food.com','password'),(6,'Cafe Delight','Coffee, Snacks',4.4,'Indiranagar',18,'cafedelight@food.com','password'),(7,'South Indian Delights','South Indian',4.8,'Jayanagar, Bangalore',15,'southdelights@food.com','password'),(8,'Sweet Oasis','Desserts, Cakes',4.5,'Malleshwaram',22,'sweetoasis@food.com','password'),(9,'Kathi Roll Express','Rolls, Fast Food',4.1,'BTM Layout',19,'rollexpress@food.com','password'),(10,'Noodle & Sushi House','Chinese, Japanese',4.4,'Koramangala',26,'noodlesushi@food.com','password'),(11,'Punjabi Rasoi','North Indian, Mughlai',4.7,'Marathahalli',32,'punjabirasoi@food.com','password'),(12,'Burger Junction','Burgers, Fast Food',4.3,'HSR Layout',21,'burgerjunction@food.com','password');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test User','test@user.com','password'),(2,'PRAVEEN R','praveenraj052005@gmail.com','praveen@2005'),(4,'praveen','praveen@gmail.com','123'),(5,'sarath','sarath@gmail.com','123'),(6,'Tester','tester@test.com','test');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-04 18:47:24
