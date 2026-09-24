--From the table EMPLOYEE perform the following queries:
SELECT * FROM EMPLOYEE
--Part – A:
--1. Create a stored procedure to generate department-wise salary statistics like total salary, averagesalary, minimum salary, and maximum salary. (User enter only department name)
CREATE PROCEDURE SP_SALARY_STATISTICS
    @Department VARCHAR(50)
AS
BEGIN
    SELECT
        SUM(SALARY) AS Total_Salary,
        AVG(SALARY) AS Average_Salary,
        MIN(SALARY) AS Minimum_Salary,
        MAX(SALARY) AS Maximum_Salary
    FROM EMPLOYEE
    WHERE DEPARTMENT = @Department;
END;

EXEC SP_SALARY_STATISTICS 'IT';
--2. Create a stored procedure that accepts a joining year and displays employees who joined that year.
CREATE PROCEDURE SP_JOINING_YEAR
    @Year INT
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE JOININGYEAR = @Year;
END;

EXEC SP_JOINING_YEAR 2026;
--3. Create a stored procedure for dynamic employee search using parameters (User may enter partial cityname).
CREATE PROCEDURE SP_SEARCH_CITY
    @City VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE CITY LIKE '%' + @City + '%';
END;

EXEC SP_SEARCH_CITY 'RAJ';
--4. Create a stored procedure that accepts a salary amount and displays employees earning more than theentered salary.
CREATE PROCEDURE SP_SALARY_GREATER
    @Salary DECIMAL(10,2)
AS
BEGIN
    SELECT *
    FROM EMPLOYEE
    WHERE SALARY > @Salary;
END;

EXEC SP_SALARY_GREATER 12000;
--5. Create a stored procedure to display top N highest paid employees from each department (Value of Nis entered by user).
CREATE PROCEDURE SP_TOP_N_EMPLOYEE
    @N INT
AS
BEGIN
    SELECT *
    FROM
    (SELECT *,
ROW_NUMBER() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS RN
        FROM EMPLOYEE
    ) AS T
    WHERE RN <= @N;
END;

EXEC SP_TOP_N_EMPLOYEE 1;
--6. Create a stored procedure to increase salary department-wise by a given percentage. (User EnterDepartment Name and %, e.g. Computer 10).
CREATE PROCEDURE SP_INCREASE_SALARY
    @Department VARCHAR(50),
    @Percentage DECIMAL(5,2)
AS
BEGIN
    UPDATE EMPLOYEE
    SET SALARY = SALARY + (SALARY * @Percentage / 100)
    WHERE DEPARTMENT = @Department;
END;

EXEC SP_INCREASE_SALARY 'IT', 10;
--7. Create a stored procedure to display employees having experience greater than or equal to the entered years.
CREATE PROCEDURE SP_EMPLOYEE_EXPERIENCE
    @Years INT
AS
BEGIN
    SELECT *,
           YEAR(GETDATE()) - JOININGYEAR AS Experience
    FROM EMPLOYEE
    WHERE YEAR(GETDATE()) - JOININGYEAR >= @Years;
END;

EXEC SP_EMPLOYEE_EXPERIENCE 3;
--8. Create a stored procedure that accepts a number as input and displays details of the last N employees who joined the organization.

CREATE PROCEDURE SP_LAST_N_EMPLOYEE
    @N INT
AS
BEGIN
    SELECT TOP (@N) *
    FROM EMPLOYEE
    ORDER BY JOININGYEAR DESC;
END;


EXEC SP_LAST_N_EMPLOYEE 3;
--Part – B:

SELECT * FROM AUTHOR
SELECT * FROM PUBLISHER
SELECT * FROM BOOK
--9. Create a stored procedure that accepts an author name and displays all books written by that author.
CREATE OR ALTER PROCEDURE SP_BOOK_BY_AUTHOR
    @AuthorName VARCHAR(100)
AS
BEGIN
    SELECT B.*
    FROM BOOK B
    INNER JOIN AUTHOR A
        ON B.AUTHORID = A.AUTHORID
    WHERE A.AUTHORNAME = @AuthorName;
END;

EXEC SP_BOOK_BY_AUTHOR 'RUSKIN BOND';
--10. Create a stored procedure that accepts a publication year and displays books published after that year.
CREATE PROCEDURE SP_BOOK_AFTER_YEAR
    @Year INT
AS
BEGIN
    SELECT *
    FROM BOOK
    WHERE PUBLICATIONYEAR > @Year;
END;

EXEC SP_BOOK_AFTER_YEAR 2010;
--11. Create a stored procedure that accepts a country name and displays all authors from that country with  their books.
CREATE PROCEDURE SP_AUTHOR_COUNTRY
    @Country VARCHAR(50)
AS
BEGIN
    SELECT
        A.AUTHORNAME,
        B.TITLE
    FROM AUTHOR A
    INNER JOIN BOOK B
        ON A.AUTHORID = B.AUTHORID
    WHERE A.COUNTRY = @Country;
END;

EXEC SP_AUTHOR_COUNTRY 'INDIA';
--12. Create a stored procedure that accepts a number as input and displays the top N most expensive books with author and publisher details.

CREATE PROCEDURE SP_TOP_EXPENSIVE_BOOKS
    @N INT
AS
BEGIN
    SELECT TOP (@N)
        B.TITLE,
        B.PRICE,
        A.AUTHORNAME,
        P.PUBLISHERNAME
    FROM BOOK B
    INNER JOIN AUTHOR A
        ON B.AUTHORID = A.AUTHORID
    INNER JOIN PUBLISHER P
        ON B.PUBLISHERID = P.PUBLISHERID
    ORDER BY B.PRICE DESC;
END;

EXEC SP_TOP_EXPENSIVE_BOOKS 3;
--Part – C:
--13. Create a stored procedure that accepts a publisher name and displays the total number of books published by that publisher.
CREATE PROCEDURE SP_BOOK_COUNT
    @PublisherName VARCHAR(100)
AS
BEGIN
    SELECT COUNT(B.BOOKID) AS Total_Books
    FROM PUBLISHER P
    INNER JOIN BOOK B
        ON P.PUBLISHERID = B.PUBLISHERID
    WHERE P.PUBLISHERNAME = @PublisherName;
END;

EXEC SP_BOOK_COUNT 'RUPA PUBLICATIONS';
--14. Create a stored procedure that accepts a price range (Min Price Max Price) and displays books whose prices fall within that range.
CREATE PROCEDURE SP_BOOK_PRICE_RANGE
    @MinPrice DECIMAL(10,2),
    @MaxPrice DECIMAL(10,2)
AS
BEGIN
    SELECT *
    FROM BOOK
    WHERE PRICE BETWEEN @MinPrice AND @MaxPrice;
END;

EXEC SP_BOOK_PRICE_RANGE 200, 400;
--15. Create a stored procedure that accepts an author ID and deletes all books written by that author. 

CREATE PROCEDURE SP_DELETE_BOOK_AUTHOR
    @AuthorID INT
AS
BEGIN
    DELETE FROM BOOK
    WHERE AUTHORID = @AuthorID;
END;

EXEC SP_DELETE_BOOK_AUTHOR 1;