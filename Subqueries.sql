/* DataWareHouse : It is  a special Database  that collects an integerates data
                    from different sources to enable analytics adn support decision making. */

/*  Chalanges : Redundancy , Perrform issues , Complexity , hard to maintain , DB Streess , Data Security
     Solutions : Subqurey , CTE (Common Table Expression) , Views, Temp Tables , CTAS (Create table as Select
*/

/* Server : database storage ,
         - Database Engine : It is a brain of database, executing multile  operations like storing ,retrieving ,managing data wihtin a database
         - Disk Storage : long term memory , stores data permanantly. 
              Capacity : can hold large amount of data , 
              Speed : slow to read and to write
                   parts :
                  user Data Storage : its the main component of the data base , where actual data that users care about is stored.(data source)
                  Catalog  : it holds the metadata about the database
                  Temp   :
                we can find these  in information schema in sql server .
         - Cache Storage : Fast short term memory where data stored temporarily.
              Capacity : can hold smaller amount of data
              Speed : extremely fast to read and to write
        
    */

SELECT
*
FROM INFORMATION_SCHEMA.COLUMNS

SELECT DISTINCT  TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS

--Sub quries : query inside a query
--Result Types : Scalar  , row  ,table

--Scalar type(single value)
SELECT AVG(Sales) AVg
From sales.Orders

--Row(only rows)
SELECT OrderID
FROM Sales.Orders

--Table(rows and clolumns)
SELECT
*
FROM Sales.Orders

--Location/Clauses :SELECT FROM JOIN WHERE

--1 . FROM  Clause : Used as temp table for main query.
/* Find the proucts that have a pricer higher 
     than the avg price of all prod.  */

 --MAIN QUERY
SELECT *
FROM( 
   --SUB QUREY
    SELECT 
        ProductID,
        Price,
        AVG(Price) OVER() AvgPrice
    FROM Sales.Products               )T
WHERE Price > AvgPrice

--Rank the cust based on their total amt of sales.
--MAIN QUERY
SELECT
*,
RANK() OVER(ORDER BY TotalSalesByCustomers)  CutomerRank
FROM(
   --SUB QUERY
    SELECT
    CustomerID,
    SUM(Sales)  TotalSalesByCustomers
    FROM Sales.Orders
    GROUP BY CustomerID ) t

--2. SELECT Clause  (sub query should return a scalar value
--Show the products IDS, Products name ,prices and total amount of orders
--MAIN QUERY
SELECT
ProductID,
Product,
Price,
  ( --SUB QUERY
  SELECT COUNT(*)  FROM Sales.Orders) TotalOrders
FROM Sales.Products

-- 3. JOIN Clause
/* Show all Cust details and
   find the total orders of each customer */
SELECT 
c.*,
o.TotalOrders
FROM Sales.Customers c
LEFT JOIN (  --SUB QUERY
    SELECT
    customerID,
    COUNT(*) TotalOrders
    FROM Sales.Orders
    GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID

--4. WHERE Clause(logical , compatision op) :sub query should return  Scaler value
/* Find the proucts that have a pricer higher 
     than the avg price of all prod.  */
SELECT 
    ProductID,
    PRODUCT,
    Price
FROM Sales.Products
WHERE Price>(
                SELECT 
                AVG(Price) AvgPrice
                FROM Sales.Products )

--Logical Op : IN,ANY ,ALL,EXISTS

