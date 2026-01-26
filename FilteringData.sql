/* Filtering data :
           -WHERE Clause

*/
/*
  WHERE operators: 
      comaprision : = , <> (!=) , > , < , >= , <= 
      logical     : AND , OR , NOT 
      Range       : BETWEEN
      Membersip   : IN , NOT IN (CHECK IF THE EXISTS IN LIST OR NOT)
      Search      : LIKE (search for a patterns)

      */

--Retrieve all customers from germany
SELECT * 
FROM customers
WHERE country = 'Germany';

--Retrieve all the customers who are not from the germany
SELECT * 
FROM customers
WHERE country <> 'Germany';

SELECT * 
FROM customers
WHERE country != 'Germany';

--Retrieve all customers with a  score greater than 500
SELECT * 
FROM customers
WHERE score > 500;

--Retrieve all customets with a score 500 or more
SELECT * 
FROM customers
WHERE score >= 500;

--Retrieve all customers with a score less than 500
SELECT * 
FROM customers
WHERE score < 500;

--Retreive all customers with a score 500 or less.
SELECT * 
FROM customers
WHERE score <= 500;


/* Retrieve all customers who are from the USA 
   and have a score greater than 500  */
SELECT * 
FROM customers
WHERE country = 'USA' AND SCORE > 500;

/* Retrieve all customers who are from the USA 
   OR have a score greater than 500  */
SELECT * 
FROM customers
WHERE country = 'USA' OR score > 500;

-- Retrieve all customers with a score not less than 500
SELECT *
FROM customers
WHERE NOT score < 500

--Retrieve all cutomers whose score falls in the range between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;  -- BOTH ARE INCLUSIVE

SELECT *
FROM customers
WHERE score >= 100 AND score <= 500

-- Retrieve all customers from either germany or usa
SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA';

SELECT *
FROM customers
WHERE country IN ('Germany' , 'USA');

--Retrieve all cutomers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

--Retrieve all cutomers whose first name end with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n';

--Retrieve all cutomers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%'

--Retrieve all cutomers whose first name has 'r' in the third position
SELECT *
FROM customers
WHERE first_name LIKE '__r%'

