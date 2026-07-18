# Sunrise Supermarket SQL Project

A beginner-friendly PostgreSQL project that builds a complete supermarket database from scratch. This repository demonstrates how to design relational tables, insert sample data, update records, filter data, summarize results, and join related tables.

## Project Overview

Sunrise Supermarket wants to move customer, product, order, and order item records into a proper database system. The goal of this project is to create the database structure, load starter data, and write SQL queries that answer practical business questions.

The completed SQL work is saved in `Nelly_sunrise_supermarket.sql`.

## What This Project Covers

- Creating a PostgreSQL schema
- Creating relational tables with suitable columns and data types
- Adding `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, and `DEFAULT` constraints
- Inserting sample records into related tables
- Updating and deleting data
- Filtering records with `WHERE`, `IN`, `BETWEEN`, and `LIKE`
- Sorting results with `ORDER BY`
- Returning limited results with `LIMIT`
- Grouping data with `GROUP BY`
- Filtering grouped data with `HAVING`
- Combining tables with `INNER JOIN` and `LEFT JOIN`

## Database Tables

The project uses four connected tables:

| Table | Purpose |
| --- | --- |
| `customers` | Stores customer information such as name, email, phone number, and county |
| `products` | Stores product details such as name, category, price, and stock quantity |
| `orders` | Stores customer orders, order dates, and order status |
| `order_items` | Stores the products and quantities included in each order |

## Repository Contents

| File | Description |
| --- | --- |
| `Nelly_sunrise_supermarket.sql` | Main SQL script containing table creation, inserts, updates, deletes, filters, aggregates, and joins |
| `README.md` | Project documentation for GitHub |

## How to Run the Project

1. Install PostgreSQL or open a PostgreSQL-compatible SQL editor.
2. Create or connect to a database where you want to run the project.
3. Open `Nelly_sunrise_supermarket.sql`.
4. Run the script from top to bottom.
5. Review the output of each query in your SQL editor.

## Example Query

```sql
-- Join all four tables to show one row per item ordered
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

## Skills Demonstrated

- SQL database design
- Relational data modeling
- Data integrity with constraints
- CRUD operations
- Business-style filtering queries
- Aggregate reporting queries
- Multi-table joins
- Technical writing for project documentation

## Author

Created by Nelly as part of an SQL Basics practice project.
