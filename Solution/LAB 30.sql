--Part – A:
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
BEGIN TRY
    SELECT 10 / 0;
END TRY
BEGIN CATCH
    PRINT 'Error occurs that is - Divide by zero error.';
END CATCH;
--2. Try to convert string to integer and handle the error using try…catch block.
BEGIN TRY
    SELECT CAST('ABC' AS INT);
END TRY
BEGIN CATCH
    PRINT 'Conversion Error: Cannot convert string to integer.';
END CATCH;
--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.

CREATE PROCEDURE PR_SumTwoNumbers
    @Num1 VARCHAR(50),
    @Num2 VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        DECLARE @N1 INT = CAST(@Num1 AS INT);
        DECLARE @N2 INT = CAST(@Num2 AS INT);
        PRINT 'Sum: ' + CAST((@N1 + @N2) AS VARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

--4. Handle a Primary Key Violation while inserting data into STUDENT_INFO table and print the error
--details such as the error message, error number, severity, and state.
BEGIN TRY
    INSERT INTO STUDENT_INFO (RNO, NAME, BRANCH)
    VALUES (101, 'Duplicate Raju', 'CE'); -- 101 already exists
END TRY
BEGIN CATCH
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
--5. Throw custom exception using stored procedure which accepts RNO as input & that throws Error like
--no RNO is available in database.
CREATE PROCEDURE PR_CheckStudentRNO
    @RNO INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM STUDENT_INFO WHERE RNO = @RNO)
    BEGIN
        THROW 50001, 'No RNO is available in database.', 1;
    END
    ELSE
    BEGIN
        SELECT * FROM STUDENT_INFO WHERE RNO = @RNO;
    END
END;
--Part – B
--6. Create a stored procedure to update employee SALARY and throw custom exception if salary is
--negative or zero (Use EMPLOYEE Table).
CREATE PROCEDURE PR_UpdateEmployeeSalary
    @EID INT,
    @Salary DECIMAL(8,2)
AS
BEGIN
    IF @Salary <= 0
    BEGIN
        THROW 50002, 'Salary must be greater than zero.', 1;
    END
    
    UPDATE EMPLOYEE
    SET SALARY = @Salary
    WHERE EID = @EID;
END;
--7. Handle a Foreign Key Violation while inserting data into RESULT table and print appropriate error
--message (Use RESULT Table).
BEGIN TRY
    INSERT INTO RESULT (RESULTID, SPI, RNO)
    VALUES (17, 8.5, 999); -- RNO 999 does not exist in STUDENT_INFO
END TRY
BEGIN CATCH
    PRINT 'Foreign Key Violation Error: ' + ERROR_MESSAGE();
END CATCH;
--8. Handle Invalid Date Format while inserting data into DEPOSIT table.
BEGIN TRY
    INSERT INTO DEPOSIT (ACTNO, CNAME, BNAME, AMOUNT, ADATE)
    VALUES (120, 'TEST', 'MAVDI', 5000, 'Invalid-Date-String');
END TRY
BEGIN CATCH
    PRINT 'Invalid Date Format Error: ' + ERROR_MESSAGE();
END CATCH;
--9. Create a stored procedure that validates gender column and throws error if value is other than male or
--female (Use EMPLOYEE Table).
CREATE PROCEDURE PR_ValidateGender
    @EID INT,
    @Gender VARCHAR(10)
AS
BEGIN
    IF UPPER(@Gender) NOT IN ('MALE', 'FEMALE')
    BEGIN
        THROW 50003, 'Invalid Gender. Allowed values are Male or Female.', 1;
    END
    
    UPDATE EMPLOYEE
    SET GENDER = @Gender
    WHERE EID = @EID;
END;
--10. Create a stored procedure that accepts joiningyear and throws custom exception if entered year is
--greater than current year (Use EMPLOYEE Table).
CREATE PROCEDURE PR_ValidateJoiningYear
    @EID INT,
    @JoiningYear INT
AS
BEGIN
    IF @JoiningYear > YEAR(GETDATE())
    BEGIN
        THROW 50004, 'Joining year cannot be greater than current year.', 1;
    END
    
    UPDATE EMPLOYEE
    SET JOININGYEAR = @JoiningYear
    WHERE EID = @EID;
END;
--Part – C
--10. Create a stored procedure to delete employee record and handle exception if employee does not exist.
CREATE PROCEDURE PR_DeleteEmployee
    @EID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE EID = @EID)
    BEGIN
        THROW 50005, 'Employee record does not exist.', 1;
    END
    
    DELETE FROM EMPLOYEE WHERE EID = @EID;
END;
--11. Create a stored procedure that throws custom exception if department name is NULL during insertion. 
CREATE PROCEDURE PR_InsertEmployee
    @EID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Department VARCHAR(50),
    @Salary DECIMAL(8,2),
    @City VARCHAR(50),
    @Gender VARCHAR(10),
    @JoiningYear INT
AS
BEGIN
    IF @Department IS NULL OR LTRIM(RTRIM(@Department)) = ''
    BEGIN
        THROW 50006, 'Department name cannot be NULL or empty.', 1;
    END

    INSERT INTO EMPLOYEE (EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR)
    VALUES (@EID, @FirstName, @LastName, @Department, @Salary, @City, @Gender, @JoiningYear);
END;