-- Database Setup Script for Food Delivery Application Upgrade

-- Create new tables and alter existing ones

-- 1. Alter User table
ALTER TABLE `User` ADD COLUMN phone VARCHAR(20) AFTER email;

-- 2. Alter Restaurant table
ALTER TABLE `Restaurant` ADD COLUMN image_url VARCHAR(255) AFTER address;
ALTER TABLE `Restaurant` ADD COLUMN min_order DOUBLE DEFAULT 0.0 AFTER ratings;

-- 3. Alter Menu table
ALTER TABLE `Menu` ADD COLUMN category VARCHAR(100) AFTER description;

-- 4. Alter Order table
ALTER TABLE `Order` ADD COLUMN delivery_address VARCHAR(500) AFTER status;
ALTER TABLE `Order` ADD COLUMN delivery_partner_id INT AFTER delivery_address;
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
