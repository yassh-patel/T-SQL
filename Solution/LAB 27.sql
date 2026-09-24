select * from EMPLOYEE

-- PART A

-- Q1. Create a cursor Employee_Cursor to fetch all rows from EMPLOYEE table and display them.
DECLARE @EID INT, @FIRSTNAME VARCHAR(50), @LASTNAME VARCHAR(50),
        @DEPARTMENT VARCHAR(50), @SALARY DECIMAL(10,2),
        @CITY VARCHAR(50), @GENDER VARCHAR(10), @JOININGYEAR INT;
DECLARE Employee_Cursor CURSOR
FOR
SELECT EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR
FROM EMPLOYEE;

OPEN Employee_Cursor;


FETCH NEXT FROM Employee_Cursor
INTO @EID, @FIRSTNAME, @LASTNAME, @DEPARTMENT, @SALARY, @CITY, @GENDER, @JOININGYEAR;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID AS EID, @FIRSTNAME AS FIRSTNAME, @LASTNAME AS LASTNAME,
           @DEPARTMENT AS DEPARTMENT, @SALARY AS SALARY,
           @CITY AS CITY, @GENDER AS GENDER, @JOININGYEAR AS JOININGYEAR;

    FETCH NEXT FROM Employee_Cursor
    INTO @EID, @FIRSTNAME, @LASTNAME, @DEPARTMENT, @SALARY, @CITY, @GENDER, @JOININGYEAR;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- Q2. Create a cursor to display all female employees from EMPLOYEE table.

DECLARE @EID2 INT, @FNAME2 VARCHAR(50), @LNAME2 VARCHAR(50),@SAL2 DECIMAL(10,2);

DECLARE Female_Cursor CURSOR 
FOR SELECT EID, FIRSTNAME, LASTNAME, SALARY
FROM EMPLOYEE
WHERE GENDER = 'FEMALE';

OPEN Female_Cursor;


FETCH NEXT FROM Female_Cursor
INTO @EID2, @FNAME2, @LNAME2, @SAL2;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID2 AS EID, @FNAME2 AS FIRSTNAME,
           @LNAME2 AS LASTNAME, @SAL2 AS SALARY;

    FETCH NEXT FROM Female_Cursor
    INTO @EID2, @FNAME2, @LNAME2, @SAL2;
END;

CLOSE Female_Cursor;
DEALLOCATE Female_Cursor;


-- Q3. Create a cursor Employee_Cursor_Fetch to fetch records in EID_FirstName_LastName format.
DECLARE @EID3 INT, @FNAME3 VARCHAR(50), @LNAME3 VARCHAR(50);

DECLARE Employee_Cursor_Fetch CURSOR FOR
SELECT EID, FIRSTNAME, LASTNAME
FROM EMPLOYEE;

OPEN Employee_Cursor_Fetch;


FETCH NEXT FROM Employee_Cursor_Fetch
INTO @EID3, @FNAME3, @LNAME3;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CAST(@EID3 AS VARCHAR) + '_' + @FNAME3 + '_' + @LNAME3;

    FETCH NEXT FROM Employee_Cursor_Fetch
    INTO @EID3, @FNAME3, @LNAME3;
END;

CLOSE Employee_Cursor_Fetch;
DEALLOCATE Employee_Cursor_Fetch;


-- Q4. Create a cursor to find and display all employees with Salary greater than 12000.
DECLARE @EID4 INT, @FNAME4 VARCHAR(50), @SAL4 DECIMAL(10,2);

DECLARE Salary_Cursor CURSOR FOR
SELECT EID, FIRSTNAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 12000;

OPEN Salary_Cursor;


FETCH NEXT FROM Salary_Cursor
INTO @EID4, @FNAME4, @SAL4;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID4 AS EID, @FNAME4 AS FIRSTNAME, @SAL4 AS SALARY;

    FETCH NEXT FROM Salary_Cursor
    INTO @EID4, @FNAME4, @SAL4;
END;

CLOSE Salary_Cursor;
DEALLOCATE Salary_Cursor;


-- Q5. Create a cursor to display all employees who joined in year 2022 or later.
DECLARE @EID5 INT, @FNAME5 VARCHAR(50), @YEAR5 INT;

DECLARE Joining_Cursor CURSOR FOR
SELECT EID, FIRSTNAME, JOININGYEAR
FROM EMPLOYEE
WHERE JOININGYEAR >= 2022;

OPEN Joining_Cursor;


FETCH NEXT FROM Joining_Cursor
INTO @EID5, @FNAME5, @YEAR5;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID5 AS EID, @FNAME5 AS FIRSTNAME,
           @YEAR5 AS JOININGYEAR;

    FETCH NEXT FROM Joining_Cursor
    INTO @EID5, @FNAME5, @YEAR5;
END;

CLOSE Joining_Cursor;
DEALLOCATE Joining_Cursor;


-- Q6. Create a cursor to fetch Employee Name with Department Name.
DECLARE @FNAME6 VARCHAR(50), @LNAME6 VARCHAR(50),@DEPT6 VARCHAR(50);

DECLARE Dept_Cursor CURSOR FOR
SELECT FIRSTNAME, LASTNAME, DEPARTMENT
FROM EMPLOYEE;

OPEN Dept_Cursor;


FETCH NEXT FROM Dept_Cursor
INTO @FNAME6, @LNAME6, @DEPT6;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FNAME6 + ' ' + @LNAME6 + ' works in ' + @DEPT6 + ' Department';

    FETCH NEXT FROM Dept_Cursor
    INTO @FNAME6, @LNAME6, @DEPT6;
END;

CLOSE Dept_Cursor;
DEALLOCATE Dept_Cursor;


-- Q7. Create a cursor to update CITY as AHMEDABAD for employees whose CITY is NULL.
DECLARE @EID7 INT;
DECLARE City_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE CITY IS NULL;

OPEN City_Cursor;



FETCH NEXT FROM City_Cursor INTO @EID7;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE EMPLOYEE
    SET CITY = 'AHMEDABAD'
    WHERE EID = @EID7;

    FETCH NEXT FROM City_Cursor INTO @EID7;
END;

CLOSE City_Cursor;
DEALLOCATE City_Cursor;


-- Q8. Create a cursor to display Employee Name with City Name.

DECLARE Employee_City_Cursor CURSOR FOR
SELECT FIRSTNAME, LASTNAME, CITY
FROM EMPLOYEE;

OPEN Employee_City_Cursor;

DECLARE @FNAME8 VARCHAR(50), @LNAME8 VARCHAR(50), @CITY8 VARCHAR(50);

FETCH NEXT FROM Employee_City_Cursor
INTO @FNAME8, @LNAME8, @CITY8;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FNAME8 + ' ' + @LNAME8 + ' lives in ' + ISNULL(@CITY8, 'NULL');

    FETCH NEXT FROM Employee_City_Cursor
    INTO @FNAME8, @LNAME8, @CITY8;
END;

CLOSE Employee_City_Cursor;
DEALLOCATE Employee_City_Cursor;


-- Q9. Create a cursor to delete employees whose Salary is less than 5000.
DECLARE @EID9 INT;

DECLARE Delete_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE SALARY < 5000;

OPEN Delete_Cursor;


FETCH NEXT FROM Delete_Cursor INTO @EID9;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EID = @EID9;

    FETCH NEXT FROM Delete_Cursor INTO @EID9;
END;

CLOSE Delete_Cursor;
DEALLOCATE Delete_Cursor;


-- Q10. Create a cursor to display employees department-wise.
DECLARE @FNAME10 VARCHAR(50), @LNAME10 VARCHAR(50),@DEPT10 VARCHAR(50);

DECLARE Department_Cursor CURSOR 
FOR SELECT FIRSTNAME, LASTNAME, DEPARTMENT
FROM EMPLOYEE
ORDER BY DEPARTMENT;

OPEN Department_Cursor;


FETCH NEXT FROM Department_Cursor
INTO @FNAME10, @LNAME10, @DEPT10;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @DEPT10 + ' : ' + @FNAME10 + ' ' + @LNAME10;

    FETCH NEXT FROM Department_Cursor
    INTO @FNAME10, @LNAME10, @DEPT10;
END;

CLOSE Department_Cursor;
DEALLOCATE Department_Cursor;


-- PART B

-- Q11. Create a cursor to count total employees from each department.
DECLARE @DEPT11 VARCHAR(50), @COUNT11 INT;

DECLARE Dept_Count_Cursor CURSOR FOR
SELECT DEPARTMENT, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPARTMENT;

OPEN Dept_Count_Cursor;


FETCH NEXT FROM Dept_Count_Cursor
INTO @DEPT11, @COUNT11;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @DEPT11 AS DEPARTMENT, @COUNT11 AS TOTAL_EMPLOYEES;

    FETCH NEXT FROM Dept_Count_Cursor
    INTO @DEPT11, @COUNT11;
END;

CLOSE Dept_Count_Cursor;
DEALLOCATE Dept_Count_Cursor;


-- Q12. Create a cursor to display employees whose CITY starts with R.
DECLARE @EID12 INT, @FNAME12 VARCHAR(50), @CITY12 VARCHAR(50);


DECLARE R_City_Cursor CURSOR FOR
SELECT EID, FIRSTNAME, CITY
FROM EMPLOYEE
WHERE CITY LIKE 'R%';

OPEN R_City_Cursor;


FETCH NEXT FROM R_City_Cursor
INTO @EID12, @FNAME12, @CITY12;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID12 AS EID, @FNAME12 AS FIRSTNAME, @CITY12 AS CITY;

    FETCH NEXT FROM R_City_Cursor
    INTO @EID12, @FNAME12, @CITY12;
END;

CLOSE R_City_Cursor;
DEALLOCATE R_City_Cursor;


-- Q13. Create a cursor to display top 3 highest salary employees.
DECLARE @EID13 INT, @FNAME13 VARCHAR(50), @SAL13 DECIMAL(10,2);

DECLARE Top3_Cursor CURSOR FOR
SELECT TOP 3 EID, FIRSTNAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

OPEN Top3_Cursor;


FETCH NEXT FROM Top3_Cursor
INTO @EID13, @FNAME13, @SAL13;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID13 AS EID, @FNAME13 AS FIRSTNAME, @SAL13 AS SALARY;

    FETCH NEXT FROM Top3_Cursor
    INTO @EID13, @FNAME13, @SAL13;
END;

CLOSE Top3_Cursor;
DEALLOCATE Top3_Cursor;


-- Q14. Create a cursor to calculate total salary department-wise.
DECLARE @DEPT14 VARCHAR(50), @TOTAL14 DECIMAL(10,2);

DECLARE Total_Salary_Cursor CURSOR FOR
SELECT DEPARTMENT, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPARTMENT;

OPEN Total_Salary_Cursor;


FETCH NEXT FROM Total_Salary_Cursor
INTO @DEPT14, @TOTAL14;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @DEPT14 AS DEPARTMENT, @TOTAL14 AS TOTAL_SALARY;

    FETCH NEXT FROM Total_Salary_Cursor
    INTO @DEPT14, @TOTAL14;
END;

CLOSE Total_Salary_Cursor;
DEALLOCATE Total_Salary_Cursor;


-- Q15. Create a cursor to calculate average salary city-wise.
DECLARE @CITY15 VARCHAR(50), @AVG15 DECIMAL(10,2);

DECLARE Avg_Salary_Cursor CURSOR FOR
SELECT CITY, AVG(SALARY)
FROM EMPLOYEE
WHERE CITY IS NOT NULL
GROUP BY CITY;

OPEN Avg_Salary_Cursor;


FETCH NEXT FROM Avg_Salary_Cursor
INTO @CITY15, @AVG15;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @CITY15 AS CITY, @AVG15 AS AVERAGE_SALARY;

    FETCH NEXT FROM Avg_Salary_Cursor
    INTO @CITY15, @AVG15;
END;

CLOSE Avg_Salary_Cursor;
DEALLOCATE Avg_Salary_Cursor;


-- PART C

-- Q16. Create a cursor to display employee experience using JOININGYEAR.

DECLARE @FNAME16 VARCHAR(50), @LNAME16 VARCHAR(50),
        @YEAR16 INT;

DECLARE Experience_Cursor CURSOR FOR
SELECT FIRSTNAME, LASTNAME, JOININGYEAR
FROM EMPLOYEE;

OPEN Experience_Cursor;


FETCH NEXT FROM Experience_Cursor
INTO @FNAME16, @LNAME16, @YEAR16;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FNAME16 + ' ' + @LNAME16 +
          ' has experience = ' +
          CAST(YEAR(GETDATE()) - @YEAR16 AS VARCHAR) + ' years';

    FETCH NEXT FROM Experience_Cursor
    INTO @FNAME16, @LNAME16, @YEAR16;
END;

CLOSE Experience_Cursor;
DEALLOCATE Experience_Cursor;


-- Q17. Create a cursor to display employee full name with annual salary.
DECLARE @FNAME17 VARCHAR(50), @LNAME17 VARCHAR(50),
        @SAL17 DECIMAL(10,2);

DECLARE Annual_Salary_Cursor CURSOR FOR
SELECT FIRSTNAME, LASTNAME, SALARY
FROM EMPLOYEE;

OPEN Annual_Salary_Cursor;



FETCH NEXT FROM Annual_Salary_Cursor
INTO @FNAME17, @LNAME17, @SAL17;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FNAME17 + ' ' + @LNAME17 +
          ' annual salary = ' +
          CAST(@SAL17 * 12 AS VARCHAR);

    FETCH NEXT FROM Annual_Salary_Cursor
    INTO @FNAME17, @LNAME17, @SAL17;
END;

CLOSE Annual_Salary_Cursor;
DEALLOCATE Annual_Salary_Cursor;


-- Q18. Create a cursor to calculate total male and female employees separately.
DECLARE @GENDER18 VARCHAR(10), @COUNT18 INT;

DECLARE Gender_Cursor CURSOR FOR
SELECT GENDER, COUNT(*)
FROM EMPLOYEE
GROUP BY GENDER;

OPEN Gender_Cursor;


FETCH NEXT FROM Gender_Cursor
INTO @GENDER18, @COUNT18;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @GENDER18 AS GENDER, @COUNT18 AS TOTAL_EMPLOYEES;

    FETCH NEXT FROM Gender_Cursor
    INTO @GENDER18, @COUNT18;
END;

CLOSE Gender_Cursor;
DEALLOCATE Gender_Cursor;


-- Q19. Create a cursor to display employees whose salary is greater than department average salary.
DECLARE @EID19 INT, @FNAME19 VARCHAR(50), @LNAME19 VARCHAR(50),
        @SAL19 DECIMAL(10,2), @DEPT19 VARCHAR(50);

DECLARE Above_Avg_Cursor CURSOR FOR
SELECT E.EID, E.FIRSTNAME, E.LASTNAME, E.SALARY, E.DEPARTMENT
FROM EMPLOYEE E
WHERE E.SALARY >
(
    SELECT AVG(E2.SALARY)
    FROM EMPLOYEE E2
    WHERE E2.DEPARTMENT = E.DEPARTMENT
);

OPEN Above_Avg_Cursor;


FETCH NEXT FROM Above_Avg_Cursor
INTO @EID19, @FNAME19, @LNAME19, @SAL19, @DEPT19;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EID19 AS EID, @FNAME19 AS FIRSTNAME,
           @LNAME19 AS LASTNAME, @SAL19 AS SALARY,
           @DEPT19 AS DEPARTMENT;

    FETCH NEXT FROM Above_Avg_Cursor
    INTO @EID19, @FNAME19, @LNAME19, @SAL19, @DEPT19;
END;

CLOSE Above_Avg_Cursor;
DEALLOCATE Above_Avg_Cursor;


-- Q20. Create a cursor to transfer all employees from ADMIN department to HR department.
DECLARE @EID20 INT;

DECLARE Admin_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE DEPARTMENT = 'ADMIN';

OPEN Admin_Cursor;


FETCH NEXT FROM Admin_Cursor INTO @EID20;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE EMPLOYEE
    SET DEPARTMENT = 'HR'
    WHERE EID = @EID20;

    FETCH NEXT FROM Admin_Cursor INTO @EID20;
END;

CLOSE Admin_Cursor;
DEALLOCATE Admin_Cursor;