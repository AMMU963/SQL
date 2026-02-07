/* NULL Functions:
      NULL means nothing or unknown.
      NULL is not equal to anything.
      NULL is not zero.
      NULL is not empty string.
      NULL is not blank space.

      --manipulate null values
      ISNULL()
      COALESCE()  these are to replace null 
      NULLIF()  this is to replace value to null

      --just to check
      IS NULL is used to find the wether we have null or not (returns boolean)
      IS NOT NULL
      
      */

/* ISNULL() : Replaces a NULL with a specific value.
     syntax : ISNULL(value , replacement_value(deault is unkown)
     we can use two columns name .
     */
SELECT
OrderID,
ShipAddress,
BillAddress,
ISNULL(ShipAddress , 'unknown') replaced_using_static_val,
ISNULL(ShipAddress ,BillAddress) as replaced_using_column
FROM Sales.Orders

/* COALESCE() : Retruns first non-null value from a list.
    syntax : COALESCE(vau1 val2 , val3 ,.....)
    */

SELECT
OrderID,
ShipAddress,
BillAddress,
COALESCE(ShipAddress,BillAddress) as _2colval,
COALESCE(ShipAddress,BillAddress,'unkown') as  three_col
FROM Sales.Orders



--Use cases : 
--Data Agregations : return the wrong output before handling
--handle the NULL before doing  operations
SELECT
CustomerID,
score,
ISNULL(Score , 0) as Score2,
AVG(Score) OVER() AvgScore,
AVG(ISNULL(Score , 0)) OVER() AvgScore2
FROM Sales.Customers


--Mathematical calculations : returns null before handling
SELECT *,
FirstName || ' ' || LastName as FullName,
Score+10 as Bonus_10  --where there is null we getting null
FROM Sales.Customers

SELECT *,
ISNULL(LastName,'') AS LastName2,
ISNULL(score,0) AS Score2,
FirstName || ' ' || ISNULL(LastName,'') AS FullName,
ISNULL(score,0) + 10 AS Bonus
FROM Sales.Customers

/*  Joins 
       -if we have null inside the keys we loose some info
       */

/* Sorting Data: before sorting  (Null will come first or end )
*/
--Sort the customers from low to high scores wiht null appearng lasr
SELECT
Score
FROM Sales.Customers
ORDER BY Score ASC

--Lazy way (1) :defining static value
SELECT
Score,
ISNULL(Score , 999999)
FROM Sales.Customers
ORDER BY ISNULL(Score , 999999) ASC

--Proffesional way(2)
SELECT
Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY ISNULL(Score , 999999) ASC

SELECT
Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END,Score


/* NULLIF() : Compares two expressions returns:
                 -NULL , If they are equal.
                 -First val ,if they are not equal

                 */
--USE cASE: DIVISION BY zero
--Find the sales price for each order by dividing sales by quantity
SELECT 
OrderID,
Sales,
Quantity,
Sales/NULLIF(Quantity,0)  AS Price
FROM Sales.Orders

--IS NULL :Returs TRUE if the value is NULL
--USE CASE : 
--Filtering Data : missing data
--Idemtify the customers who have no score
SELECT
score
FROM Sales.Customers
WHERE score IS NULL

--List oa all customers who have scores
SELECT 
*
FROM Sales.Customers
WHERE Score IS NOT NULL

--ANTI JOINS: Find unmatched rows in two table
--List all details for customers who have not places orders
SELECT 
c.CustomerID,
c.FirstName,
o.OrderID,
o.Sales
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

--Creating dummy table
WITH Orders AS (
SELECT 1 ID , 'A' Category UNION
SELECT 2 , NULL UNION
SELECT 3 , '' UNION
SELECT 4 , '  ' 
)
SELECT *,
LEN(category) AS catlen , --ignores trailing spaces
DATALENGTH(Category) as datalength_cat
FROM Orders

SELECT LEN('  '),
LEN('A '),
LEN(' A ')   --LEADING SPACES COUNTS

/* Data Policy : set of rules that defines how data should be handled.
           -- only use nulls or empty strings avoid blank spaces
           -- only use nulls avoid using both empty string and black spaces(before inserting into database)
           -- use default value 'unknown and avoud nulls , empty strng , blank spaces(before reporting)
*/

WITH Orders AS (
SELECT 1 ID , 'A' Category UNION
SELECT 2 , NULL UNION
SELECT 3 , '' UNION
SELECT 4 , '  ' 
)
SELECT *,
DATALENGTH(Category) as datalength_cat,
DATALENGTH(TRIM(Category)) AS Policy1
FROM Orders



