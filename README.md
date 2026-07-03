# FoodieHub - Order Food Online 🍔🍟

FoodieHub is a modern, responsive Java EE web application designed to allow users to search for local restaurants, browse menus, manage their shopping cart, and place food orders online. The project is fully containerized and configured for auto-deployment to Render.com.

---

## 🚀 Key Features

*   **Premium & Responsive Design**: A curated interface styled with modern typography (Inter font), smooth hover micro-animations, and full mobile responsiveness.
*   **Swipeable Mobile Categories**: A native-like horizontal-scrolling category layout for mobile devices.
*   **Global Search**: Instantly filter restaurants by name or cuisine type, and menu items by name or description.
*   **Live Shopping Cart**: Interactive cart state management for adjusting quantities or removing items.
*   **Checkout & Order History**: Seamless checkout workflow with payment mode selection and a dedicated order history page.
*   **Dockerized Deployment**: Multi-stage Docker build ready to run on any cloud platform supporting containers.

---

## 🛠️ Technology Stack

*   **Backend**: Java EE (Jakarta Servlets, JSP)
*   **Database**: MySQL
*   **Frontend**: HTML5, Responsive CSS (Vanilla), Google Fonts (Inter)
*   **Server**: Apache Tomcat 10.1 (JDK 17)
*   **DevOps / Deployment**: Docker, Render.com

---

## 📂 Project Structure

```
food_app/
├── src/main/java/com/food/
│   ├── DAO/             # Database access interfaces
│   ├── Servlet/         # Controllers handling requests
│   ├── filters/         # Security / Authentication filters
│   ├── implementation/  # MySQL DAO implementations
│   ├── model/           # Business entities (Cart, Menu, Restaurant, Order, User)
│   └── util/            # Connection pools & database helper utilities
├── src/main/webapp/
│   ├── WEB-INF/         # Config files (web.xml) and external libs
│   ├── cart.jsp         # Shopping cart view
│   ├── checkout.jsp     # Order details and checkout page
│   ├── login.jsp        # Sign-in page
│   ├── register.jsp     # Customer registration
│   ├── restaurants.jsp  # Core landing directory
│   ├── search_results.jsp# Search findings grid
│   └── schema.sql       # Initial database script
├── Dockerfile           # Multi-stage build script
├── render.yaml          # Infrastructure-as-code for Render.com
└── README.md            # Project documentation
```

---

## 💻 Local Setup & Development

### 1. Database Schema Initialisation
Make sure you have a running MySQL instance and run the queries defined in the schema file:
```bash
mysql -u your_user -p < src/main/webapp/schema.sql
```

### 2. Configure Database Connection
Modify the configuration parameters inside `src/main/java/com/food/util/DBConnection.java` or pass them via environment variables:
*   `MYSQLHOST`
*   `MYSQLPORT`
*   `MYSQLDATABASE`
*   `MYSQLUSER`
*   `MYSQLPASSWORD`

### 3. Build & Run locally with Docker
You can build the Docker image and launch the container using the following commands:
```bash
# Build the container image
docker build -t food-app .

# Run the container
docker run -p 8080:8080 \
  -e MYSQLHOST=host.docker.internal \
  -e MYSQLPORT=3306 \
  -e MYSQLDATABASE=foodiehub \
  -e MYSQLUSER=root \
  -e MYSQLPASSWORD=yourpassword \
  food-app
```
Once run, navigate to `http://localhost:8080` in your web browser.

---

## ☁️ Cloud Deployment (Render.com)

The project includes pre-configured settings for [Render](https://render.com) using Infrastructure-as-Code (`render.yaml`).

### Setup on Render:
1. Connect your GitHub repository to your Render.com account.
2. Render will automatically parse `render.yaml` and prompt you to set your database secrets:
   - `MYSQLHOST`
   - `MYSQLPORT`
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`
3. Click deploy. Render will build the Tomcat multi-stage Docker image and map the dynamic port environment variable automatically.

---

## 🔄 Keep-Alive (Preventing Render.com Sleep)

Render's free/starter tier spins down web services after **15 minutes of inactivity**. To prevent this, a lightweight health-check endpoint is included and should be pinged every **10 minutes** by an external cron service.

### Health Endpoint
```
GET https://foodiehub.onrender.com/health.jsp
```
Returns: `OK | FoodieHub is alive | <timestamp>` (plain text, no DB query)

### Setup with cron-job.org (Free)
1. Sign up at [cron-job.org](https://cron-job.org)
2. Click **"CREATE CRONJOB"** and fill in:
   - **Title**: `FoodieHub Keep-Alive`
   - **URL**: `https://foodiehub.onrender.com/health.jsp`
   - **Schedule**: Every `10` minutes (`*/10 * * * *`)
3. Save — the service will never sleep again. ✅
