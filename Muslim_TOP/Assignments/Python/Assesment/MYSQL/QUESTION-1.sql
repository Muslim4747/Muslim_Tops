CREATE DATABASE assesment;
USE assesment;

CREATE TABLE Worker (
    WORKER_ID INT,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT VARCHAR(50)
);

SELECT * FROM Worker;

/* 1. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME
Ascending and DEPARTMENT Descending. */

SELECT * FROM Worker
ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

/* 2.Write an SQL query to print details for Workers with the first names “Vipul” and “Satish”
from the Worker table. */

SELECT * FROM Worker 
WHERE FIRST_NAME IN ('Vipul' , 'Satish');

/* 3. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and
contains six alphabets.*/

SELECT * FROM Worker
WHERE FIRST_NAME LIKE '______h';

/* 4. Write an SQL query to print details of the Workers whose SALARY lies between 1. */

SELECT * FROM Worker
WHERE SALARY > 1;

/* 5. Write an SQL query to fetch duplicate records having matching data in some fields of a table. */

/* 6. Write an SQL query to show the top 6 records of a table.*/
SELECT * FROM Worker 
limit 6;

/* 7. Write an SQL query to fetch the departments that have less than five people in them. */

SELECT DEPARTMENT, COUNT(*) AS emp_count FROM Worker
GROUP BY DEPARTMENT HAVING COUNT(*) < 5 ;

/* 8. Write an SQL query to show all departments along with the number of people in there. */

SELECT DEPARTMENT, COUNT(*) AS num_people
FROM Worker GROUP BY DEPARTMENT ;

/* 9. Write an SQL query to print the name of employees having the highest salary in each
department. */

 SELECT  DEPARTMENT, MAX(SALARY)
 FROM Worker GROUP BY DEPARTMENT ;
 
 









