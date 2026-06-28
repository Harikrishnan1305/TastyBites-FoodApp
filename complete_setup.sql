-- ============================================================
-- COMPLETE DATABASE SETUP FOR FOOD DELIVERY APPLICATION
-- Run this entire script in MySQL Workbench
-- ============================================================

USE food_delivery_application;

-- Drop tables if exist (in correct order for foreign keys)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Payment`;
DROP TABLE IF EXISTS `OrderItem`;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS `Menu`;
DROP TABLE IF EXISTS `Restaurant`;
DROP TABLE IF EXISTS `User`;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. User Table
CREATE TABLE `User` (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    role VARCHAR(20) DEFAULT 'CUSTOMER',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login_date TIMESTAMP NULL
);

-- 2. Restaurant Table
CREATE TABLE `Restaurant` (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    cuisine_type VARCHAR(100),
    delivery_time VARCHAR(50),
    address VARCHAR(300),
    image_url VARCHAR(255),
    min_order DOUBLE DEFAULT 0.0,
    ratings DOUBLE DEFAULT 4.0,
    is_active TINYINT(1) DEFAULT 1,
    admin_user_id INT,
    FOREIGN KEY (admin_user_id) REFERENCES `User`(user_id) ON DELETE SET NULL
);

-- 3. Menu Table
CREATE TABLE `Menu` (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    menu_name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    price DOUBLE NOT NULL,
    is_available TINYINT(1) DEFAULT 1,
    image_url VARCHAR(255),
    FOREIGN KEY (restaurant_id) REFERENCES `Restaurant`(restaurant_id) ON DELETE CASCADE
);

-- 4. Order Table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    total_amount DOUBLE NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending Payment',
    delivery_address VARCHAR(500),
    delivery_partner_id INT DEFAULT 0,
    estimated_time VARCHAR(50),
    payment_method VARCHAR(50),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES `User`(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES `Restaurant`(restaurant_id) ON DELETE CASCADE
);

-- 5. OrderItem Table
CREATE TABLE `OrderItem` (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES `Menu`(menu_id) ON DELETE CASCADE
);

-- 6. Payment Table
CREATE TABLE `Payment` (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DOUBLE NOT NULL,
    method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(100),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE
);

-- ============================================================
-- SAMPLE DATA (Optional - to see restaurants on home page)
-- ============================================================

-- Sample Restaurant Owner User
INSERT INTO `User` (username, password, email, phone, address, role) VALUES
('admin_rest', 'admin123', 'admin@tastybites.com', '9876543210', 'Chennai, TN', 'RESTAURANT'),
('delivery_guy', 'delivery123', 'delivery@tastybites.com', '9876543211', 'Chennai, TN', 'DELIVERY');

-- Sample Restaurant (linked to admin_rest user_id=1)
INSERT INTO `Restaurant` (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id) VALUES
('Spice Garden', 'North Indian, Chinese', '30-40 mins', 'Anna Nagar, Chennai', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500', 149.0, 4.3, 1, 1),
('Biryani House', 'Biryani, Mughlai', '25-35 mins', 'T. Nagar, Chennai', 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500', 199.0, 4.6, 1, 1),
('Pizza Palace', 'Italian, Fast Food', '20-30 mins', 'Velachery, Chennai', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500', 99.0, 4.1, 1, 1);

-- Sample Menu Items
INSERT INTO `Menu` (restaurant_id, menu_name, description, category, price, is_available, image_url) VALUES
(1, 'Paneer Butter Masala', 'Rich creamy paneer gravy', 'Main Course', 180.0, 1, 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500'),
(1, 'Chicken Tikka Masala', 'Tandoor grilled chicken in masala', 'Main Course', 220.0, 1, 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500'),
(1, 'Garlic Naan', 'Soft fluffy garlic naan', 'Starters', 40.0, 1, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500'),
(2, 'Chicken Biryani', 'Fragrant basmati rice with chicken', 'Main Course', 250.0, 1, 'https://images.unsplash.com/photo-1563379091339-03246963d651?w=500'),
(2, 'Mutton Biryani', 'Premium mutton dum biryani', 'Main Course', 320.0, 1, 'https://images.unsplash.com/photo-1563379091339-03246963d651?w=500'),
(3, 'Margherita Pizza', 'Classic tomato and mozzarella', 'Main Course', 299.0, 1, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500'),
(3, 'Garlic Bread', 'Toasted garlic bread with herbs', 'Starters', 89.0, 1, 'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500');

SELECT 'All tables created and sample data inserted successfully!' AS Result;
