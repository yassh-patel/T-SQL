
-- PART A

select * from EMPLOYEE
-- Q1. Create trigger for printing message after employee record insertion.

CREATE OR ALTER TRIGGER TRG_After_Insert
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    PRINT 'Employee record inserted successfully';
END;


-- Q2. Create trigger for printing message after employee record update.

CREATE OR ALTER TRIGGER TRG_After_Update
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee record updated successfully';
END;


-- Q3. Create trigger for printing message after employee record deletion.

CREATE OR ALTER TRIGGER TRG_After_Delete
ON EMPLOYEE
AFTER DELETE
AS
BEGIN
    PRINT 'Employee record deleted successfully';
END;


-- Q4. Create trigger for printing message after employee salary increment.

CREATE OR ALTER TRIGGER TRG_Salary_Increment
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(SALARY)
    BEGIN
        PRINT 'Employee salary updated successfully';
    END
END;

update EMPLOYEE
set FIRSTNAME='yash'
where EID=101


-- Q5. Create trigger for automatically converting CITY names into uppercase during insertion.

CREATE OR ALTER TRIGGER TRG_City_Uppercase
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET CITY = UPPER(E.CITY)
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
    ON E.EID = I.EID;
END;



-- PART B


-- Q6. Create trigger for updating employee city and printing old city and new city name.

CREATE OR ALTER TRIGGER TRG_City_Update
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        SELECT 
            D.EID,
            D.CITY AS OLD_CITY,
            I.CITY AS NEW_CITY
        FROM DELETED D
        INNER JOIN INSERTED I
        ON D.EID = I.EID;
    END
END;


-- Q7. Create trigger for automatically setting CITY as 'RAJKOT'
-- if no city value is entered during employee insertion.

CREATE OR ALTER TRIGGER TRG_Default_City
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET CITY = 'RAJKOT'
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
    ON E.EID = I.EID
    WHERE I.CITY IS NULL;
END;


-- Q8. Create trigger for automatically adding current year
-- in JOININGYEAR if no value is entered.

CREATE OR ALTER TRIGGER TRG_Default_JoiningYear
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET JOININGYEAR = YEAR(GETDATE())
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
    ON E.EID = I.EID
    WHERE I.JOININGYEAR IS NULL;
END;


-- Q9. Create trigger for printing employee full name
-- after new employee insertion.

CREATE OR ALTER TRIGGER TRG_Print_FullNameSON on EMPLOYEE
AFTER INSERT
AS
BEGIN
    SELECT 
        FIRSTNAME + ' ' + LASTNAME AS FULL_NAME
    FROM INSERTED;
END;


-- Q10. Create trigger for automatically assigning department
-- as 'GENERAL' if DEPARTMENT value is NULL.

CREATE OR ALTER TRIGGER TRG_Default_Department
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET DEPARTMENT = 'GENERAL'
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
    ON E.EID = I.EID
    WHERE I.DEPARTMENT IS NULL;
END;



-- PART C


-- Q11. Create trigger for storing updated employee details
-- into EMPLOYEE_UPDATE_LOG table.

CREATE TABLE EMPLOYEE_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_SALARY DECIMAL(10,2),
    NEW_SALARY DECIMAL(10,2),
    OLD_DEPARTMENT VARCHAR(50),
    NEW_DEPARTMENT VARCHAR(50),
    UPDATE_DATE DATETIME
);


CREATE OR ALTER TRIGGER TRG_Employee_Update_Log
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    INSERT INTO EMPLOYEE_UPDATE_LOG
    (
        EID,
        OLD_SALARY,
        NEW_SALARY,
        OLD_DEPARTMENT,
        NEW_DEPARTMENT,
        UPDATE_DATE
    )
    SELECT
        D.EID,
        D.SALARY,
        I.SALARY,
        D.DEPARTMENT,
        I.DEPARTMENT,
        GETDATE()
    FROM DELETED D
    INNER JOIN INSERTED I
    ON D.EID = I.EID;
END;


-- Q12. Create trigger for storing newly inserted employee details
-- with insertion date into EMPLOYEE_INSERT_LOG table.

CREATE TABLE EMPLOYEE_INSERT_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    SALARY DECIMAL(10,2),
    INSERT_DATE DATETIME
);


CREATE OR ALTER TRIGGER TRG_Employee_Insert_Log
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE_INSERT_LOG
    (
        EID,
        FIRSTNAME,
        LASTNAME,
        DEPARTMENT,
        SALARY,
        INSERT_DATE
    )
    SELECT
        EID,
        FIRSTNAME,
        LASTNAME,
        DEPARTMENT,
        SALARY,
        GETDATE()
    FROM INSERTED;
END;


-- Q13. Create trigger for storing old and new FIRSTNAME values
-- after employee name update into NAME_CHANGE_LOG table.

CREATE TABLE NAME_CHANGE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_FIRSTNAME VARCHAR(50),
    NEW_FIRSTNAME VARCHAR(50),
    CHANGE_DATE DATETIME
);


CREATE OR ALTER TRIGGER TRG_Name_Change_Log
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(FIRSTNAME)
    BEGIN
        INSERT INTO NAME_CHANGE_LOG
        (
            EID,
            OLD_FIRSTNAME,
            NEW_FIRSTNAME,
            CHANGE_DATE
        )
        SELECT
            D.EID,
            D.FIRSTNAME,
            I.FIRSTNAME,
            GETDATE()
        FROM DELETED D
        INNER JOIN INSERTED I
        ON D.EID = I.EID
        WHERE D.FIRSTNAME <> I.FIRSTNAME;
    END
END;


-- Q14. Create trigger for storing old city and new city details
-- into CITY_UPDATE_LOG table after city update.

CREATE TABLE CITY_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_CITY VARCHAR(50),
    NEW_CITY VARCHAR(50),
    UPDATE_DATE DATETIME
);


CREATE OR ALTER TRIGGER TRG_City_Update_Log
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        INSERT INTO CITY_UPDATE_LOG
        (
            EID,
            OLD_CITY,
            NEW_CITY,
            UPDATE_DATE
        )
        SELECT
            D.EID,
            D.CITY,
            I.CITY,
            GETDATE()
        FROM DELETED D
        INNER JOIN INSERTED I
        ON D.EID = I.EID
        WHERE ISNULL(D.CITY,'') <> ISNULL(I.CITY,'');
    END
END;


-- Q15. Implement INSTEAD OF INSERT trigger on EMPLOYEE table
-- to automatically remove extra spaces from FIRSTNAME and LASTNAME.

CREATE OR ALTER TRIGGER TRG_Remove_Spaces
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE
    (
        EID,
        FIRSTNAME,
        LASTNAME,
        DEPARTMENT,
        SALARY,
        CITY,
        GENDER,
        JOININGYEAR
    )
    SELECT
        EID,
        LTRIM(RTRIM(FIRSTNAME)),
        LTRIM(RTRIM(LASTNAME)),
        DEPARTMENT,
        SALARY,
        CITY,
        GENDER,
        JOININGYEAR
    FROM INSERTED;
END;