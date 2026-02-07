/* SET OPERATERS : used to combine the rows
                   each query should return same number of columns 
                */
/* RULE 1 : SQL CLAUSES: 
          --SET OPERATORS can be used almost in all clauses
             WHERE| JOIN| GROUP BY | HAVING
          --ORDER BY is allowed only once at the end of the query.
   RULE 2 : NUMBER OF COLUMNS
          -- The number od columns in each query muct be same.
   RULE 3 : DATA TYPES
          -- Data type of columns in each query must be compatible
   RULE 4 : ORDER OF COLUMNS
          --The order of the columns in each query must be the same
   RULE 5 : COLUMNS ALIASES
         --First query contols the column names
   RULE 6 : CORRECT COLUMNS
         --all rules met no errors , results may be incorrect .
         --Incorrect colun seletion leads to inaccurate results

        */

USE SalesDB
SELECT 
FirstName,
LastName
FROM Sales.customers  --First query (2 columns)

UNION

SELECT 
FirstName,
LastName
FROM Sales.Employees    --Second query (2 columns)

--3
SELECT 
FirstName,
LastName
FROM Sales.customers  --First query (2 columns)

UNION

SELECT 
FirstName,
EmployeeID
FROM Sales.Employees    --Second query (2 columns)

--5
SELECT 
CustomerID AS ID,
LastName
FROM Sales.customers  --First query (2 columns)

UNION

SELECT 
EmployeeID,
LastName
FROM Sales.Employees    --Second query (2 columns)


--6
SELECT 
LastName,
FirstName
FROM Sales.customers  --First query (2 columns)

UNION

SELECT 
FirstName,
LastName
FROM Sales.Employees    --Second query (2 columns)4

/* UNION : Returns all distinct rowa from both queries.
          Removes duplicate rows from the result.

*/
--Combine the data from employees and customers into one table
SELECT
FirstName,
LastName
FROM Sales.Customers

UNION 

SELECT
FirstName,
LastName
FROM Sales.Employees

--UNION ALL:Returns al rows from both queries , including duplicates
/*  UNION ALL vs THAN UNION :
          UNION ALL is faster than UNION 
          use union all if we are confident there are no duplicates
          use union all for finding duplicates and quality issues

*/

--combine the data from employees and customers into one table including duplicates.
SELECT
FirstName,
LastName
FROM Sales.Customers

UNION  ALL

SELECT
FirstName,
LastName
FROM Sales.Employees

/* EXCEPT(minus) : Returns all distinct rows from the first query 
            that are not found in the second query.
            --Order of the queries affect the final results
            */
--Find the employees who are not customers at the same time

SELECT
FirstName,
LastName
FROM Sales.Employees

EXCEPT

SELECT
FirstName,
LastName
FROM Sales.Customers

--INTERSECT  : Returns only the rows that are column in both queries
--Find the employees  who are also  customers
SELECT
FirstName,
LastName
FROM Sales.Customers

INTERSECT


SELECT
FirstName,
LastName
FROM Sales.Employees

/* Orders are stored in seperate tables (Orders and OrderArchive).
   Combine all orders into one report without duplicates.
   */
   SELECT *
   FROM Sales.Orders
   UNION
   SELECT *
   FROM Sales.OrdersArchive

--BEST PRACTICE : Never use an asterisk(*) to combine tables ; list needed columns instead
SELECT 
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 
    [OrderID]
    ,[ProductID]
    ,[CustomerID]
    ,[SalesPersonID]
    ,[OrderDate]
    ,[ShipDate]
    ,[OrderStatus]
    ,[ShipAddress]
    ,[BillAddress]
    ,[Quantity]
    ,[Sales]
    ,[CreationTime]
FROM Sales.OrdersArchive

--Source Flag :include additional column to indicate the source of each row
--which row is from which table
SELECT 
    'Orders' AS SourceTable
    ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 
    'OrdersArchive' AS SourceTable
    ,[OrderID]
    ,[ProductID]
    ,[CustomerID]
    ,[SalesPersonID]
    ,[OrderDate]
    ,[ShipDate]
    ,[OrderStatus]
    ,[ShipAddress]
    ,[BillAddress]
    ,[Quantity]
    ,[Sales]
    ,[CreationTime]
FROM Sales.OrdersArchive

/* EXCEPT Use caes:
     --Delta Detection:
                new data genereted from source system and inserting into data ware hpuse
     --data completeness check