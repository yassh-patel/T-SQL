--From the table STUDENT perform the following queries:
--Part – A:
--1. Create a table valued function to display all student records.
CREATE FUNCTION FN_ALL_STUDENT()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM STUDENT
);

SELECT * FROM FN_ALL_STUDENT();
--2. Create a table valued function that accepts CITY and returns all students from that city.
CREATE FUNCTION FN_STUDENT_CITY
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE CITY = @CITY
);

SELECT * FROM FN_STUDENT_CITY('RAJKOT');
--3. Create a table valued function that accepts BRANCH and returns all students of that branch.
CREATE FUNCTION FN_STUDENT_BRANCH
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH = @BRANCH
);

SELECT * FROM FN_STUDENT_BRANCH('COMPUTER');
--4. Create a table valued function that accepts SPI and returns students whose SPI is greater than entered SPI.
CREATE FUNCTION FN_STUDENT_SPI
(
    @SPI DECIMAL(4,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE SPI > @SPI
);

SELECT * FROM FN_STUDENT_SPI(8.00);

--5. Create a table valued function that accepts MIN_SPI and MAX_SPI and returns students whose SPI lies
--between given range.
CREATE FUNCTION FN_SPI_RANGE
(
    @MIN_SPI DECIMAL(4,2),
    @MAX_SPI DECIMAL(4,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE SPI BETWEEN @MIN_SPI AND @MAX_SPI
);

SELECT * FROM FN_SPI_RANGE(7.00, 9.00);



--Part – B:
--6. Create a table valued function that accepts STDID and returns details of that student.

CREATE FUNCTION FN_STUDENT_ID
(
    @STDID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE STDID = @STDID
);

SELECT * FROM FN_STUDENT_ID(101);

--7. Create a table valued function that accepts CITY and returns students whose SPI is greater than 7 from
--that city.

CREATE FUNCTION FN_CITY_SPI
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE CITY = @CITY
      AND SPI > 7
);

SELECT * FROM FN_CITY_SPI('RAJKOT');
--8. Create a table valued function that accepts BRANCH and returns students whose SPI is less than 8 from
--that branch.

CREATE FUNCTION FN_BRANCH_SPI
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH = @BRANCH
      AND SPI < 8
);

SELECT * FROM FN_BRANCH_SPI('COMPUTER');

--9. Create a table valued function that accepts TOPN and returns top N students based on SPI.

CREATE FUNCTION FN_TOP_STUDENT
(
    @TOPN INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@TOPN) *
    FROM STUDENT
    ORDER BY SPI DESC
);

SELECT * FROM FN_TOP_STUDENT(3);
--10. Create a table valued function that accepts BRANCH and returns highest SPI student from that branch.

CREATE FUNCTION FN_TOP_BRANCH
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 *
    FROM STUDENT
    WHERE BRANCH = @BRANCH
    ORDER BY SPI DESC
);

SELECT * FROM FN_TOP_BRANCH('COMPUTER');



--Part – C:
--11. Create a table valued function that accepts CITY and returns total students from that city.
CREATE FUNCTION FN_CITY_TOTAL
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT COUNT(*) AS Total_Students
    FROM STUDENT
    WHERE CITY = @CITY
);

SELECT * FROM FN_CITY_TOTAL('RAJKOT');
--12. Create a table valued function that accepts BRANCH and returns students ordered by SPI in descending
--order.
CREATE FUNCTION FN_BRANCH_ORDER
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE BRANCH = @BRANCH
);

SELECT *
FROM FN_BRANCH_ORDER('COMPUTER')
ORDER BY SPI DESC;

--13. Create a table valued function that accepts CITY and returns top 3 student from that city based on SPI.
CREATE FUNCTION FN_TOP3_CITY
(
    @CITY VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 3 *
    FROM STUDENT
    WHERE CITY = @CITY
    ORDER BY SPI DESC
);

SELECT * FROM FN_TOP3_CITY('RAJKOT');
--14. Create a table valued function that accepts STDID and returns student rank based on SPI (RANK).
CREATE FUNCTION FN_STUDENT_RANK
(
    @STDID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *,
        RANK() OVER (ORDER BY SPI DESC) AS Student_Rank
    FROM STUDENT
    WHERE STDID = @STDID
);

SELECT * FROM FN_STUDENT_RANK(101);
--15. Create a table valued function that accepts BRANCH and returns students having second highest SPI
--from that branch.

CREATE FUNCTION FN_SECOND_TOPPER
(
    @BRANCH VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM
    (
        SELECT *,
               DENSE_RANK() OVER(ORDER BY SPI DESC) AS R
        FROM STUDENT
        WHERE BRANCH = @BRANCH
    ) AS T
    WHERE R = 2
);

SELECT * FROM FN_SECOND_TOPPER('COMPUTER');
