USE MyDatabase

/* DDL - Data Definition Language
         commands : CREATE
                    ALTER 
                    DROP    
   */

--====================================================================

--CREATE - define the struture of the table

/* create a new table called persons with
    columns: id , person_name , birth_date , and phone
*/
CREATE TABLE persons(
id INT NOT NULL,
person_name VARCHAR(20) NOT NULL,
birth_date DATE ,
phone VARCHAR(30) NOT NULL,
CONSTRAINT pk_id PRIMARY KEY(id)
);

--========================================================================

--ALTER -- Modify the existing database objects

--Add a new column called email to person table
ALTER TABLE persons
ADD email VARCHAR(20);

--Multiple column once
ALTER TABLE persons   --always added at the end of the table
ADD loc VARCHAR(20),
    age INT;
 
--remove column from the table
ALTER TABLE persons
DROP COLUMN phone;

--removing multiple columns 
ALTER TABLE persons
DROP COLUMN loc,age;

--Modify / change the data type of a column
ALTER TABLE persons
ALTER COLUMN email VARCHAR(50);

--************************************************************************

--Rename the column or a table ******
EXEC sp_rename 'persons.person_name','full_name','COLUMN';
  
--Rename table 
EXEC sp_rename 'persons','people';

SELECT * FROM people;

EXEC sp_rename 'people','persons';

--************************************************************************

--DROP TABLE  -remove the database obj permanantly

--Delete the table persons from the database
DROP TABLE persons;

