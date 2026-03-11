/* Window Functions or Analitical Functions:  Agggregations + details
         Aggregate            Rank             Values
         COUNT()           ROW_NUMBER()
         SUM()             RANK()
         AVG()             DENSE_RANK() 
         MIN()             CUME_DIST()
         MAX()

         */
/*  Group by --returns single row for each grp(changes the granuality)
    Window  --  no of rows = query result rows  (granuality stays same)
*/

-- Why we need window functions? Why group by is not enough?
--Find the total Across all orders
SELECT
Sales
FROM Sales.Orders

SELECT
SUM(Sales) Total_Sales
FROM Sales.Orders

--Find total Sales for each product.
SELECT 
    ProductID,
    SUM(Sales)
FROM Sales.Orders
GROUP BY  ProductID  --the no of rows in the output defined by the dimension of group by col

/* Find total sales for each product,
    additionally provide detail such order id & order date. */
SELECT 
   OrderId,
   OrderDate,
   ProductID,
   SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID  --All columns in SELECT must be included in GROUP BY or AGGREGATION

SELECT 
   OrderId,
   OrderDate,
   ProductID,
   SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID,
         OrderId,
        OrderDate    --OrderID is unique

--Solutions is window functions
SELECT 
    SUM(Sales) OVER()  TotalSales   -- high level execution.
FROM Sales.Orders                   -- Window func returns the result for each row

SELECT
    ProductID,   
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

SELECT 
   OrderId,
   OrderDate,
   ProductID,
   SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

/*  Window Syntax :
        Window Func    Over Clause (partition clause, order clause , frame clause)
        

  window functions:
        --aggregate functions   all data types
        --rank functions        all are empty except ntile() numeric
        --value functions       all data types
  over clause :
        --Tells SQL that the func used is a Window Func
        --It defines a window or subset of data
     Partition by : divides the dataset into windows(partitions)
           --optional for all window func
     order by : sort the data with in a window(asc | desc)
           --optional only for aggregate functs
     frames : Defines 
     */

/* RULES :
      --Windows functions csn be used only in select and order by
      --Nested Window Functions are not allowed.
      --SQL execute WINDOW functions after WHERE Clause
      -- Window func can be used together with GROUP BY in the same query , ONLY if the same Columns are used
      */


/* Find the total sales across all orders,
     additionally provide such order id & order date. */
--cal is done on entire data set
SELECT                      --without partition by 
   OrderID,
   OrderDate,
   SUM(Sales) OVER() TotalSales
FROM Sales.Orders



/*Find the total sales for each product,
    additionally provide detail such order id & order date */
--cal is done individually on each window
SELECT                     --partition by single column
    OrderID,
    OrderDate,
    ProductID,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts   -- divided into 4 windows
FROM Sales.Orders


/* Find the total sales across all orders,
    Find the total sales for each product,
    additionally provide detail such order id & order date */
SELECT                      
   OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER() TotalSales,       --one single window(Highest level og aggregation)
    SUM(Sales) OVER(PARTITION BY ProductID)  TotalSalesByProducts
FROM Sales.Orders



/* Find the total sales for each combination
   of product and order status */
SELECT                    --Partition by combined columns
   OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(PARTITION BY ProductID)  TotalSalesByProducts,    -- divided into 4 windows
    SUM(Sales) OVER(PARTITION BY ProductID , Orderstatus) SalesByProductAndStatus   --didivded inyo 5 windows
FROM Sales.Orders

--Rank the orders accoring to there sales.
SELECT 
OrderID,
OrderDate,
Sales,
RANK() OVER( ORDER BY sales ) Order_Sales
FROM Sales.Orders

--Rank the sales in date 
SELECT 
OrderID,
OrderDate,
Sales,
RANK() OVER( PARTITION BY OrderID ORDER BY Sales) 
FROM Sales.Orders

/* Rank each order based on their sales from high to low 
    additionally provde the details such order id , order date*/
SELECT 
OrderID,
OrderDate,
Sales,
RANK() OVER( ORDER BY sales  DESC ) Rank_Sales
FROM Sales.Orders

/* Window Frame Clause : 
  defining a subset of rows within in each window  that is relevent for the calculation.
       frame type BETWEEN frame lower boundary AND frame higher boundary

       frame type           : rows , range
       frame lower boundary : current row , n preceding(nth row before the current row)    , unbounded preceding(first row of a window)
       frame upper boundary : current row , n following ,  unbounded following(last row of a window)

--frame clause can only used together wiht order by clause
 --if we use order by then the default frame is used.
 compact frame : for only PRECEDING , the current can be skipped
 
 NOTE : order by always uses a frame
*/

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales
FROM Sales.Orders

--the deafalut frame is used ,with only order by
-- by default it calculates cumulative sales
SELECT 
OrderID,
OrderDate,
Sales,
SUM(Sales) OVER( ORDER BY Sales )
FROM Sales.Orders

--the frame is
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS TotalSales
FROM Sales.Orders


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus  ORDER BY Sales)
FROM Sales.Orders  --total devileverd 135  , shipped 155

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus)
FROM Sales.Orders 


--Compact frame
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ORDER BY OrderDate
ROWS UNBOUNDED  PRECEDING)
FROM Sales.Orders

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ORDER BY OrderDate
ROWS 2 PRECEDING)
FROM Sales.Orders

--RULE 1: Window func should be used only in SELECT and ORDER BY
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ) TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER(PARTITION BY orderstatus ) DESC

--cannot used to filter the data
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus ) TotalSales
FROM Sales.Orders
WHERE SUM(Sales) OVER(PARTITION BY orderstatus ) > 200

--RULE 2 : Nested window funcs are not allowed!
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(SUM(Sales) OVER(PARTITION BY orderstatus )) OVER(PARTITION BY orderstatus ) TotalSales
FROM Sales.Orders

--RULE 3: SQL execute Window Func  after WHERE clause
/* Find the total sales for each order status 
    only for two products 101 and 102 */
SELECT
OrderID,
OrderDate,
OrderStatus,
ProductID,
Sales,
SUM(Sales) OVER(PARTITION BY orderstatus)  TotalSales
FROM Sales.Orders
WHERE ProductID IN ( 101 , 102)

/*  RULE 4: 
        Window fucn can be used together vth GROUP BY in the same query,
           ONLY if the same colums are used.
           */
--Rank the customers based on their total Sales
--first build the query using gp by then  use the same column  in window func
SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID   --here the aggregate func i used to group by same is used insnde the window func

SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY CustomerID DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID




  