--Part – A:
--1. Implement scalar function to return "Welcome to DBMS Lab".
CREATE FUNCTION FN_WELCOME()
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'Welcome to DBMS Lab';
END;

SELECT dbo.FN_WELCOME();
--2. Implement scalar function to calculate simple interest.
CREATE FUNCTION FN_SIMPLE_INTEREST
(
    @P INT,
    @R INT,
    @T INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (@P * @R * @T) / 100.0;
END;

SELECT dbo.FN_SIMPLE_INTEREST(10000, 5, 2);
--3. Implement scalar function to find difference in days between two dates.

CREATE FUNCTION FN_DATE_DIFF
(
    @Date1 DATE,
    @Date2 DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @Date1, @Date2);
END;

SELECT dbo.FN_DATE_DIFF('2026-01-01', '2026-01-10');
--4. Implement scalar function to check whether number is odd or even.

CREATE FUNCTION FN_ODD_EVEN
(
    @Num INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    IF @Num % 2 = 0
        RETURN 'Even';

    RETURN 'Odd';
END;

SELECT dbo.FN_ODD_EVEN(9);

--5. Implement scalar function to print numbers from 1 to N.

CREATE OR ALTER FUNCTION FN_NUMBERS
(
    @N INT
)
RETURNS VARCHAR(500)
AS
BEGIN
    DECLARE @Result VARCHAR(500) = '';
    DECLARE @I VARCHAR(50) = 1;

    WHILE @I <= @N
    BEGIN
        SET @Result = @Result + @I  + ' ';
        SET @I = @I + 1;
    END

    RETURN @Result;
END;

SELECT dbo.FN_NUMBERS(10);

--Part – B:
--6. Implement scalar function to calculate factorial of given number.

CREATE FUNCTION FN_FACTORIAL
(
    @N INT
)
RETURNS BIGINT
AS
BEGIN
    DECLARE @Fact INT = 1;
    DECLARE @I INT = 1;

    WHILE @I <= @N
    BEGIN
        SET @Fact = @Fact * @I;
        SET @I = @I + 1;
    END

    RETURN @Fact;
END;

SELECT dbo.FN_FACTORIAL(5);
--7. Implement scalar function to check palindrome number.

CREATE FUNCTION FN_PALINDROME
(
    @Num INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Reverse INT = 0;
    DECLARE @Temp INT = @Num;

    WHILE @Temp > 0
    BEGIN
        SET @Reverse = (@Reverse * 10) + (@Temp % 10);
        SET @Temp = @Temp / 10;
    END

    IF @Num = @Reverse
        RETURN 'Palindrome';

    RETURN 'Not Palindrome';
END;

SELECT dbo.FN_PALINDROME(121);

--8. Implement scalar function to find maximum of three numbers.

CREATE FUNCTION FN_MAX_THREE
(
    @A INT,
    @B INT,
    @C INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Max INT;

    SET @Max = @A;

    IF @B > @Max
        SET @Max = @B;

    IF @C > @Max
        SET @Max = @C;

    RETURN @Max;
END;

SELECT dbo.FN_MAX_THREE(10, 25, 15);
--9. Implement scalar function to calculate square and cube of a number.
--From the table EMPLOYEE perform the following queries:

CREATE FUNCTION FN_SQUARE_CUBE
(
    @N INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'Square = ' + CAST(@N * @N AS VARCHAR)
         + ', Cube = ' + CAST(@N * @N * @N AS VARCHAR);
END;

SELECT dbo.FN_SQUARE_CUBE(5);



--Part – C:
--10. Implement scalar function to return employee full details using EID.

CREATE FUNCTION FN_EMPLOYEE_NAME
(
    @EID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Name VARCHAR(100);

    SELECT @Name = FIRSTNAME + ' ' + LASTNAME
    FROM EMPLOYEE
    WHERE EID = @EID;

    RETURN @Name;
END;

SELECT dbo.FN_EMPLOYEE_NAME(101);
--11. Implement scalar function to return highest salary from a given department.

CREATE FUNCTION FN_HIGH_SALARY
(
    @Department VARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2);

    SELECT @Salary = MAX(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT = @Department;

    RETURN @Salary;
END;

SELECT dbo.FN_HIGH_SALARY('IT');
--12. Implement scalar function to count total employees in EMPLOYEE table.
CREATE FUNCTION FN_TOTAL_EMPLOYEE()
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM EMPLOYEE;

    RETURN @Total;
END;

SELECT dbo.FN_TOTAL_EMPLOYEE();
--13. Implement scalar function to find total experience of employee using JoiningYear.

CREATE FUNCTION FN_EXPERIENCE
(
    @JoiningYear INT
)
RETURNS INT
AS
BEGIN
    RETURN YEAR(GETDATE()) - @JoiningYear;
END;

SELECT dbo.FN_EXPERIENCE(2022);
--14. Implement scalar function to return total number of employees in a given department.

CREATE FUNCTION FN_DEPARTMENT_COUNT
(
    @Department VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM EMPLOYEE
    WHERE DEPARTMENT = @Department;

    RETURN @Total;
END;

SELECT dbo.FN_DEPARTMENT_COUNT('IT');
--15. Implement scalar function to count total employees from a given city.

CREATE FUNCTION FN_CITY_COUNT
(
    @City VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM EMPLOYEE
    WHERE CITY = @City;

    RETURN @Total;
END;

SELECT dbo.FN_CITY_COUNT('RAJKOT');