/* Value Funcs : Compare values (current row vs another row)
     LAG(exp , offset , default)   partition optional , order by requires , frame not allowd
     LEAD(exp , offset , default)  partition optional , order by requires , frame not allowd
     FIRST_VALUE(exp)              frame optional
     LAST_VALUE()                  frame should be used
     */

/* Use case 1 : Time Series Analysis
            2 : Customer Retenntion Anaysis
            */



/* Analyze the month over month(MOM) perfomace by finding the percentage change
   in sales b/w the current and previous month. */  
SELECT
OrderID,
DATENAME(MM,OrderDate) OrderMonth,
Sales,
LAG(Sales,1,0) OVER(ORDER BY Month(OrderDate))
FROM Sales.Orders

SELECT*,
CurrentMonthSales - PreviousMonthSales MOM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales ) AS FLOAT)/ PreviousMonthSales *100,2) MOM_chage_per
FROM(
SELECT
   MONTH(OrderDate) OrderMonth,
   SUM(Sales) CurrentMonthSales,
   LAG(SUM(Sales) ) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate))T


/* Inorder to analyze customer loyality, rank customers
    based on the AVG days between their orders  */

SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
ROW_NUMBER() OVER(ORDER BY ISNULL(AVG(DaysUntilNextOrder),999999)) RankAvg
FROM(
    SELECT
    OrderID,
    CustomerID,
    OrderDate  CurrentOrder,
    LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrderDate,
    DATEDIFF(dd,OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
    FROM Sales.Orders
)T
GROUP BY CustomerID

--FIRST_VALUE && LAST_VALUE 
--Find the lowest and highest sales for each product
SELECT
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
    LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSalary,
    FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSales,
    MAX(Sales) OVER(PARTITION BY ProductID) HighestSales
FROM Sales.Orders


