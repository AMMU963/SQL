/* Function : accpet input and process it and return output
   1. Single Row Function  ex: upper()
   2. Multiple Row Function(Aggregations)   ex: sum()
   */

-- Nested Function: Function inside a function.

--Single Row Functions:
/* 1.String Funtion: 
     Manipulation             Calculation          String Extraction
      -CONCAT                     -LEN               -LEFT
      -UPPER                                         -RIGHT
      -LOWER                                         -SUBSTRING
      -TRIM
      -REPLACE
*/

--CONCAT : combine multiple strings into one val
--Concatenate first name and country into one column
SELECT CONCAT(CONCAT(first_name , ' ') , country)
FROM customers;

SELECT CONCAT(first_name , ' ' , country)
FROM customers

SELECT first_name || ' ' || country
FROM customers

--UPPER : coverts all chars to uppercase
--LOWER : converts all chars to lowercase

--Convert the first name to lowercase
SELECT 
first_name,
LOWER(first_name) as low_name
FROM customers

--Convert the first name to uppercase
SELECT 
    first_name,
    LOWER(first_name) as low_name,
    UPPER(first_name) AS cap_name
FROM customers

--TRIM : removes leading anf trailing spaces
--Find customers whose first name contains leading and trailing spaces
SELECT 
    first_name,
    LEN(first_name) len_name,
    LEN(TRIM(first_name)) len_trim_name,
    LEN(first_name) -   LEN(TRIM(first_name))
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name))

--WHERE first_name != TRIM(first_name)

--REPLCAE : replace a specific char wiht a new char
--Remove dashes from a phone number
SELECT 
    '123-456-789' AS phone_num,
    REPLACE('123-456-789','-','')

SELECT 
    '123-456-789' AS phone_num,
    REPLACE('123-456-789','-','/')

--Replcaing the format of a files
SELECT
    'report.txt' as old_filename,
    REPLACE('report.txt','txt','csv') as new_filename

--LEN : counts hoe many chars(string,num,date)
SELECT 
    'Vikhitha Reddy' as name,
    LEN('Vikhitha Reddy') AS len_name

SELECT 
    123 as num,
    LEN(123) as len_num

SELECT 
  '123-456-789' AS phone_num,
  LEN('123-456-789') as len_phonenum

--Calculate the length of each customer first_name
SELECT 
  first_name,
  LEN(first_name) as len_firstname
FROM customers

--LEFT : Extracts specific num of chars from the start
--RIGHT : Extracts specific num of chars from the end
SELECT 
   '123-456-789' as phone_num,
   LEFT('123-456-789',2) AS first_two_chars

SELECT 
   '123-456-789' as phone_num,
   RIGHT('123-456-789',2) AS last_two_chars

--Retrieve the first two chars of each first_name
SELECT 
    first_name,
    LEFT(TRIM(first_name),2) as first_two_chars
FROM customers

--Retrieve the last two chars of each first_name
SELECT 
first_name,
RIGHT(first_name,2) as last_2_chars
FROM customers;

--SUBSTRING : Extracts a part of a string at a specified position(val,start,len)
--Retrieve a list of customers first name removing the first char
SELECT
first_name,
SUBSTRING(TRIM(first_name),2,LEN(first_name)) --LEN  become dynamic wont throw error
FROM customers;

--=============================================================================================

-- NUMBER Function: ABS , ROUND

--ROUND :
SELECT 
3.516 as num,
ROUND(3.516,2) as round_2,
ROUND(3.516,1) as round_1,
ROUND(3.516,0) as round_0,
ROUND(2.516,0) as round_even_num, --always round up
ROUND(3,516) as round_,
ROUND(40,000) as round_ --till before comma it will remove

--ABS : returns absolute val of a num (removes negative sign)
SELECT 
-248 as num,
ABS(-248) AS pos_num,
ABS(248) as pos_num







