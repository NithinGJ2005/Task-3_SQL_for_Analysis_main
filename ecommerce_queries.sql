-- Create Tables
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    country TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price REAL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    total_amount REAL
);

-- Insert Data
INSERT INTO customers VALUES (1, 'Vinay', 'India');
INSERT INTO customers VALUES (2, 'Rahul', 'India');
INSERT INTO customers VALUES (3, 'John', 'USA');

INSERT INTO products VALUES (101, 'Laptop', 50000);
INSERT INTO products VALUES (102, 'Mobile', 20000);
INSERT INTO products VALUES (103, 'Headphones', 2000);

INSERT INTO orders VALUES (1001, 1, 101, 1, 50000);
INSERT INTO orders VALUES (1002, 1, 103, 2, 4000);
INSERT INTO orders VALUES (1003, 2, 102, 1, 20000);
INSERT INTO orders VALUES (1004, 3, 101, 1, 50000);

-- SELECT + WHERE
SELECT * FROM customers WHERE country = 'India';

-- ORDER BY
SELECT * FROM products ORDER BY price DESC;

-- GROUP BY
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- JOIN
SELECT c.customer_name, o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- Subquery
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 30000
);

-- View
CREATE VIEW high_value_customers AS
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 30000;

SELECT * FROM high_value_customers;

-- Index
CREATE INDEX idx_customer_id ON orders(customer_id);
