import sqlite3

print("Script started")

conn = sqlite3.connect("ecommerce.db")
cursor = conn.cursor()

with open("ecommerce_queries.sql", "r") as file:
    sql_script = file.read()

print("SQL file loaded")

cursor.executescript(sql_script)

print("Tables and data created")

print("\nSELECT + WHERE")
cursor.execute("SELECT * FROM customers WHERE country='India'")
print(cursor.fetchall())

print("\nJOIN")
cursor.execute("""
SELECT c.customer_name, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
""")
print(cursor.fetchall())

print("\nGROUP BY")
cursor.execute("""
SELECT customer_id, SUM(total_amount)
FROM orders
GROUP BY customer_id
""")
print(cursor.fetchall())

conn.close()

print("Script finished")
