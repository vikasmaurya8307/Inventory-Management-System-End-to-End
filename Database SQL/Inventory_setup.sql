-- 1. Initialize the Database
-- Create and switch to the e-commerce environment
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- 2. Define the Products Table
-- Stores core product information and safety stock levels
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    current_stock INT,
    unit_price DECIMAL(10, 2),
    min_stock_level INT -- The safety buffer required to avoid stock-outs
);

-- 3. Define the Suppliers Table
-- Stores vendor details and their respective delivery speeds
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    lead_time_days INT -- Number of days required for the supplier to deliver stock
);

-- 4. Define the Sales Table
-- Tracks historical transaction data linked to specific products
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Seed Initial Data for Suppliers
INSERT INTO suppliers (supplier_name, lead_time_days) VALUES 
('Fast Delivery Co.', 3), 
('Slow & Steady Inc.', 10);

-- 6. Seed Initial Data for Products
INSERT INTO products (product_name, current_stock, unit_price, min_stock_level) VALUES 
('Laptop', 5, 50000, 2), 
('Mouse', 50, 500, 10),
('Keyboard', 8, 1200, 5);

-- 7. Seed Initial Transaction Data
INSERT INTO sales (product_id, quantity_sold, sale_date) VALUES 
(1, 2, '2026-04-20'), 
(1, 1, '2026-04-21'),
(3, 5, '2026-04-22');

-- 8. Data Verification
-- Review all records across the core tables
SELECT * FROM products;
SELECT * FROM sales;
SELECT * FROM suppliers;

-- 9. Schema Enhancement
-- Adding a Foreign Key column to link Products with their Suppliers
ALTER TABLE products ADD COLUMN supplier_id INT;

-- 10. Map Products to Suppliers
-- Associating each inventory item with its primary vendor
UPDATE products SET supplier_id = 1 WHERE product_id = 1; -- Laptop -> Fast Delivery
UPDATE products SET supplier_id = 2 WHERE product_id = 2; -- Mouse -> Slow & Steady
UPDATE products SET supplier_id = 1 WHERE product_id = 3; -- Keyboard -> Fast Delivery


USE ecommerce_db;

-- 1. Suppliers ki list badhayein
INSERT INTO suppliers (supplier_name, lead_time_days) VALUES 
('Global Tech Corp', 5), ('Office Mart', 2), ('Logitech Solutions', 4), 
('Dell Official', 7), ('Samsung Hub', 6), ('Generic Electronics', 3);

-- 2. 50 Products Insert karein (with random initial stock and min levels)
INSERT INTO products (product_name, current_stock, unit_price, min_stock_level, supplier_id) VALUES 
('Monitor 24 inch', 20, 15000, 5, 1), ('Gaming Mouse', 45, 2500, 10, 3), 
('Mechanical Keyboard', 15, 4500, 5, 3), ('USB-C Cable', 100, 500, 20, 6),
('Webcam 1080p', 12, 3500, 4, 1), ('Laptop Stand', 30, 1200, 8, 2),
('HDMI Splitter', 50, 800, 15, 6), ('SSD 500GB', 25, 4000, 10, 5),
('RAM 8GB DDR4', 40, 3200, 12, 5), ('Processor i5', 10, 18000, 3, 4),
('External HDD 1TB', 18, 5500, 6, 1), ('Wifi Router', 22, 2800, 7, 1),
('Bluetooth Speaker', 35, 2200, 12, 3), ('Inkjet Printer', 8, 12000, 3, 2),
('Wireless Earbuds', 60, 1800, 20, 3), ('Graphics Card RTX', 5, 45000, 2, 4),
('Power Bank 10k', 42, 1500, 15, 5), ('VGA Cable', 80, 300, 10, 6),
('Drawing Tablet', 14, 8500, 4, 1), ('Desk Lamp', 28, 950, 10, 2),
-- Adding more to reach 50...
('Cooling Pad', 15, 1100, 5, 2), ('Microphone', 12, 5500, 4, 3),
('UPS 600VA', 7, 3500, 3, 1), ('Ethernet Switch', 20, 1500, 6, 6),
('Smart Watch', 40, 4500, 10, 5), ('Toner Cartridge', 15, 2500, 5, 2),
('Projector', 4, 35000, 2, 1), ('CPU Case', 10, 5500, 4, 4),
('Thermal Paste', 100, 400, 20, 6), ('SATA Cable', 150, 150, 30, 6),
('Internal Fan', 45, 600, 15, 6), ('Motherboard B450', 9, 9500, 4, 4),
('Power Supply 550W', 12, 4200, 5, 4), ('Game Controller', 25, 3200, 10, 3),
('Laptop Battery', 10, 3800, 4, 4), ('Screen Cleaner', 55, 250, 10, 2),
('SD Card 64GB', 90, 750, 25, 5), ('Headset Stand', 30, 800, 8, 3),
('VR Headset', 6, 25000, 2, 1), ('Sound Card', 18, 1500, 5, 6),
('Thermal Receipt Printer', 11, 6500, 4, 2), ('Paper Shredder', 5, 4500, 2, 2),
('Marker Pens (Pack)', 200, 150, 50, 2), ('Calculator', 40, 600, 15, 2),
('A4 Paper Rim', 300, 450, 100, 2), ('Stapler', 60, 200, 15, 2),
('Filing Cabinet', 10, 8500, 3, 2), ('Office Chair', 8, 12000, 3, 2),
('Writing Pad', 120, 80, 40, 2), ('USB Flash Drive 32GB', 85, 450, 30, 5);