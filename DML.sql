/* DML -Data Manipulation Language
       -modify(manipulate) the data

        commands -INSERT
                  UPDATE
                  DELETE 
                  TRUNCATE

*/

--===================================================================================================
--Manual entry(1rst method)

/* INSERT -adding rows into the new table or exsisting table
   syntax: INSERT INTO table_name (col1 , col2 ....)  optional
           VALUES(val1 , val2 .....),     
                  (val1,val2........)    ->mulitple insert

Rule - Match the no of cols and values

*/

SELECT * FROM customers;

--Inserting new rows into customer table
INSERT INTO customers (id , first_name , country, score)
VALUES ( 6 , 'Anna' , 'USA' , NULL),
       ( 7 , 'Sam' , NULL , 100)

--caution - columns and values must be in same order
  
INSERT INTO customers (id , first_name , country , score)
VALUES ( 8 ,'USA' , 'Max' , NULL);

--Rule -Matching Data types , column count , constraint 
--wont matter about the data you are entering as above 

--Note:  you can skip the collumns if you insert values for every column
INSERT INTO customers
VALUES ( 9 , 'Andreas' , 'Germany' , NULL);
--Tip : always list the columns explicitly for clarity and maintainability

--Note : columns not included in INSERT become NULL (unless a default or constraint exists)
INSERT INTO customers (id , first_name)
VALUES ( 10 , 'Sahra');  --rest of two will be null
--can skip only nullable columns

--====================================================================================================================
--inserting using one table to another table(source)
--source table to target table

SELECT * FROM persons;
--Insert data from customers into persons
INSERT INTO persons (id , person_name  , birth_date , phone)
SELECT   -- slect data from  sorce table and then insert into target table by selecting matching cols
    id ,
    first_name,
    NULL,
    'Unknown' 
FROM customers

SELECT * FROM persons;


/* UPDATE --update the data of already existing rows
   syntax: UPDATE table_name
           SET col1 = val1,
               col2 = val2
            WHERE cond;
*/

--Change the score of customer with id 6 to 0;

UPDATE customers
SET score = 0
WHERE id = 6;
--Caution : without where all rows will be executed

/* Change the score of customer with id 10 to 0 
    and update the country to 'UK'  */
UPDATE customers
SET score = 0,
    country = 'UK'
WHERE id = 10;

/* Update all customers with a NULL score
    by setting their score to 0 */
UPDATE customers
SET score = 0 
WHERE score IS  NULL  -- IS NULL not = NULL

SELECT * FROM customers;


/* DELETE --remove rows from the table
     syntax: DELETE FROM table_name
             WHERE cond
    caution: always use where to avoid the deleting all rows unintentionally

*/

--Delete all customers with an id greater than 5
DELETE FROM customers
WHERE id>5

SELECT * 
FROM customers
--Best practice : check with select before delete to avoid deleting wrong data 

--delete all data from table persons
SELECT * FROM persons;
DELETE FROM persons;

-- we can use truncate command faster than delete to delete all rows 
-- TRUNCATE -clears entire table at once with out checking
TRUNCATE TABLE persons;

