-- ============================================================
-- TastyBites - South Indian Restaurant & Menu Data Update
-- Run this in MySQL: mysql -u root -pKrishnan@2005 food_delivery_application < update_restaurants.sql
-- ============================================================

USE food_delivery_application;

-- ──────────────────────────────────────────────
-- 1. FIX existing restaurant image URLs
-- ──────────────────────────────────────────────
UPDATE restaurant SET
    image_url = 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800&auto=format&fit=crop',
    address   = 'Pondy Bazaar, T. Nagar, Chennai',
    cuisine_type = 'North Indian, Chinese, Tandoor',
    delivery_time = '30-40 mins'
WHERE restaurant_id = 1; -- Spice Garden

UPDATE restaurant SET
    image_url = 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop',
    address   = 'T. Nagar, Chennai',
    delivery_time = '25-35 mins'
WHERE restaurant_id = 2; -- Biryani House

UPDATE restaurant SET
    image_url = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&auto=format&fit=crop',
    address   = 'Velachery, Chennai',
    delivery_time = '20-30 mins'
WHERE restaurant_id = 3; -- Pizza Palace

-- ──────────────────────────────────────────────
-- 2. ADD South Indian Restaurants
-- ──────────────────────────────────────────────

-- Restaurant 4: Vasantha Bhavan
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Vasantha Bhavan',
    'South Indian Vegetarian',
    '20-30 mins',
    'Mylapore, Chennai',
    'images/vasantha_bhavan.png',
    80.00, 4.5, 1, NULL
);

-- Restaurant 5: Saravana Bhavan
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Saravana Bhavan',
    'South Indian Tiffin & Meals',
    '25-35 mins',
    'Anna Nagar, Chennai',
    'images/saravana_bhavan.png',
    100.00, 4.7, 1, NULL
);

-- Restaurant 6: Murugan Idli Shop
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Murugan Idli Shop',
    'Idli, Dosa, South Indian Breakfast',
    '15-25 mins',
    'KK Nagar, Madurai',
    'images/murugan_idli.png',
    60.00, 4.8, 1, NULL
);

-- Restaurant 7: Anjappar Chettinad
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Anjappar Chettinad',
    'Chettinad Non-Veg, South Indian',
    '35-45 mins',
    'RS Puram, Coimbatore',
    'images/anjappar.png',
    150.00, 4.4, 1, NULL
);

-- Restaurant 8: Junior Kuppanna
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Junior Kuppanna',
    'Kongu Nadu Cuisine, Biryani',
    '30-40 mins',
    'Gandhipuram, Coimbatore',
    'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=800&auto=format&fit=crop',
    120.00, 4.6, 1, NULL
);

-- Restaurant 9: Chennai Express
INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id)
VALUES (
    'Chennai Express',
    'South Indian, Street Food',
    '20-30 mins',
    'Ashok Nagar, Chennai',
    'https://images.unsplash.com/photo-1630851840633-f96999247032?w=800&auto=format&fit=crop',
    70.00, 4.2, 1, NULL
);

-- ──────────────────────────────────────────────
-- 3. FIX existing broken menu item images
-- ──────────────────────────────────────────────

-- Fix Chicken Biryani (restaurant 2)
UPDATE menu SET
    image_url = 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500&auto=format&fit=crop'
WHERE menu_name = 'Chicken Biryani';

-- Fix Garlic Bread (restaurant 3) - was showing a girl's photo!
UPDATE menu SET
    image_url = 'https://images.unsplash.com/photo-1573140401552-3fab0b24306f?w=500&auto=format&fit=crop'
WHERE menu_name = 'Garlic Bread';

-- Fix Margherita Pizza
UPDATE menu SET
    image_url = 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&auto=format&fit=crop'
WHERE menu_name = 'Margherita Pizza';

-- Fix Mutton Biryani
UPDATE menu SET
    image_url = 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&auto=format&fit=crop'
WHERE menu_name = 'Mutton Biryani';

-- ──────────────────────────────────────────────
-- 4. ADD Menu items for new restaurants
-- ──────────────────────────────────────────────

-- Get restaurant IDs dynamically using subqueries

-- Vasantha Bhavan Menu (vegetarian South Indian)
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Masala Dosa', 'Crispy dosa with spiced potato filling, served with sambar & chutney', 'Breakfast', 89.00, 1,
    'https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Vasantha Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Meals (Full Thali)', 'Full South Indian meals: rice, sambar, rasam, 3 curries, papad, payasam', 'Meals', 130.00, 1,
    'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Vasantha Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Filter Coffee', 'Authentic South Indian filter coffee served in traditional davara tumbler', 'Beverages', 35.00, 1,
    'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Vasantha Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Rava Kesari', 'Sweet semolina pudding with ghee, saffron and cashews', 'Sweets', 55.00, 1,
    'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Vasantha Bhavan';

-- Saravana Bhavan Menu
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Idli (4 pcs)', '4 soft steamed idlis with sambar and 2 chutneys', 'Breakfast', 60.00, 1,
    'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Saravana Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Mini Tiffin Combo', 'Idli + Vada + Masala Dosa with sambar & chutneys', 'Combo', 110.00, 1,
    'https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Saravana Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Ghee Pongal', 'Creamy rice and moong dal pongal with generous ghee, served with sambar', 'Breakfast', 75.00, 1,
    'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Saravana Bhavan';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Poori Masala (3 pcs)', 'Fluffy deep-fried pooris with spiced potato masala', 'Breakfast', 80.00, 1,
    'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Saravana Bhavan';

-- Murugan Idli Shop Menu
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Kari Dosa', 'Special dosa with minced meat filling, signature Murugan style', 'Main Course', 120.00, 1,
    'https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Murugan Idli Shop';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Soft Idli (6 pcs)', 'Famous soft white idlis served with special Murugan sambar & 3 chutneys', 'Breakfast', 70.00, 1,
    'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Murugan Idli Shop';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Vada (4 pcs)', 'Crispy medu vada with coconut chutney and sambar', 'Starter', 65.00, 1,
    'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Murugan Idli Shop';

-- Anjappar Chettinad Menu
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Chettinad Chicken Curry', 'Authentic spicy Chettinad chicken curry with whole spices and coconut', 'Main Course', 220.00, 1,
    'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Anjappar Chettinad';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Pepper Chicken Dry', 'Aromatic pepper chicken fry with fresh ground pepper and curry leaves', 'Starter', 180.00, 1,
    'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Anjappar Chettinad';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Mutton Kuzhambu', 'Slow-cooked mutton in rich chettinad masala gravy', 'Main Course', 280.00, 1,
    'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Anjappar Chettinad';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Banana Leaf Meals', 'Full Chettinad non-veg meals on banana leaf with rice, 4 curries', 'Meals', 320.00, 1,
    'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Anjappar Chettinad';

-- Junior Kuppanna Menu
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Kongu Mutton Biryani', 'Aromatic Kongu-style dum biryani with tender mutton pieces', 'Main Course', 300.00, 1,
    'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Junior Kuppanna';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Kari Kuzhambu', 'Traditional Kongu Nadu meat curry with fresh ground masala', 'Main Course', 180.00, 1,
    'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Junior Kuppanna';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Parotta with Salna', 'Layered flaky parotta with spicy Kongu style salna gravy', 'Main Course', 120.00, 1,
    'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Junior Kuppanna';

-- Chennai Express Menu
INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Kothu Parotta', 'Shredded parotta with egg, vegetables and spicy masala', 'Main Course', 130.00, 1,
    'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Chennai Express';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Chicken 65', 'Crispy spicy deep-fried chicken marinated with South Indian spices', 'Starter', 160.00, 1,
    'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Chennai Express';

INSERT INTO menu (restaurant_id, menu_name, description, category, price, is_available, image_url)
SELECT restaurant_id, 'Egg Dosa', 'Crispy dosa topped with beaten egg and spices, street-food style', 'Breakfast', 90.00, 1,
    'https://images.unsplash.com/photo-1630851840633-f96999247032?w=500&auto=format&fit=crop'
FROM restaurant WHERE name = 'Chennai Express';

SELECT 'Database updated successfully!' AS Status;
SELECT restaurant_id, name, cuisine_type, ratings FROM restaurant ORDER BY restaurant_id;
