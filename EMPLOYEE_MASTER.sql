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