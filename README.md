<div align="center">

# 🍔 TastyBites — Premium Food Delivery Platform

### A full-stack, enterprise-grade food delivery web application built with Java EE

[![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com)
[![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-Servlets_%26_JSP-3178C6?style=for-the-badge&logo=eclipse&logoColor=white)](https://jakarta.ee/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Tomcat](https://img.shields.io/badge/Apache_Tomcat-10.1-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)](https://tomcat.apache.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-Modern_UI-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)

**[🌐 View Live Demo](#)** &nbsp;·&nbsp; **[📂 Repository](https://github.com/Harikrishnan1305/TastyBites-FoodApp)** &nbsp;·&nbsp; **[🐛 Report Bug](https://github.com/Harikrishnan1305/TastyBites-FoodApp/issues)**

</div>

---

## 📌 About The Project

**TastyBites** is a production-ready, Zomato/Swiggy-inspired food delivery platform developed entirely using **core Java EE technologies** — no Spring, no shortcuts. This project demonstrates deep expertise in Java backend development, MVC architecture, DAO design patterns, secure database management, and building pixel-perfect, responsive UIs.

The application supports **three distinct user roles**, a complete **order lifecycle**, a **mock payment gateway**, and a **real-time delivery tracking** system — reflecting real-world software complexity.

---

## ✨ Key Features

### 👤 Customer Experience
- 🏠 **Zomato-like Landing Page** — Food categories, top restaurant cards, promo banners, fully responsive
- 🔐 **Secure Auth** — Register & Login with session-based authentication
- 🏪 **Restaurant Discovery** — Browse 9 restaurants (South Indian, Biryani, Chettinad, Italian) with ratings & delivery time
- 🍽️ **Dynamic Menu** — Food items with real images, category filters, live pricing
- 🛒 **Smart Cart** — Add/remove items, real-time quantity updates, persistent session cart
- 💳 **Mock Payment Gateway** — Simulated payment with Credit Card / UPI / Cash on Delivery options
- 📦 **Order Tracking** — Live status updates (Pending → Preparing → Out for Delivery → Delivered)
- 📜 **Order History** — Complete history of past orders with timestamps

### 🏪 Restaurant Owner Dashboard
- ➕ Add / Edit / Delete food items with photo support
- 📊 Manage incoming orders and update order status

### 🛵 Delivery Partner Dashboard
- 📋 View available delivery assignments
- ✅ Update delivery status (Picked Up → On the Way → Delivered)

---

## 🏗️ Architecture & Tech Stack

```
┌───────────────────────────────────────────────────────────────────┐
│                         BROWSER (Client)                          │
│              HTML5 · CSS3 · Tailwind · JavaScript                 │
└──────────────────────────┬────────────────────────────────────────┘
                           │  HTTP Request/Response
┌──────────────────────────▼────────────────────────────────────────┐
│                  Apache Tomcat 10.1 (Server)                      │
│  ┌────────────────────────────────────────────────────────────┐   │
│  │              CONTROLLER — Java Servlets                    │   │
│  │  LoginServlet · HomeServlet · CartServlet · OrderServlet   │   │
│  │  PaymentServlet · MenuServlet · DashboardServlet · ...     │   │
│  └───────────────────┬────────────────────────────────────────┘   │
│  ┌────────────────────▼───────────────────────────────────────┐   │
│  │              MODEL — DAOs + POJO Models                    │   │
│  │  UserDAO · RestaurantDAO · MenuDAO · OrderDAO · PaymentDAO │   │
│  └───────────────────┬────────────────────────────────────────┘   │
│  ┌────────────────────▼───────────────────────────────────────┐   │
│  │              VIEW — JSP Pages                              │   │
│  │  index.jsp · home.jsp · menu.jsp · cart.jsp · checkout.jsp │   │
│  └────────────────────────────────────────────────────────────┘   │
└──────────────────────────┬────────────────────────────────────────┘
                           │  JDBC
┌──────────────────────────▼────────────────────────────────────────┐
│                  MySQL 8.0 Database                               │
│    user · restaurant · menu · `order` · orderitem · payment       │
└───────────────────────────────────────────────────────────────────┘
```

| Layer | Technology |
|-------|-----------|
| **Language** | Java 17 |
| **Backend** | Jakarta Servlets, JSP (Jakarta EE) |
| **Frontend** | HTML5, CSS3, Tailwind CSS, JavaScript, Font Awesome |
| **Database** | MySQL 8.0 via JDBC |
| **Server** | Apache Tomcat 10.1 |
| **Design Pattern** | MVC + DAO (Data Access Object) |
| **Security** | PreparedStatements (SQL Injection prevention), credential isolation via `.properties` files |

---

## 🛡️ Security Practices

| Practice | Implementation |
|----------|---------------|
| **SQL Injection Prevention** | 100% `PreparedStatement` usage across all 5 DAO layers |
| **Credential Security** | DB password isolated in `db.properties` (git-ignored, never hardcoded) |
| **Session Management** | Server-side session validation on every protected servlet |
| **Safe DB Connections** | `try-with-resources` pattern preventing JDBC connection leaks |

---

## 🗄️ Database Schema

```sql
food_delivery_application
├── user         (user_id, username, email, password, phone, address, role)
├── restaurant   (restaurant_id, name, cuisine_type, ratings, address, image_url, is_active)
├── menu         (menu_id, restaurant_id, menu_name, description, price, category, image_url)
├── `order`      (order_id, user_id, restaurant_id, total_amount, status, delivery_address, payment_method)
├── orderitem    (order_item_id, order_id, menu_id, quantity, price)
└── payment      (payment_id, order_id, amount, method, status, transaction_id)
```

---

## 🚀 Local Setup Guide

### Prerequisites
- Java JDK 17+
- Apache Tomcat 10.1
- MySQL Server 8.0
- Eclipse IDE for Enterprise Java Developers

### Step 1 — Clone the Repository
```bash
git clone https://github.com/Harikrishnan1305/TastyBites-FoodApp.git
cd TastyBites-FoodApp
```

### Step 2 — Database Setup
```bash
# Create the database and tables
mysql -u root -p < database_setup.sql

# Populate sample South Indian restaurants & menu items
mysql -u root -p food_delivery_application < update_restaurants.sql
```

### Step 3 — Configure Credentials (Secure Setup)
```bash
# Copy the example file
cp src/main/java/db.properties.example src/main/java/db.properties
```
Then open `db.properties` and set your MySQL password:
```properties
db.url=jdbc:mysql://localhost:3306/food_delivery_application?useSSL=false&serverTimezone=UTC
db.username=root
db.password=YOUR_MYSQL_PASSWORD_HERE
db.driver=com.mysql.cj.jdbc.Driver
```
> ⚠️ `db.properties` is listed in `.gitignore` — your password will **never** be pushed to GitHub.

### Step 4 — Import & Run in Eclipse
1. `File → Import → Existing Projects into Workspace`
2. Select the cloned folder → Finish
3. Right-click Project → `Build Path → Configure Build Path` → Add Tomcat 10.1 library
4. Right-click Project → `Run As → Run on Server`

### Step 5 — Access the App
```
http://localhost:8080/FoodDeliveryApp/
```

---

## 📁 Project Structure

```
FoodDeliveryApp/
├── src/main/
│   ├── java/
│   │   ├── com/tap/
│   │   │   ├── dao/              # DAO Interfaces
│   │   │   │   └── impl/         # DAO Implementations (JDBC)
│   │   │   ├── model/            # POJO Models (User, Restaurant, Menu, Order...)
│   │   │   ├── servlet/          # 14 Servlet Controllers
│   │   │   └── utility/          # DBConnection utility
│   │   └── db.properties.example # Safe credentials template
│   └── webapp/
│       ├── CSS/style.css         # Global design system
│       ├── images/               # Restaurant & food images
│       ├── WEB-INF/web.xml       # Servlet mappings
│       ├── index.jsp             # 🌟 Zomato-like Landing Page
│       ├── home.jsp              # Restaurant listing
│       ├── menu.jsp              # Dynamic food menu
│       ├── cart.jsp              # Shopping cart
│       ├── checkout.jsp          # Order placement
│       ├── payment.jsp           # Mock payment gateway
│       ├── order-history.jsp     # Order tracking
│       ├── restaurant-dashboard.jsp
│       └── delivery-dashboard.jsp
├── database_setup.sql            # Schema creation script
├── update_restaurants.sql        # Sample South Indian data
└── README.md
```

---

## 🗺️ Application Flow

```
Landing Page (index.jsp)
        │
   ┌────┴────┐
Register    Login
        │
   Dashboard (role-based redirect)
        │
   ┌────┼──────────────┐
Customer  Restaurant   Delivery
   │       Owner       Partner
   │
Home → Menu → Cart → Checkout → Payment → Order Confirmation
                                              │
                                         Order History / Tracking
```

---

## 👨‍💻 Author

<div align="center">

**Harikrishnan**

*Java Full-Stack Developer | Chennai, Tamil Nadu*

[![GitHub](https://img.shields.io/badge/GitHub-Harikrishnan1305-181717?style=for-the-badge&logo=github)](https://github.com/Harikrishnan1305)

*Open to IT opportunities — Feel free to connect!*

</div>

---

<div align="center">

⭐ **If this project impressed you, please give it a star!** ⭐

*Built with ❤️ using Core Java — No frameworks, no shortcuts.*

</div>
