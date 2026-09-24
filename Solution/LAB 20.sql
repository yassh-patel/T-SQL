select * from STUDENT
--Part – A:
--1. Display rank of students based on SPI.
SELECT SNAME, SPI,
RANK() OVER (ORDER BY SPI) AS RANK_NO
FROM STUDENT;

--2. Display dense rank of students based on SPI.
SELECT SNAME, SPI,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS RANK_NO
FROM STUDENT;

--3. Display sequential number for each student record.
SELECT SNAME, SPI,
ROW_NUMBER() OVER (ORDER BY STDID) AS ROW_NO
FROM STUDENT;

--4. Display branch-wise rank of students.
SELECT SNAME, BRANCH, SPI,
RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BRANCH_RANK
FROM STUDENT;

--5. Display branch-wise dense ranking of students.
SELECT SNAME, BRANCH, SPI,
DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BRANCH_RANK
FROM STUDENT;

--6. Display branch-wise sequential numbering of students.
SELECT SNAME, BRANCH, SPI,
ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS BRANCH_ROWDNO
FROM STUDENT;

--7. Display SNAME, Current SPI, Previous SPI and SPI Difference with previous student in ascending order ofSPI.
SELECT SNAME,
SPI AS CURRENT_SPI,
LAG(SPI) OVER (ORDER BY SPI ) AS PREVIOUS_SPI,
SPI - LAG(SPI) OVER (ORDER BY SPI ) AS SPI_DIFFERENCE
FROM STUDENT;

--8. Display SNAME, Current SPI, Next SPI and SPI Difference with next student in descending order of SPI.
SELECT SNAME,
SPI AS CURRENT_SPI,
LEAD(SPI) OVER (ORDER BY SPI DESC) AS NEXT_SPI,
SPI - LEAD(SPI) OVER (ORDER BY SPI DESC) AS SPI_DIFFERENCE
FROM STUDENT;

--9. Display top 3 students based on SPI.
SELECT *
FROM
(
SELECT * ,
ROW_NUMBER() OVER(ORDER BY SPI DESC) AS RN
FROM STUDENT
) A
WHERE RN<=3

--10. Display top 2 students from each branch.
SELECT * 
FROM 
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RN
FROM STUDENT
) A
WHERE RN <= 2;

--Part – B:
--11. Display 5th highest SPI.
SELECT * FROM 
(
SELECT SNAME,SPI,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS RN
FROM STUDENT
) A
WHERE RN = 5;

--12. Display 6th highest SPI.
SELECT * FROM 
(
SELECT SNAME,SPI,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS RN
FROM STUDENT
) A
WHERE RN = 6;

--13. Display students having same ranking.
SELECT SNAME,SPI,
RANK() OVER (ORDER BY SPI DESC) AS RANK_NO
FROM STUDENT

--14. Display SNAME, Previous SPI, Current SPI and Next SPI based on ascending order of SPI.
SELECT SNAME,
LAG(SPI) OVER (ORDER BY SPI ) AS PREVIOUS_SPI,
SPI AS CURRENT_SPI,
LEAD(SPI) OVER (ORDER BY SPI ) AS NEXT_SPI
FROM STUDENT

--15. Display topper of each branch.
SELECT * FROM
(
SELECT *,
RANK() OVER(PARTITION BY BRANCH ORDER BY SPI DESC) AS RN
FROM STUDENT
) A
WHERE RN= 1

--Part – C:
--16. Display students whose SPI is greater than the previous student and less than the next student.
SELECT *
FROM
(
SELECT SNAME,SPI,
LAG(SPI) OVER (ORDER BY SPI) AS PREVIOUS_SPI,
LEAD(SPI) OVER (ORDER BY SPI) AS NEXT_SPI
FROM STUDENT
) S
WHERE SPI > PREVIOUS_SPI AND SPI < NEXT_SPI;

--17. Display branch-wise second topper students.
SELECT *
FROM
(
SELECT *,
DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS RNO
FROM STUDENT
) S
WHERE RNO = 2


--18. Display students whose rank and dense rank are different.
SELECT *
FROM
(
SELECT SNAME,SPI,
RANK() OVER (ORDER BY SPI DESC) AS RANK_NO,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS DENSE_RANK_NO
FROM STUDENT
)T
WHERE RANK_NO != DENSE_RANK_NO



--19. Display consecutive students having same branch ordered by SPI.
SELECT SNAME,BRANCH,SPI,
ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS ROW_NO
FROM STUDENT

--20. Display students whose SPI difference with previous student is maximum.


SELECT top 1 SNAME,SPI,
SPI- LAG(SPI) OVER(ORDER BY SPI ) AS D
FROM STUDENT
ORDER BY D DESC