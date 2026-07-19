# Sunrise Supermarket SQL Project

A beginner-friendly PostgreSQL practice project that demonstrates how a small retail business can move from scattered records to a structured relational database. The project uses a fictional supermarket, Sunrise Supermarket, to model customers, products, orders, and order items, then runs SQL queries that answer practical business questions.

This repository is useful for SQL beginners who want more than isolated syntax examples. It shows how SQL concepts connect in a realistic workflow: designing tables, enforcing data quality, inserting related records, changing table structures, filtering data, summarizing results, and joining multiple tables.

## Project Background

Sunrise Supermarket needs a database to manage basic business records. The supermarket wants to track:

- Customers and where they are located
- Products, categories, prices, and available stock
- Orders placed by customers
- Items and quantities included in each order

The goal of the project is to build the database from scratch and use SQL to answer questions a supermarket owner or data analyst might ask, such as:

- Which products are priced above a certain amount?
- Which customers are not based in Nairobi?
- Which products fall within a specific price range?
- Which customers live in selected counties?
- Which orders are still pending?
- Which customers placed orders?
- What products were included in each order?
- What is the total quantity ordered per product?

## What I Built

The completed SQL script is saved in `Nelly_sunrise_supermarket.sql`. It includes the full database workflow from table creation to business-style queries.

The project builds four connected tables:

| Table | Purpose | Key Columns |
| --- | --- | --- |
| `customers` | Stores customer details | `customer_id`, `full_name`, `email`, `phone_number`, `county` |
| `products` | Stores supermarket product details | `product_id`, `product_name`, `category`, `unit_price`, `stock_quantity` |
| `orders` | Stores customer order records | `order_id`, `customer_id`, `order_date`, `status` |
| `order_items` | Stores products included in each order | `order_item_id`, `order_id`, `product_id`, `quantity` |

## SQL Concepts Practiced

This project covers the main SQL skills needed to start working with relational databases:

### Database Design

- Creating a schema for organizing database objects
- Designing tables based on business records
- Choosing suitable column names and data types
- Structuring related tables using primary and foreign keys

### Data Integrity

- Using `PRIMARY KEY` to uniquely identify rows
- Using `FOREIGN KEY` to connect related tables
- Using `UNIQUE` to prevent duplicate emails and phone numbers
- Using `CHECK` to prevent invalid values such as negative prices or zero quantities
- Using `DEFAULT` to provide automatic starting values

### Data Manipulation

- Inserting sample records with `INSERT INTO`
- Updating existing records with `UPDATE`
- Deleting records with `DELETE`
- Applying changes in an order that respects table relationships

### Querying and Filtering

- Retrieving data with `SELECT`
- Filtering rows with `WHERE`
- Using comparison operators such as `>`, `<>`, and `BETWEEN`
- Matching patterns with `LIKE`
- Filtering against multiple values with `IN`
- Sorting results with `ORDER BY`
- Limiting results with `LIMIT`

### Aggregation and Reporting

- Grouping records with `GROUP BY`
- Filtering grouped results with `HAVING`
- Summarizing data with aggregate functions such as `COUNT` and `SUM`

### Joins

- Using `INNER JOIN` to match related rows across tables
- Using `LEFT JOIN` to keep all records from one table even when matches are missing
- Joining all four tables to produce meaningful business output

## Repository Contents

| File | Description |
| --- | --- |
| `Nelly_sunrise_supermarket.sql` | Main SQL script containing schema creation, table creation, data insertion, updates, deletes, filters, aggregate queries, and joins |
| `README.md` | Project documentation explaining the purpose, structure, concepts, and how to run the SQL file |

## Database Relationship Overview

The database follows a simple relational structure:

```text
customers
   |
   | customer_id
   v
orders
   |
   | order_id
   v
order_items
   ^
   | product_id
   |
products
```

In plain language:

- One customer can place many orders.
- One order can contain many order items.
- Each order item points to one product.
- Products can appear in many different orders.

This structure avoids storing repeated customer and product information inside every order. Instead, related tables are connected using IDs.

## Sample Data Used

The project uses a small dataset that is easy to understand while still showing real relational database behavior.

### Customers

| customer_id | full_name | county |
| --- | --- | --- |
| 1 | Grace Wambui | Nairobi |
| 2 | Kevin Mutiso | Nakuru |
| 3 | Faith Chebet | Eldoret |
| 4 | Ibrahim Noor | Mombasa |

### Products

| product_id | product_name | category | unit_price | stock_quantity |
| --- | --- | --- | --- | --- |
| 1 | Maize Flour 2kg | Groceries | 180.00 | 50 |
| 2 | Cooking Oil 1L | Groceries | 320.00 | 30 |
| 3 | Bathing Soap | Toiletries | 85.00 | 100 |
| 4 | Notebook A4 | Stationery | 60.00 | 200 |

## Example Queries

### Find Products Priced Above 100

```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 100;
```

Expected result:

| product_name | unit_price |
| --- | --- |
| Maize Flour 2kg | 180.00 |
| Cooking Oil 1L | 320.00 |

This query shows how filtering can answer a basic pricing question.

### Find Customers Not Based in Nairobi

```sql
SELECT full_name, county
FROM customers
WHERE county <> 'Nairobi';
```

Expected result:

| full_name | county |
| --- | --- |
| Kevin Mutiso | Nakuru |
| Faith Chebet | Eldoret |
| Ibrahim Noor | Mombasa |

This query demonstrates how to exclude a specific value from the result.

### Join All Four Tables

```sql
SELECT c.full_name, o.order_id, p.product_name, oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
```

Expected result:

| full_name | order_id | product_name | quantity |
| --- | --- | --- | --- |
| Grace Wambui | 1 | Maize Flour 2kg | 2 |
| Grace Wambui | 1 | Bathing Soap | 1 |
| Kevin Mutiso | 2 | Cooking Oil 1L | 1 |
| Grace Wambui | 3 | Notebook A4 | 5 |

This is one of the most important queries in the project because it combines customer, order, order item, and product data into one readable result.

### Total Quantity Ordered Per Product

```sql
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;
```

Expected result:

| product_name | total_quantity |
| --- | --- |
| Maize Flour 2kg | 2 |
| Bathing Soap | 1 |
| Cooking Oil 1L | 1 |
| Notebook A4 | 5 |

This query shows how joins and aggregation can be combined to produce a reporting-style result.

## How to Run the Project

You can run this project in PostgreSQL using tools such as pgAdmin, DBeaver, DataGrip, TablePlus, or the PostgreSQL command line.

1. Install PostgreSQL if it is not already installed.
2. Open your preferred PostgreSQL client.
3. Create or connect to a database where you want to run the project.
4. Open `Nelly_sunrise_supermarket.sql`.
5. Run the script from top to bottom.
6. Review each query result in your SQL editor.

## Suggested Learning Path

If you are new to SQL, go through the script in this order:

1. Understand the table creation statements first.
2. Study how the tables are connected using foreign keys.
3. Run the insert statements and inspect the data.
4. Practice the filtering queries one by one.
5. Review the grouping and aggregate queries.
6. Spend extra time on the join queries because they are key to working with relational data.
7. Modify the sample data and rerun the queries to see how the results change.

## Key Lessons Learned

This project helped reinforce several important SQL lessons:

- Good table design makes querying easier later.
- Primary keys and foreign keys are essential for relational databases.
- Constraints help protect data from duplicates and invalid values.
- Data must be inserted in the correct order when relationships exist.
- Filtering turns raw tables into useful answers.
- Aggregation helps summarize business activity.
- Joins are powerful because they connect separate tables into meaningful reports.

## Possible Improvements

This project can be extended further by adding:

- A payments table to track order payments
- A suppliers table to track product suppliers
- More product categories and larger sample data
- Views for common reports
- Stored procedures for repeated operations
- Indexes to improve query performance
- More analytical queries, such as revenue by product category

## Skills Demonstrated

- SQL database design
- PostgreSQL schema creation
- Relational data modeling
- Data integrity with constraints
- CRUD operations
- Filtering and sorting records
- Aggregate reporting
- Multi-table joins
- Beginner-friendly technical documentation

## Author

Created by Nelly as part of an SQL Basics practice project.
