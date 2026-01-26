USE MyDatabase
-- This is a inline comment

/* this is a 
multi line 
comment
*/

--=========================================================================
/*
SQL QUERY Claues:
		SELECT
		DISTINCT
		TOP
		FROM
		WHERE
		GROUP BY
		HAVING
		ORDER BY
*/


--=========================================================================

--sql is not a case sensitive

--Retrive all the coumns from customers table
SELECT *
FROM customers;   --execution start from from clause 

--Retrive all the order data
Select *
from orders;

--Retriving only few columns
SELECT id,first_name
FROM customers;

--Retrieve each customer's name , country , and score
SELECT            --2
	first_name ,  -- the columns will be in the order exctly u metioned in the query
	country ,  
	score
FROM customers;   --1



--=========================================================================

--DISTINCT - remove duplicates

--Return unique list of all countries
SELECT 
	DISTINCT(country)
FROM customers;

--=========================================================================

--TOP Clause (Limit)  - how many rows we neef to see in the result

--Retrieve only 3 customers
SELECT TOP 3 * 
FROM customers;

--Retrieve the top 3 customers with highest scores
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

--Retrieve the lowest 2 customers based on the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

--Get the two most recent orders
SELECT TOP 2 * 
FROM orders
ORDER BY order_date DESC;

--=========================================================================

--WHERE Clause -  filter data based on a condition

SELECT *          --3
FROM customers    --1
WHERE score>500;  --2

--Retrieve customers with a score not equal to 0
SELECT *          --3
FROM customers    --1
WHERE score != 0;   --2

--Retrieve cutomers from Germany
SELECT *					--3
FROM customers              --1
WHERE country = 'Germany';  --2    --String '' commas

SELECT 
	first_name,
	country
FROM customers
WHERE country = 'geRmany';  

--=====================================================================
/*
	GROUP BY Clause - combines rows with the same value
					- aggregate a column by another column
						ex: total score by each country
					*/

--Find the total score by each country
SELECT 
	country,
	SUM(score)  AS  total_score  --AS(alias) shorthand name given to column in a query optional
FROM customers
GROUP BY country;

--the columns  in the select must be either aggregrated or included in group by 
/*
SELECT
	first_name ,  --this should not be the part
	country,
	SUM(score)
 FROM customers
 GROUP BY country */  -- this will throw error

 --the result of the group by determined by the unique values of the grouped columns
SELECT 
	country,
	first_name,
	SUM(score)
FROM customers
GROUP BY country,first_name;  --so here first_name is unique


--Find the total score and total number of customers for each country
SELECT 
	country,
	SUM(score),
	COUNT(id) as total_cust
FROM  customers
GROUP BY country;

--Having Clause -filter data after aggregation
/*  Find the score each country 
     where score of each country is greater than 800.
	 */
SELECT 
	country,
	SUM(score)
FROM  customers
GROUP BY country
HAVING SUM(score)>800;

/*    Find the average score for each country
	  considering only customer with a score not equal to 0
	  and return only those countries wiht and average score greater than 430.
*/

SELECT 
  country,
  AVG(score)  avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score)>430;
--=========================================================================

--ORDER BY Clause  - sort data  asc (default) , desc

/*Retrieve all the customers
	sort the results by the highest score first. */
SELECT * 
FROM customers
ORDER BY score DESC;

/*Retrieve all the customers
	sort the results by the lowest score first. */
SELECT *
FROM customers
ORDER BY score ASC;


--Nested ORDER BY   --when we have duplicates(repitions) then it is useful
/* Retrieve all customers and 
	 sort the results by the country
		 and then by the highest score.  */

SELECT * 
FROM customers
ORDER BY 
	country ASC ,
	score DESC ;

--=========================================================================

/* CODING ORDER :
			SELECT DISTINCT TOP num
			   col1,
			   SUM(col2)
			FROM table_name
			WHERE cond
			GROUP BY col1
			HAVING SUM(col2)>30 cond
			ORDER BY col1 asc;

 EXECUTION ORDER:
			 FROM 
			 WHERE
			 GROUP BY
			 HAVING
			 SELECT DISTINCT
			 ORDER BY
			 TOP
*/

--=========================================================================

--Static values -fixed values user interested vslues
SELECT 124 AS Static_value;

SELECT 'VIKHITHA' AS Static_String

SELECT 
id,
first_name, 
'New Customer' AS customer_type
FROM customers;

--Highlight and execute
SELECT *
FROM customers
WHERE country = 'Germany'

SELECT *
FROM orders

