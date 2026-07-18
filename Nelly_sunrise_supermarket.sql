  --create the schema
create schema sunrise;

set search_path to sunrise;

--creating customers
create table customers(
customer_id SERIAL primary key,
full_name varchar(50),
email varchar(50) unique,
phone_number varchar(50),
County varchar(50)
);


--showing the structure and columns of the table
select * from customers;

--insert values into customers table 
insert into customers(full_name, email, phone_number, county) 
values('Grace Wambui', 'grace.wambui@gmail.com', '0711223344', 'Nairobi'),
	('Kevin Mutiso', 'kevin.mutiso@gmail.com', '0722334455', 'Nakuru'),
	('Faith Chebet', 'faith.chebte@gmail.com', '0733445566', 'Eldoret'),
	('Ibrahim Noor', 'ibrahim.noor@gmail.com', '0744556677', 'Mombasa');


--adding a constraint unique to the phone_number column
alter table customers 
   alter column phone_number type varchar(50),
    add constraint unique_phone UNIQUE (phone_number);

--creating table products
create table products(
product_id SERIAL primary key,
product_name varchar(50),
category varchar(50),
unit_price numeric(10,2) check (unit_price > 0),
stock int default 0
);


--inserting values into table products
insert into products (product_name, category, unit_price, stock)
values('Maize Flour 2kg', 'Groceries', 180, 50),
      ('Cooking Oil 1L', 'Groceries', 320, 30),
      ('Bathing Soap', 'Toiletries', 85, 100 ),
      ('Notebook A4', 'Stationery', 60, 200);

--show table products
select * from products;

--creating the order table 
create table orders(
order_id SERIAL primary key,
customer_id INT,
order_date date,
status varchar(50) default 'Pending',
foreign key(customer_id) 
references customers(customer_id) on delete cascade);
set search_path to sunrise;


--show table orders
select * from sunrise.orders;
drop table orders;


--adding values to the table orders
insert into orders (customer_id, order_date, status)
values(1, '2024-03-01', 'Delivered'),
      (2, '2024-03-02', 'Pending'),
      (1, '2024-03-03', 'Delivered'),
      (3, '2024-03-04', 'Cancelled');

--create table order_items
create table order_items(
order_item_id SERIAL primary key,
order_id INT,
product_id INT,
quantity INT check (quantity >0),
foreign key (order_id) references orders(order_id) on delete cascade,
foreign key (product_id) references products(product_id) on delete cascade);

select * from order_items;

--insert values into the table 
insert into order_items(order_id, product_id, quantity)
values(1,1,2),
      (1,3,1),
      (2,2,1),
      (3,4,5);

--renaming stock column to stock quantity 
alter table products rename column stock to stock_quantity;

select * from products;

--adding column loyalty_points defaulting to 0 
alter table customers add column loyalty_points INT default 0;



--Change column product_name type to VARCHAR(150).
alter table products alter column product_name type varchar(150);

--Update order_id 2 so its status becomes 'Delivered'
update orders set status ='Delivered' where order_id = 2;


--. Delete the cancelled order (order_id 4)
delete from orders where order_id = 4;

--. Show every product priced above 100.
select product_name, unit_price from products where unit_price > 100;

--Show every customer NOT based in Nairobi.
select full_name , county from customers where county <> 'Nairobi';

--Shelct ow every product priced between 60 and 200, inclusive.
select product_name, unit_price from products where unit_price between 60 and 200 order by unit_price;

--Show every customer who lives in Nairobi, Nakuru, or Mombasa, using IN

select full_name, county
from customers 
where county in ('Nairobi', 'Nakuru', 'Mombasa');

--Show every product whose name contains the word 'Oil', using LIKE.
--soil , oiline,,, coil,,,, ..oil..
select product_name from products where product_name like 'Oil%';
set search_path to sunrise;


--Show every order that is still 'Pending', sorted by order_date, earliest first.
select status, order_date from orders where status = 'Pending' order by order_date DESC;

--Challenge - show the 2 most expensive products, using ORDER BY and LIMIT together.
select product_name , unit_price from products order by unit_price desc  limit 2;


select * from customers;
select * from products;
select * from orders;
select * from order_items;


--Grouping and aggregates


--Count how many orders each customer_id has placed (GROUP BY customer_id)
select  customer_id , sum(order_id) 
as total_orders from orders group by customer_id;

--Challenge - using HAVING, show only the customer_id values that have placed more than 1 order.
select customer_id, sum(order_id) 
as total_orders from orders 
group by customer_id having sum(order_id) > 1;

--JOINS
-- INNER JOIN customers with orders to show each customer's
-- full_name next to their order_id and status.

select c.full_name, o.order_id, o.status
from customers c inner join orders o on c.customer_id = o.customer_id;

--LEFT JOIN orders with order_items so that every order shows up

select * from orders o
left join order_items oi 
on o.order_id = oi.order_id;

--. JOIN order_items with products to show, for every order item, the product_name and quantity together.
select oi.order_item_id, p.product_name, oi.quantity from order_items oi left join products p 
on oi.product_id = p.product_id;


--join all four tables together (customers -> orders -> order_items -> products) 
--to produce one row per item ordered, showing: full_name, order_id, product_name, quantity.

select c.full_name, o.order_id, p.product_name, oi.quantity from customers c join 
orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join 
products p on oi.product_id = p.product_id;

--add a GROUP BY to show total quantity ordered 
--per product_name across all customers.

select c.full_name, o.order_id, p.product_name, sum(oi.quantity) from customers c join 
orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join 
products p on oi.product_id = p.product_id group by c.full_name, o.order_id, p.product_name;
