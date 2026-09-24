--Part – A:
--1. List all books with their authors.

SELECT B.TITLE,A.AUTHORNAME
FROM BOOK B INNER JOIN AUTHOR A
ON  B.AUTHORID=A.AUTHORID

--2. List all books with their publishers.

SELECT B.TITLE,P.PUBLISHERNAME
FROM BOOK B INNER JOIN PUBLISHER P
ON B.PUBLISHERID=P.PUBLISHERID

--3. List all books with their authors and publishers.

SELECT B.TITLE,A.AUTHORNAME,P.PUBLISHERNAME
FROM BOOK B 
INNER JOIN AUTHOR A
ON  B.AUTHORID=A.AUTHORID
INNER JOIN PUBLISHER P
ON B.PUBLISHERID=P.PUBLISHERID

--4. List all books published after 2010 with their authors and publisher and price..

SELECT B.TITLE,A.AUTHORNAME,P.PUBLISHERNAME,B.PRICE,B.PUBLICATIONYEAR
FROM BOOK B 
INNER JOIN AUTHOR A
ON  B.AUTHORID=A.AUTHORID
INNER JOIN PUBLISHER P
ON B.PUBLISHERID=P.PUBLISHERID
WHERE B.PUBLICATIONYEAR >2010

--5. List all authors and the number of books they have written.

SELECT A.AUTHORNAME, COUNT(B.BOOKID) AS TOTALBOOKS
FROM AUTHOR A LEFT JOIN BOOK B 
ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME;

--6. List all publishers and the total price of books they have published.

SELECT P.PUBLISHERNAME, SUM(B.PRICE) AS TOTALPRICE
FROM PUBLISHER P INNER JOIN BOOK B 
ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME; 

--7. List authors who have not written any books.

SELECT A.AUTHORNAME
FROM AUTHOR A LEFT JOIN BOOK B 
ON A.AUTHORID = B.AUTHORID
WHERE B.BOOKID IS NULL;

--8. Display total number of Books and Average Price of every Author.

SELECT A.AUTHORNAME,COUNT(B.BOOKID) AS TOTALBOOKS,AVG(B.PRICE) AS AVG_PRICE
FROM AUTHOR A LEFT JOIN BOOK B 
ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME;

--9. lists each publisher along with the total number of books they have published, sorted from highest to lowest.

SELECT P.PUBLISHERNAME,COUNT(B.BOOKID) AS TOTALBOOKS
FROM PUBLISHER P LEFT JOIN BOOK B 
ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME
ORDER BY TOTALBOOKS DESC;

--10. Display number of books published each year. 

SELECT PUBLICATIONYEAR, COUNT(BOOKID) AS NumberOfBooks
FROM BOOK
GROUP BY PUBLICATIONYEAR;


--Part – B:

--1. List the publishers whose total book prices exceed 500, ordered by the total price.

SELECT P.PUBLISHERNAME , SUM(B.PRICE) AS TOTALPRICE
FROM PUBLISHER P INNER JOIN BOOK B 
ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME
HAVING SUM(B.PRICE) >500
ORDER BY TOTALPRICE;

--2. List most expensive book for each author, sort it with the highest price.

SELECT A.AUTHORNAME,MAX(B.PRICE) AS MAXPRICE
FROM AUTHOR A INNER JOIN BOOK B 
ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME
ORDER BY MAXPRICE DESC;

--3. Display publisher name and difference between maximum and minimum book price.

SELECT P.PUBLISHERNAME,
MAX(B.PRICE) - MIN(B.PRICE) AS PRICEDIFFERENCE
FROM PUBLISHER P INNER JOIN BOOK B 
ON P.PUBLISHERID = B.PUBLISHERID
GROUP BY P.PUBLISHERNAME;

--4. List publisher name and total price of books published each year.

SELECT P.PUBLISHERNAME,B.PUBLICATIONYEAR,SUM(B.PRICE) AS TOTALPRICE
FROM BOOK B INNER JOIN PUBLISHER P 
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY P.PUBLISHERNAME, B.PUBLICATIONYEAR;

--5. Display author name and total price of books sorted by highest total price. 

SELECT A.AUTHORNAME,SUM(B.PRICE) AS TOTALPRICE
FROM AUTHOR A INNER JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
GROUP BY A.AUTHORNAME
ORDER BY TOTALPRICE DESC;



---------------------- EMPLOYEE_MASTER TABLE-------------------------------


CREATE TABLE EMPLOYEE_MASTER(
         EmployeeNo VARCHAR(10),
         Name VARCHAR(10),
         ManagerNo VARCHAR(10)
);

INSERT INTO EMPLOYEE_MASTER VALUES
('E01','Tarun',NULL),
('E02','Rohan','E02'),
('E03','Priya','E01'),
('E04','Milan','E03'),
('E05','Jay','E01'),
('E06','Anjana','E04');

SELECT * FROM EMPLOYEE_MASTER

--Part – C:
--1. Retrieve the names of employee along with their manager’s name from the Employee table.

SELECT E.NAME AS EMPLOYEENAME, 
M.NAME AS MANAGER_NAME
FROM EMPLOYEE_MASTER E LEFT JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo;

--2. Display employees who are managers.

SELECT DISTINCT M.NAME AS MANAGERNAME
FROM EMPLOYEE_MASTER E INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo;

--3. Display number of employees working under each manager.

SELECT M.NAME AS MANAGERNAME,
COUNT(E.EmployeeNo) AS TOTAL_EMPLOYEES
FROM EMPLOYEE_MASTER E INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo
GROUP BY M.NAME;

--4. Display employee name, manager name, and manager’s manager name.


--5. Display managers and count of employees under them in descending order. 

SELECT M.NAME AS MANAGERNAME,
COUNT(E.EmployeeNo) AS TOTAL_EMPLOYEES
FROM EMPLOYEE_MASTER E INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo
GROUP BY M.NAME
ORDER BY TOTAL_EMPLOYEES DESC;