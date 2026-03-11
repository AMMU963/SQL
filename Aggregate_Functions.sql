/* Aggregate  Functions: Accepts multiple rows and return single value
                    --SUM()
                    --AVG()
                    --COUNT()
                    --MIN()
                    --MAX()
                    */
--Find the total number of orders
SELECT  
COUNT(*) AS Total_Orders
FROM Orders

--Find the total sales of all orders
SELECT
SUM(Sales) as Total_Sales
FROM Orders

--Find the avg sales of all orders
SELECT
AVG(SALES) as Avg_Sales
FROM Orders

--Find the highest sales of all orders
SELECT
MAX(Sales) as Highest_Sales
FROM Orders

--Find the lowest sales of all orders
SELECT
MIN(Sales) as Lowest_Sales
FROM Orders

--Analyzing the scores in cutomer table
SELECT *
FROM Customers

--Find the total number of cutomers
SELECT
COUNT(*) Total_nr_customers
FROM Customers
   
--Find the total score
SELECT
SUM(Score) as Total_Score
FROM Customers

--Find the avg score of all customers
SELECT
AVG(Score) as Avg_Score
FROM Customers

--Find the higest score among all customers
SELECT
MAX(Score)
FROM Customers

--Find the loewst score among the all customers
SELECT
MIN(Score)
FROM Customers

--Find the score of each country
SELECT
SUM(Score) ,
country
FROM customers
GROUP BY country

