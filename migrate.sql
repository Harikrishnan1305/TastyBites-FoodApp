-- Safe Migration Script
-- Run this in MySQL Workbench or MySQL command line

USE food_delivery_application;

-- 1. Add phone to User table
ALTER TABLE `User` ADD COLUMN phone VARCHAR(20) AFTER email;

-- 2. Add image_url to Restaurant table
ALTER TABLE `Restaurant` ADD COLUMN image_url VARCHAR(255) AFTER address;
ALTER TABLE `Restaurant` ADD COLUMN min_order DOUBLE DEFAULT 0.0 AFTER image_url;

-- 3. Add category to Menu table
ALTER TABLE `Menu` ADD COLUMN category VARCHAR(100) AFTER description;

-- 4. Add delivery columns to Order table
ALTER TABLE `Order` ADD COLUMN delivery_address VARCHAR(500) AFTER status;
ALTER TABLE `Order` ADD COLUMN delivery_partner_id INT DEFAULT 0 AFTER delivery_address;
ALTER TABLE `Order` ADD COLUMN estimated_time VARCHAR(50) AFTER delivery_partner_id;

-- 5. Create Payment table
CREATE TABLE IF NOT EXISTS `Payment` (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DOUBLE NOT NULL,
    method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(100),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE
);

SELECT 'Migration completed successfully!' AS Result;
