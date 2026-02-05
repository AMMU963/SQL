
--Date and Time Functions: 

--DATE (yyyy-mm-dd)
--TIME (hh:mm:ss)
--DATETIME2(DATE AND TIME)

--Date & Time Values
--DATE Column from a table
SELECT 
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime
FROM Sales.Orders

--Hardcoded  Constant String Value
SELECT 
    OrderID,
    CreationTime,
    '2025-08-28' HardCoded  --static value
FROM Sales.Orders

--GETDATE() : returns the current date and time at the moment when the query is executed.
SELECT 
    OrderID,
    CreationTime,
    GETDATE() today  --this moment date
FROM Sales.Orders

/* Date & Time Function Overview
     Part Extraction           Format & Casting          Calculation        Validation
     -DAY                        -FORMAT                  -DATEADD            -ISDATE
     -MONTH                      -CONVERT                 -DATEDIFF
     -YEAR                       -CAST
     -DATEPART
     -DATENAME
     -DATETRUNC
     -EOMONTH
--manipulation(part extraction,chaging format,Date calculation,validation)
*/

--===================================================================================================================
--PART EXTRACTION
--DAY : returns day from a date 
--MONTH : return month from a date
--YEAR  : returns yeare from a date

SELECT 
CreationTime,
DAY(CreationTime) AS Day,
MONTH(CreationTime) AS Month,
YEAR(CreationTime) AS Year
FROM Sales.Orders

--DATEPART() :returns a specific part of a date as a number
SELECT 
    GETDATE() as today,
    DATEPART(YY , GETDATE()) AS YEAR,
    DATEPART(MM , GETDATE()) AS Month,
    DATEPART(DD , GETDATE()) AS Date,
    DATEPART(HH , GETDATE()) AS Time,
    DATEPART(MI , GETDATE()) AS Minute,
    DATEPART(SS , GETDATE()) AS Second,
    DATEPART(WEEK , GETDATE()) AS weeknumber,
    DATEPART(WEEKDAY , GETDATE()) AS day_of_week_1_7,  --default sunday is 1 
    DATEPART(QQ , GETDATE()) AS Quarter  --12/4 

--SET DATEFIRST 1;  MONDAY=1
--YEAR abbrevation YY , MM , SS , HH , SS , MI(MINUTE) , WEEK , WEEKDAY , QUARTER ARE THE PARTS

SELECT 
    OrderID,
    CreationTime,
    DATEPART(YY , CreationTime) AS Year,
    DATEPART(MM , CreationTime) AS Month,
    DATEPART(DD , CreationTime) AS Date,
    DATEPART(HH , CreationTime) AS Hour,
    DATEPART(MI , CreationTime) AS Minute,
    DATEPART(SS , CreationTime) AS Second,
    DATEPART(WEEK , CreationTime) AS Week_number,
    DATEPART(WEEKDAY , CreationTime) AS week_day,
    DATEPART(QUARTER, CreationTime) AS Quarter
FROM Sales.Orders

--DATENAME() : Returns the string of a specific part of a date
 SELECT 
     GETDATE() AS Today,
     DATENAME(YY ,GETDATE()) AS Year,
     DATENAME(MM , GETDATE()) AS Month_name,  --main use case
     DATENAME(DD , GETDATE()) AS Date,        
     DATENAME(WEEK , GETDATE()) AS week_number,
     DATENAME(WEEKDAY , GETDATE()) AS Day,          --main use case
     DATENAME(QUARTER , GETDATE()) AS Quarter
--output  always strings

SELECT 
    OrderID,
    CreationTime,
    DATENAME(MM , CreationTime) AS Month_name,
    DATENAME(WEEKDAY , CreationTime) AS day
FROM Sales.Orders  

--DATETRUNC : Truncates the date/time valueto a specificed level.
--Brings the date back to the beginning of that unit.

SELECT 
    OrderID,
    CreationTime,    
    DATETRUNC(MI , CreationTime) as minute_dt,
     DATETRUNC(HH , CreationTime) as hour_dt
FROM Sales.Orders

SELECT 
    OrderID,
    CreationTime,    
    DATETRUNC(DD , CreationTime) as day_dt,
    DATETRUNC(MM  , CreationTime) as month_dt,
    DATETRUNC(YY , CreationTime) as year_dt
FROM Sales.Orders

--Why datetrunc is useful in data analysis
SELECT
CreationTime,
COUNT(*)
FROM Sales.Orders
GROUP BY CreationTime

--in the month level  
SELECT
DATETRUNC(MM,CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(MM,CreationTime)

--in the year level
SELECT
DATETRUNC(YY,CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(YY , CreationTime)

--EOMONTH() - returns end of the month
SELECT EOMONTH(GETDATE())

SELECT
    OrderID,
    CreationTime,
    EOMONTH(CreationTime) as EndOfMonth,
    DATETRUNC(MM , CreationTime) AS StartOfMonth, --return the same datatype
    CAST(DATETRUNC(MM , CreationTime)  AS DATE) AS StartOfMonth,
    DATETRUNC(MM,EOMONTH(CreationTime)) as StartOfMonth
FROM Sales.Orders


--USE CASES OF DATA EXTRACTION 

--AGGREGATIONS
--How many orders are placed each year
SELECT 
DATETRUNC(YY , CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(YY , CreationTime)

SELECT
YEAR(CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY YEAR(CreationTime)

--How many orders are placed each mONTH
SELECT
MONTH(CreationTime),
COUNT(*) AS numOrders
FROM Sales.Orders
GROUP BY MONTH(CreationTime)

SELECT   --MONTH NAME
DATENAME(MM , CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATENAME(MM , CreationTime)

--DATA FILTERING
--Show all oders that were placed during the month of feb
SELECT 
OrderID,
CreationTime
FROM Sales.Orders
WHERE DATENAME(MM , CreationTime) = 'February'

SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2;

--BEST PRACTICE : filtering data using an integer is faster than using a strig
 --Avoid using DATENAME fir filtering data , instead use DATEPART

 --FUNCTION COMPARISION
--for date month use DAY() , MONTH()
--for names of month and day use DATENAME()
-- for year use YEAR()
-- for other parts use DATEPART()

--===================================================================================================================


--FORMAT AND CASTING
/* DATE FORMAT :
        YYYY - MM - dd HH : mm : SS (case sensitive)
     format specifier-
     date and time format

     international standard - yyyy-mm-dd(my sql server standard)
     european               - dd-mm-yyyy
     usa                    - mm-dd-yyyy

     */

/* FORMATING: changing the format of a value one to another.
              changing how the data looks.
      
       yyyy-mm-dd 2025-08-20 (FORMAT) mm/dd/yyyy  08/20/2025
                                      mmm  yyyy   Aug 2025
                             (CONVERT) 6          20 Aug 25
                                       112        20250820
      NUMBER 1234567.89  FORMAT  N   1,234,567.89
                                 C   $1,234,567.89
                                 P    123,456,789.00%
*/

/* CASTING : change data types
     STRING '123' to NUMBER 123
     DATE to STRING
     STRING to DATE
CAST()
CONVERT()
*/

/* FORMAT() : formats a date or time value
   syntax : FORMAT(value , fromat [,culture](optional))
   always date(small), year(small) , MM 
   deafult culture is 'en-us'
   */

SELECT 
    OrderID,
    CreationTime,
    FORMAT(CreationTime,'dd') dd,
    FORMAT(CreationTime,'ddd') ddd,
    FORMAT(CreationTime,'dddd') dddd
FROM Sales.Orders

SELECT
    OrderID,
    CreationTime,
    FORMAT(CreationTime , 'MM') mm,
    FORMAT(CreationTime , 'MMM') mmm,
    FORMAT(CreationTime , 'MMMM') mmmm
FROM Sales.Orders

--To USA format
SELECT 
    OrderID,
    CreationTime,
    FORMAT(CreationTime , 'MM-dd-yyyy')  USA_format,
    FORMAT(CreationTime , 'dd-MM-yyyy')  ERP_format
FROM Sales.Orders

/* Show Creation Time usinf the following fromat:
            Day Wed Jan Q1 2025 12:34:56 PM
 */

 SELECT 
     OrderID,
     CreationTime,
     'Day ' + FORMAT(CreationTime ,'ddd MMM') +
     ' Q' + DATENAME(QQ , CreationTime) +' '+
     DATENAME(YY , CreationTime) +
     FORMAT(CreationTime , ' hh:mm:ss') + ' PM'  CustomeFromat
 FROM Sales.Orders

 --Use case of FORMAT
  --DATA STANDARDIZATION
 --DATA AGGREGATIONS
 SELECT
 FORMAT(OrderDate,'MMM yy') OrderDate,
 count(*) 
 FROM Sales.Orders
 GROUP BY FORMAT(OrderDate,'MMM yy')

 --CONVERT() : Converts a date or time value to a different data type & fromat the values
 SELECT
 CONVERT(INT , '123') AS [string to Int CONVERT],
 CONVERT(DATE , '2025-08-20') AS [string to Date CONVERT],  
 CreationTime,
 CONVERT(DATE , CreationTime) AS [Datetime to Date CONVERT]  --fromating
 FROM Sales.Orders


 SELECT
 CONVERT(VARCHAR , CreationTime , 32) AS [USA std. style:32],
  CONVERT(VARCHAR , CreationTime , 34) AS [ERUO std. style:34],  --Casting 
  CreationTime,
 CONVERT(DATE , CreationTime) AS [Datetime to Date CONVERT]
 FROM Sales.Orders

/* CAST() : change one data type to another
   syntax: CAST(value AS data_type)
   no format is specified
   */
SELECT
CAST('123' AS INT) AS [String to INT],
CAST(123 AS VARCHAR) AS [INT to String],
CAST('2025-8-23' AS DATE) AS [String to Date],
CAST('2025-8-23' AS DATETIME2) AS [String to Date],
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders

--===================================================================================================================


--CALCULATIONS :
/* DATEADD() : Add or subtracts a specific time interval to/from a date.
        syntax : DATEADD(part , interval , date)
        */
SELECT
    OrderDate,
    DATEADD(YEAR , 2 , OrderDate) [2 years a head],
    DATEADD(MM , 2  , OrderDate) [2 months a head],
    DATEADD(DD , -10 , OrderDate ) [10 days before] ,
    DATEADD(YYYY , -2 , OrderDate) [2 years before]
FROM Sales.Orders

/* DATEDIFF() :find differences between 2 days
   syntax: DATEDIFF( part , start_date , end_date)
   */

SELECT
OrderDate,
ShipDate,
DATEDIFF(YYYY ,OrderDate , ShipDate) [dif b/w order and shipping date],
DATEDIFF(DD ,OrderDate , ShipDate)
FROM Sales.Orders

SELECT 
DATEDIFF(yyyy , BirthDate , GETDATE()) age_of_employee
FROM Sales.Employees

--Find average shipping duration in days for each month
SELECT
MONTH(orderDATE) AS OrderDATE,
AVG(DATEDIFF(DD, OrderDate , ShipDate))  avgday2ship
FROM Sales.Orders
GROUP BY MONTH(orderDATE) 

--Time Gap Analysis
--Find the number of days between each order and previous order
SELECT
OrderID,
OrderDate CurrentOrderDATE,
LAG(OrderDate) OVER  (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(day , LAG(OrderDate) OVER  (ORDER BY OrderDate) ,OrderDate)  numOfDays
FROM Sales.Orders


--==================================================================================================
--Validation:
/* ISDATE() : check if a value is a date.
              returns 1 if the string value is a valid date.
    syntax: ISDATE(value) 
    */

SELECT 
ISDATE('2026-10-28'),
ISDATE('2025'),
ISDATE('12'),
ISDATE(2025),
ISDATE(123),
ISDATE('2030-23-12'),
ISDATE(12)

SELECT '2025-08-23' AS OrderDate UNION
SELECT '2025-08-20' UNION
SELECT '2025-08-15' UNION
SELECT '2025-08'

--if we want the above info in one table
SELECT 
CAST(OrderDate AS Date) OrderDate
FROM 
(
    SELECT '2025-08-23' AS OrderDate UNION
    SELECT '2025-08-20' UNION
    SELECT '2025-08-15' UNION
    SELECT '2025-08'
)t

--throw error  because last date has no correct format
SELECT 
  OrderDate,
--CAST(OrderDate AS Date) OrderDate
  ISDATE(OrderDate) ,
  CASE WHEN ISDATE(OrderDate) = 1 THEN   CAST(OrderDate AS DATE)
  END NewOrderDate
FROM 
(
    SELECT '2025-08-23' AS OrderDate UNION
    SELECT '2025-08-20' UNION
    SELECT '2025-08-15' UNION
    SELECT '2025-08'
)t
WHERE ISDATE(OrderDate) = 0

--Instead of null we can use any other dummy date
SELECT 
  OrderDate,
  ISDATE(OrderDate) ,
  CASE WHEN ISDATE(OrderDate) = 1 THEN   CAST(OrderDate AS DATE)
       ELSE '9999-01-01'
  END NewOrderDate
FROM 
(
    SELECT '2025-08-23' AS OrderDate UNION
    SELECT '2025-08-20' UNION
    SELECT '2025-08-15' UNION
    SELECT '2025-08'
)t

