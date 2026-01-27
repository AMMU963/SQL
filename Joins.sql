USE MyDatabase
/* Basic SQL JOINS : key column is used to join
               : to combine data by columns
*/

-- 1 . No Join -- returns data from tables without combining them
--Retrieve all data from the customers and order table as a separate results.
SELECT * 
FROM customers;
SELECT * 
FROM orders;

/* 2. Inner Join  Returns only the matching rows from both table.
                  Order of the table doesnot matter

syntax: 
        SELECT *
        FROM A
        INNER JOIN B
        ON condition  (how to match rows) A.key = B.key

-Default join is inner join.
caution: order of the table doesnt mater
*/


/* Get all customets along with their orders 
   but only for customers who have placed an order.*/
SELECT * 
FROM orders
INNER JOIN customers
ON id = customer_id;

SELECT 
    id,
    first_name,
    order_id,
    sales
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

--Column Ambiguity : add the table name brfore column to avoid confusion wiht same-named columns
SELECT 
    customers.id,
    customers.first_name,
    orders.order_id,
    orders.sales
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

--Alias : shorthand names for tables
SELECT 
c.id,
c.first_name,
o.order_id,
o.sales
FROM customers  AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;


/* 3. Left Join: Returns all rows from left and only matching from right
             - left table is primary source data  and right table secondary need additional table
             - order of the table matters
     syntax :
              SELECT *
              FROM A
              LEFT JOIN B
              ON a.key = b.key;
              
*/

/* Get all customers along with their orders 
   incluing those without order.*/
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;
--Caution : order of the table matters.

/* 4.Right Join: Returns all the table from right table and all the matching tables form the left table.
                 Right table is primary source of data and left table is just secondary need additional data .
      syntax: SELECT *
              FROM A
              RIGHT JOIN B
              ON A.key = B.key;
    */

/* Get all cutomers along with their orders 
   including orders without matching customers.  */
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id;

--same task using the Left join.
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id;

/* 5. Full Join: Returns all the rowws from both tables.
                 Order of the table doesnt matter
    syntax: SELECT *
            FROM A
            FULL JOIN B
            ON A.key = B.key;
*/

--Get all cutomers and all orders , even if there's no match.
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders o
FULL JOIN customers c
ON c.id = o.customer_id;

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id;


 -- Advanced Joins: 
 /* 1. Left Anti Join: Returns Row from left that has NO MATCH in RIGHT TABLE.
        */

--Get all cutomers who havent place any order
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

--2. Rigth Anti Join : Returns rows from  Rgith that has NO MATCH in left(lookup/filter) .
--Get all orders wihtout matching cutomers
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL

--Same task using Left Join
SELECT *
FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id
WHERE c.id  IS NULL

-- Full Anti Join : Returns rows that are DONT  MATCH in EITHER tables.
--Find cutmoers without orders and orders with cutomers
SELECT *
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL


/* Get all cutomers along wiht their orders 
but only for cutomers who have placed an order.*/
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE  o.customer_id  IS NOT NULL;

-- Cross Join : Every row from left with every row from right(all possible combinations).
-- Generate all possible combinations of customers and orders.
SELECT *
FROM customers c
CROSS JOIN orders o

--Muilti joining
/* Using SalesDB , Retrieve a list of all Orders , 
along with the related cutomers , product and emplyee details.*/
USE SalesDB

SELECT 
    o.OrderID,
    o.Sales
FROM Sales.Orders o;





