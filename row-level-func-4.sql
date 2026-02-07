/* CASE Statement : Evaluates a list of conditions and returns a value when the first conditon is true
 syntax : 
    CASE                             --Start of logic
        WHEN  cond1 THEN res1
        WHEN cond2  THEN res2
        ....
        ELSE result
      
    END                              --End of logic

    RULE : The data type of the results must be match
    */

--Use case: 
--Main purpose Data Transformation: Derive new information :creates new cols based on existing data
--Categorize the data : Gropu the data into different categories based on certain conditions
/* Generate a report showing the taotal sales fpr each category
    --High : sal>50
    --medium : sal between 20 and 50
    -- low : sal 20 or less
    sort the categories from highest to lowest*/
SELECT 
Category,
SUM(sales) AS TotalSales
FROM (
SELECT 
OrderID,
Sales,
CASE 
   WHEN sales > 50 THEN 'High'
   WHEN Sales > 20  THEN 'Medium'
   ELSE 'Low'
END Category
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

--Mapping Values: Transform the values from one from to another
--Retrieve employee details with gender displayes as full text
SELECT
*,
CASE 
  WHEN Gender = 'M' THEN 'MALE' 
  WHEN Gender = 'F' THEN 'FEMALE' 
  ELSE 'Not Available'
END FullGender
FROM Sales.Employees

--Retrieve customer country with abbreviated country code
SELECT
* ,
CASE 
  WHEN Country = 'Germany' THEN 'DE'
  WHEN Country = 'USA'     THEN 'US'
  ELSE 'N/A'
END COUNTRYABB
FROM Sales.Customers


SELECT DISTINCT COUNTRY 
FROM Sales.Customers

--If we have many country names then
--QUICK FORM
SELECT
* ,
CASE Country
  WHEN 'Germany' THEN 'DE'
  WHEN  'USA'     THEN 'US'
  ELSE 'N/A'
END COUNTRYABB
FROM Sales.Customers

--NULL values
--Find the average score of customers and treat nulls as 0
SELECT 
CustomerID,
LastName,
Score,
CASE 
   WHEN Score IS NULL THEN 0 
   ELSE score 
END ScoreClean,

AVG(CASE 
      WHEN Score IS NULL THEN 0 
      ELSE score 
    END)  OVER() AvgSoreClean,
AVG(Score) OVER() AvgScore
FROM Sales.Customers

--Conditional Aggregations
--Count  how many times each cutomer has made an oder with sales greater than 30
SELECT 
CUSTOMERID,
SUM(FLAG) as totalorders
FROM(
SELECT 
CustomerID,
CASE 
  WHEN sales > 30 THEN 1 ELSE 0 END Flag
FROM Sales.Orders
)T
GROUP BY CustomerID

SELECT 
CustomerID,
COUNT(*) AS TotalOrders,
SUM(CASE WHEN sales>30 THEN 1 ELSE 0 END) tOTALoRDERS
FROM Sales.Orders
GROUP BY CustomerID


