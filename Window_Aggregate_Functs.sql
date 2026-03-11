--Aggregate window functions : count() , avg() , sum(), max() , min() 

--COUNT() : Retruns the number of rows wiht in a window regardless of the null.
--it allows all data types.

--Find the total number of orders for each product
SELECT
ProductID,
OrderID,
COUNT(*) OVER(PARTITION BY ProductID) OrdersByProducts
FROM Sales.Orders      --if the sales are zero * will count

SELECT
ProductID,
OrderID,
COUNT(Sales) OVER(PARTITION BY ProductID) OrdersByProducts
FROM Sales.Orders

/*  COUNT(*) == count(1)   : counts the total number of woes in a window.
    COUNT(Column) : counts the number of non null values in a column   */


/* USE CASE 1 : 
        OVERALL ANALYSIS :
             Qucik summary or snapshot of the entire data set.   */
--Find the total number of orders
SELECT 
 COUNT(*) TotalOrders
FROM Sales.Orders


/* USE CASE 2 :
       TOTAL PER GROUPS :
           Group wise Analysis to understand patterns wihtin different categories.  */

/* Find the total number of orders,
      additionally prvide the details such order ID , Order Date  */
SELECT 
OrderID,
OrderDate,
COUNT(OrderID) OVER()
FROM Sales.Orders

/* Find the total number of orders,
     Find the total number of orders for each customers
      additionally prvide the details such order ID , Order Date  */
SELECT
OrderId,
OrderDate,
CustomerId,
COUNT(*) OVER() TotalOrders,
COUNT(*) OVER(PARTITION BY customerID ) OrdersByCustomers
FROM Sales.Orders      --once customer has different behaviour among all



--Find the total number of cutomers , additionally provide all details from cutomers
SELECT
*,
COUNT(*) OVER() TotalCustomers
FROM Sales.Customers  --it counted the customer wiht the zero score

SELECT
COUNT(DISTINCT(CustomerId))  as TotalCustomers
FROM Sales.Orders


/*  USE CASE 3:
       DATA QUALITY CHECK :
           Detecting number of NULL by comparing to total number of rows   */

--Find the total number od sccores for the customers
SELECT
*,
Count(Score) OVER() TotalScores
FROM Sales.Customers                  --differnce between above one and below one(1 null )


/*   USE CASE 4 : 
             IDENTIFY DUPLICATES
                  Identify duplicates rows to improve data quality.  */
   
   
--DATA QUALITY ISSUES : Duplicates leads to inaccuracies in analysis
                       -- to identify we can use count

--Check whether the table orders coontains any duplicates rows
--first we have to seee primary key
SELECT
OrderID,
COUNT(*) OVER(PARTITION BY OrderId) ChechPK  --All equal to 1 so no suplicates
FROM Sales.Orders

--for ordersArchive
SELECT
OrderId,
COUNT(*) OVER(PARTITION BY OrderID ) CheckPK   --All are not equal to one hence we have duplicates
FROM Sales.OrdersArchive

--to get the duplicates we use subquery (inner query a query has a windoe func)
SELECT 
OrderId,
CheckPK
FROM (
      SELECT
        OrderId,
        COUNT(*) OVER(PARTITION BY OrderID ) CheckPK   --All are not equal to one hence we have duplicates
      FROM Sales.OrdersArchive
  )t
WHERE CheckPK>1

--SUM() :
/*  Find the total sales across all orders
    Find Total sales for each product
     Additionally provide details suc order 1d , order date   */
SELECT
    OrderId,
    ProductID,
    Sales,
    SUM(Sales) OVER() TotalSales,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders

/* Use Case 1 ; Overall Analysis
   Use case 2 : Group wise analysis 
   USE Case 3 : Comparision 
  */

--Find the percentge contribution of each product sales to the total sales
SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() AS TotalSales,
Sales / SUM(Sales) OVER() * 100 Contribution  --Sales data type is int 
FROM Sales.Orders


SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() AS TotalSales,
ROUND( CAST(Sales AS Float) / SUM(Sales) OVER() * 100,2) Contribution 
FROM Sales.Orders

--Avg() :
/* Find the avg Sales of all Products
     Find the avg sales for each product
     Adsitonaly provide the detaisl suc order id , orderdate
     */

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(Sales) OVER() avgSales,
AVG(SALES) OVER(PARTITION BY ProductID)  AvgByProduct --NULL Sales means zero
FROM Sales.Orders

/* Find the average score of customers
    Additionally provide details such as CustomerID, and Last Name
    */
SELECT
*
FROM Sales.Customers

SELECT
CustomerID,
LastName,
AVG(ISNULL(Score,0)) OVER() AvgScore
FROM Sales.Customers

/* Find all customers  where scores are higher thant the avg sscores across all customers  */
SELECT
*
FROM(
        SELECT
            CustomerID,
            LastName,
            Score,
            ISNULL(Score,0) as CustomerScore,
            AVG(ISNULL(Score,0)) OVER() AvgScore
        FROM Sales.Customers
        )T
WHERE CustomerScore>AvgScore

--Find all orders where sales are higher than the avg sales across all orders

SELECT
*
FROM (
       SELECT
            OrderID,
            OrderDate,
            Sales,
            AVG(Sales) OVER() AvgSales
       FROM Sales.Orders)T
WHERE Sales> AvgSales


--MIN() 
--Find the LOWEST sales of each product
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MIN(Sales) OVER() MinSale,
MIN(Sales) OVER(PARTITION BY ProductID) MinSaleByProduct
FROM Sales.Orders

--MAX()
--Find the HIGHEST sales of each product
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() MaxSale,
MAX(Sales) OVER(PARTITION BY ProductID) MaxSaleByProduct
FROM Sales.Orders

--Show the employee with the highest salary
SELECT
    EmployeeID,
    FirstName,
    Salary,
    HighestSalary
FROM (
        SELECT
            *,
            MAX(Salary) OVER() HighestSalary
        FROM Sales.Employees
        )T
WHERE Salary = HighestSalary

--Calculate the deviation of each sale form both the min and max sale amounts
SELECT
   OrderID,
   OrderDate,
   ProductID,
   Sales,
   MIN(Sales) OVER() lowestsale,
   MAX(Sales) OVER() highestSale,
   Sales - MIN(Sales) OVER() DeviationFromMin,
   MAX(Sales) OVER() -  Sales DeviationFromMax
FROM Sales.Orders

--===============================================================================================================

/* IMP Use of aggregate func : RUNNING & ROLLING TOTAL  :(Analysis over time)
                  They aggregate sequence of numbers , and the aggregation is updated each time a new number is added.
                                             Tracking : tracking current sales with target sales  
                                             Trend Analysis : Providing insights into historical patterns
                               Running total : Aggregate all values from the beginning up to the current point wihtou droping off older data.
                               Rolling total : Aggregate all values wiht in a fixed time window as new data is addeed , the oldest data point will be dropped.
                                           */
--Calculate moving avg of sales for each product over time
SELECT
OrderID,
OrderDate,
Sales,
ProductID,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProd,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate )  MovingAvg
FROM Sales.Orders

--Calculate moving avg of sales for each prod over time including the next order
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProd,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate 
    ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING )  MovingAvg
FROM Sales.Orders

