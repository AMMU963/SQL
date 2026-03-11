/* Window Rank Function :
    Integer Based Ranking            Percentage Based Ranking
    (1 to N ) Discrete values       ( 0 to 1) continuous(normalized) values

  Top/Bottom N Analysis              Distribution Analysis
  ROW_NUMBER()                         CUME_DIST()
    RANK()                            PERCENT_RANK()
    DENSE_RANK()
    NTILE(N)

    no expression , Partition by is optional,order by is must , frame clause is not allowd

    */

--Integer Based Ranking
--ROW_NUMBER() : Assign a unique number to each row , doesnt handle ties
--Rank the orders based on their sales from high to low
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders

--Rank() : Assign a rank to each row , handle ties, it leaves gaps
--Rank the orders based on their sales from high to low
SELECT
OrderID,
ProductID,
Sales,
RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders

--DENSE_RANK() : Assign rank to each row , handles ties , it does not leave gaps
--Rank the orders based on their sales from high to low
SELECT
OrderID,
ProductID,
Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders

/* Use case 1: Top N Analysis
            2: Bottom N Analysis
            3: Generate Unique ids
            4: Identify Duplicates
*/
--Find the top highest sales for each product
SELECT *
FROM(
    SELECT
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesRank
    FROM Sales.Orders) t
WHERE SalesRank=1;

--Find the lowest two customers based on their sales
SELECT TOP 2
CustomerID,
SUM(Sales) TotalSales,
ROW_NUMBER() OVER(ORDER BY SUM(Sales) ) AS Rank_
FROM Sales.Orders
GROUP BY CustomerID

--Assign unique IDS to rows of Orders Archive Table
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID) UniqueID,
*
FROM Sales.OrdersArchive

--Paginating : divinding the data set into smaller chuncks
--Identify supicates rows in the table 'order Archive and return clean result
SELECT
*
FROM Sales.OrdersArchive  --we have duplicates so we see timestamp


SELECT *
FROM(
SELECT
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
*
FROM Sales.OrdersArchive)T
WHERE rn = 1;

--NTILE(n) : divides the rows into specified number of BUCKETS(approximately eaqual gps)
SELECT
OrderID,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket
FROM Sales.Orders

/* Use Case 1: Data Segmentation(divides a dataset into subsets based on a criteria)
            2:  Equilization load proccessing
            */
--Segment all orders into 3 categories : high , low , medium sales
SELECT
*,
CASE 
    WHEN Buckets = 1 THEN 'High'
    WHEN Buckets = 2 THEN 'Medium'
    ELSE 'Low'
END   SalesSegmentation
FROM(
SELECT
 OrderID,
 Sales,
NTILE(3) OVER(ORDER BY Sales DESC) Buckets
FROM Sales.Orders)T

--Inorder to export the data divide the order into 2 gps
SELECT
NTILE(2) OVER(ORDER BY OrderID) Buckets,
*
FROM Sales.Orders

--Percentage based ranking func
--CUME_DIST() : cal the distrb of data points vth in a window  = position num / rows , inclusive
--PERCENT_RANK() : cal realative position of each row  = p -1 / r - 1 , exclusive

--Find the products that fall within the highest 40% of the prices
SELECT
*,
concat(DistRank * 100,'%') DistRankPer
FROM(
SELECT
Product,
Price,
CUME_DIST() OVER (ORDER BY Price DESC) DistRank
FROM Sales.Products)T
WHERE DistRank <= 0.4