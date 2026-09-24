
SELECT * FROM STUDENT
-- PART - A

-- Q1. Display all students whose SPI is greater than 8.
WITH CTE AS
(
    SELECT *
    FROM STUDENT
    WHERE SPI > 8
)
SELECT *
FROM CTE



-- Q2. Display average SPI of all students.
WITH CTE AS
(
    SELECT AVG(SPI) AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM CTE;


-- Q3. Display total number of students in each branch.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL_STUDENT
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE;


-- Q4. Display students who belong to RAJKOT city.
WITH CTE AS
(
    SELECT *
    FROM STUDENT
    WHERE CITY = 'RAJKOT'
)
SELECT *
FROM CTE;


-- Q5. Find branch names that appear more than once.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT BRANCH
FROM CTE
WHERE TOTAL > 1;


-- Q6. Display row number for each student.
WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER(ORDER BY STDID) AS ROW_NO
    FROM STUDENT
)
SELECT *
FROM CTE;


-- Q7. Display top 3 students based on SPI.
WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER(ORDER BY SPI DESC) AS RN
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE RN <= 3;


-- Q8. Display students having maximum SPI.
WITH CTE AS
(
    SELECT *,
           MAX(SPI) OVER() AS MAX_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI = MAX_SPI;


-- Q9. Display students having minimum SPI.
WITH CTE AS
(
    SELECT *,
           MIN(SPI) OVER() AS MIN_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI = MIN_SPI;


-- Q10. Display branch-wise rank of students.
WITH CTE AS
(
    SELECT *,
           RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RN
    FROM STUDENT
)
SELECT *
FROM CTE;


-- PART - B

-- Q11. Display students SPI average belonging to Computer branch.
WITH CTE AS
(
    SELECT AVG(SPI) AS AVG_SPI
    FROM STUDENT
    WHERE BRANCH = 'COMPUTER'
)
SELECT *
FROM CTE;


-- Q12. Display students whose SPI is greater than average SPI of their branch.
WITH CTE AS
(
    SELECT *,
           AVG(SPI) OVER(PARTITION BY BRANCH) AS BRANCH_AVG
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI > BRANCH_AVG;


-- Q13. Display branch having more than 2 students.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT BRANCH
FROM CTE
WHERE TOTAL > 2;


-- Q14. Display branches having average SPI between 7 and 9.
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE AVG_SPI BETWEEN 7 AND 9;


-- Q15. Display students whose SPI is lower than overall average SPI.
WITH CTE AS
(
    SELECT *,
           AVG(SPI) OVER() AS AVG_SPI
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI < AVG_SPI;


-- PART - C

-- Q16. Display branches having exactly one student.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL
    FROM STUDENT
    GROUP BY BRANCH
)
SELECT *
FROM CTE
WHERE TOTAL = 1;


-- Q17. Display branch having highest average SPI.
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
),
CTE2 AS
(
    SELECT *,
           RANK() OVER( ORDER BY AVG_SPI DESC) AS RN
    FROM CTE
)
SELECT *
FROM CTE2
WHERE RN = 1;




-- Q18. Display branch having lowest average SPI.
WITH CTE AS
(
    SELECT BRANCH, AVG(SPI) AS AVG_SPI
    FROM STUDENT
    GROUP BY BRANCH
),
CTE2 AS
(
    SELECT *,
           RANK() OVER(ORDER BY AVG_SPI) AS RN
    FROM CTE
)
SELECT BRANCH, AVG_SPI
FROM CTE2
WHERE RN = 1;


-- Q19. Display students whose SPI is lower than branch average SPI.
WITH CTE AS
(
    SELECT *,
           AVG(SPI) OVER(PARTITION BY BRANCH) AS BRANCH_AVG
    FROM STUDENT
)
SELECT *
FROM CTE
WHERE SPI < BRANCH_AVG;


-- Q20. Display branches having maximum number of students.
WITH CTE AS
(
    SELECT BRANCH, COUNT(*) AS TOTAL
    FROM STUDENT
    GROUP BY BRANCH
),
CTE2 AS
(
    SELECT *,
           RANK() OVER(ORDER BY TOTAL DESC) AS RN
    FROM CTE
)
SELECT *
FROM CTE2
WHERE RN = 1;