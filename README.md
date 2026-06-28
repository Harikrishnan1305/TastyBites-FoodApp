# 🍔 TastyBites - Premium Food Delivery Platform 🍕

![Java](https://img.shields.io/badge/Java-17-orange.svg) 
![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-Servlets_&_JSP-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-Modern_UI-38B2AC.svg)
![Status](https://img.shields.io/badge/Status-Production_Ready-success.svg)

**TastyBites** is a full-stack, enterprise-grade online food delivery application built using **Java Servlets, JSP, and MySQL**. Designed with a modern, responsive UI (Zomato/Swiggy aesthetics) and a robust backend architecture, this project demonstrates real-world software engineering practices including MVC patterns, DAO design patterns, and secure database connections.

---

## 🚀 Key Features

### 👤 Customer App
*   **Secure Authentication:** User registration, login, and encrypted session management.
*   **Dynamic Restaurant Discovery:** Browse top-rated restaurants, view cuisines, ratings, and delivery estimates.
*   **Interactive Menu:** View categorised food items with high-quality images and dynamic pricing.
*   **Real-time Cart Management:** Add/remove items, update quantities, and calculate totals dynamically.
*   **Seamless Checkout & Payment:** Secure mock payment gateway integration.
*   **Order History & Tracking:** Track live order status (Pending -> Preparing -> Out for Delivery -> Delivered).

### 🛠️ Architecture & Security
*   **MVC Architecture:** Clear separation of Models, Views (JSP/Tailwind), and Controllers (Servlets).
*   **DAO Pattern:** Abstracted database access logic ensuring clean and maintainable code.
*   **Secure Configs:** Database credentials isolated using `.properties` files and ignored in version control.
*   **Connection Management:** Optimized `try-with-resources` JDBC connections to prevent memory leaks.

---

## 🛠️ Tech Stack

*   **Backend:** Java 17, Jakarta EE (Servlets, JSP)
*   **Frontend:** HTML5, CSS3, Tailwind CSS, JavaScript
*   **Database:** MySQL 8.0 (JDBC)
*   **Server:** Apache Tomcat 10.1
*   **IDE:** Eclipse IDE / VS Code

---

## 📸 Application Screenshots

*(Note: Add your actual screenshots in the `screenshots/` folder and link them here)*

| Home Page | Menu Browsing |
| :---: | :---: |
| *(Add screenshot here)* | *(Add screenshot here)* |

| Cart & Checkout | Order History |
| :---: | :---: |
| *(Add screenshot here)* | *(Add screenshot here)* |

---

## 💻 Setup & Installation Instructions

To run this project locally, follow these steps:

### 1. Prerequisites
*   Java Development Kit (JDK 17 or higher)
*   Apache Tomcat Server (v10.1+)
*   MySQL Server Workbench
*   Eclipse IDE for Enterprise Java Web Developers

### 2. Database Configuration
1. Open MySQL Workbench.
2. Create a new schema named `food_delivery_application`.
3. Import the provided SQL dump (if available) or create tables for `user`, `restaurant`, `menu`, `orders`, and `orderitem`.
4. Run `update_restaurants.sql` to populate sample South Indian restaurants and menu data.

### 3. Secure Credentials Setup
For security reasons, actual database credentials are not uploaded to GitHub.
1. Navigate to `src/main/java/`
2. Rename `db.properties.example` to `db.properties`
3. Update it with your MySQL credentials:
   ```properties
   db.url=jdbc:mysql://localhost:3306/food_delivery_application?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
   db.username=root
   db.password=YOUR_MYSQL_PASSWORD
   db.driver=com.mysql.cj.jdbc.Driver
   ```

### 4. Deploying in Eclipse
1. Go to `File > Import > Existing Projects into Workspace`.
2. Select the cloned repository folder.
3. Right-click the project -> `Properties > Java Build Path > Libraries` and ensure Apache Tomcat 10.1 library is added.
4. Right-click the project -> `Run As > Run on Server`.
5. Access the app at `http://localhost:8080/FoodDeliveryApp/`

---

## 🤝 Contact & Portfolio

Developed with ❤️ by **[Your Name]**
*   **LinkedIn:** [Your LinkedIn URL]
*   **Portfolio:** [Your Portfolio Website URL]

Feel free to reach out for collaborations or IT/Software Engineering opportunities!
