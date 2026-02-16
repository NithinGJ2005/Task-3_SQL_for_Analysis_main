-- =========================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- DATASET: ECOMMERCE
-- =========================================


-- =========================================
-- 1️⃣ CREATE TABLE QUERIES
-- =========================================

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    city TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER
);


-- =========================================
-- 2️⃣ INSERT QUERIES
-- =========================================

INSERT INTO customers VALUES
(1, 'Nithin', 'nithin@gmail.com', 'Bangalore'),
(2, 'Rahul', 'rahul@gmail.com', 'Mumbai'),
(3, 'Anjali', 'anjali@gmail.com', 'Delhi');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Phone', 'Electronics', 30000),
(103, 'Shoes', 'Fashion', 2000),
(104, 'Watch', 'Fashion', 5000);

INSERT INTO orders VALUES
(1001, 1, '2025-01-10', 65000),
(1002, 2, '2025-01-12', 30000),
(1003, 1, '2025-01-15', 2000);

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 104, 1),
(3, 1002, 102, 1),
(4, 1003, 103, 1);


-- =========================================
-- 3️⃣ SELECT QUERIES
-- =========================================

-- View all customers
SELECT * FROM customers;

-- View all products
SELECT * FROM products;

-- SELECT with WHERE
SELECT * 
FROM customers
WHERE city = 'Bangalore';

-- ORDER BY
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- GROUP BY with SUM
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- INNER JOIN
SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- LEFT JOIN
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- Aggregate Function (AVG)
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

-- Revenue by Category (JOIN + GROUP BY)
SELECT p.category,
       SUM(p.price * oi.quantity) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category;

-- Subquery
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);


-- =========================================
-- 4️⃣ VIEW QUERY
-- =========================================

CREATE VIEW sales_summary AS
SELECT c.name,
       SUM(o.total_amount) AS total_spent,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name;

-- View the created VIEW
SELECT * FROM sales_summary;


-- =========================================
-- 5️⃣ INDEX QUERY (OPTIMIZATION)
-- =========================================

CREATE INDEX idx_customer_id
ON orders(customer_id);

CREATE INDEX idx_product_id
ON order_items(product_id);

-- =========================================
-- END OF FILE
-- =========================================
