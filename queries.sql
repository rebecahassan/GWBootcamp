--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.gender,SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_no 
FROM EMPLOYEES e
WHERE e.emp_no in (
                   SELECT de.emp_no FROM DEPT_EMP de
					WHERE de.to_date > NOW()
					AND de.dept_no =
						(
							SELECT d.dept_no from DEPARTMENTS d
							WHERE d.dept_name in ('Sales', 'Development')
						)
				  )

	s.salary
FROM EMPLOYEES e
JOIN SALARIES AS s ON
e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT * 
FROM EMPLOYEES
WHERE HIRE_DATE 
BETWEEN '01/01/1986' AND '12/31/1986';

--3.List the manager of each department with the following information: department number, department name, the managers employee number, last name, first name, and start and end employment dates.
SELECT
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	e. last_name,
	e. first_name,
	dm. from_date,
	dm. to_date
FROM DEPT_MANAGER dm
JOIN DEPARTMENTS AS d ON
dm.dept_no = d.dept_no
JOIN EMPLOYEES AS e ON
dm.emp_no = e.emp_no
WHERE de.to_date > NOW();

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT
de.emp_no,
e. last_name,
e. first_name,
d.dept_name
FROM DEPT_EMP de
JOIN DEPARTMENTS AS d ON
de.dept_no = d.dept_no
JOIN EMPLOYEES AS e ON
de.emp_no = e.emp_no
WHERE de.to_date > NOW();

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM
EMPLOYEES
WHERE first_name = 'Hercules' AND
Last_name like 'B%'

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	'Sales' as dept_name
FROM EMPLOYEES e
WHERE e.emp_no in (
                   SELECT de.emp_no FROM DEPT_EMP de
					WHERE de.to_date > NOW()
					AND de.dept_no =
						(
							SELECT d.dept_no from DEPARTMENTS d
							WHERE d.dept_name = 'Sales'
						)
				  )
	
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_no 
FROM EMPLOYEES e
WHERE e.emp_no in (
                   SELECT de.emp_no FROM DEPT_EMP de
					WHERE de.to_date > NOW()
					AND de.dept_no =
						(
							SELECT d.dept_no from DEPARTMENTS d
							WHERE d.dept_name in ('Sales', 'Development')
						)
				  )


--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT
last_name, count(last_name)
FROM EMPLOYEES
GROUP BY last_name
 

 

 --1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	e.gender,
	s.salary
FROM EMPLOYEES e
JOIN SALARIES AS s ON
e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT * 
FROM EMPLOYEES
WHERE HIRE_DATE 
BETWEEN '01/01/1986' AND '12/31/1986';

--3.List the manager of each department with the following information: department number, department name, the managers employee number, last name, first name, and start and end employment dates.
SELECT
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	e. last_name,
	e. first_name,
	dm. from_date,
	dm. to_date
FROM DEPT_MANAGER dm
JOIN DEPARTMENTS AS d ON
dm.dept_no = d.dept_no
JOIN EMPLOYEES AS e ON
dm.emp_no = e.emp_no
WHERE de.to_date > NOW();

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT
de.emp_no,
e. last_name,
e. first_name,
d.dept_name
FROM DEPT_EMP de
JOIN DEPARTMENTS AS d ON
de.dept_no = d.dept_no
JOIN EMPLOYEES AS e ON
de.emp_no = e.emp_no
WHERE de.to_date > NOW();

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM
EMPLOYEES
WHERE first_name = 'Hercules' AND
Last_name like 'B%'

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	'Sales' as dept_name
FROM EMPLOYEES e
WHERE e.emp_no in (
                   SELECT de.emp_no FROM DEPT_EMP de
					WHERE de.to_date > NOW()
					AND de.dept_no =
						(
							SELECT d.dept_no from DEPARTMENTS d
							WHERE d.dept_name = 'Sales'
						)
				  )
	
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
e.emp_no,
e.last_name,
e.first_name,
 (SELECT d.dept_name from DEPARTMENTS d WHERE de. dept_no = d.dept_no)
dept_name
FROM EMPLOYEES e, DEPT_EMP de
WHERE e. emp_no = de. emp_no
AND  de.dept_no in
  (
   SELECT d.dept_no from DEPARTMENTS d
    WHERE d.dept_name = 'Sales' or d.dept_name = 'Development'
  )
  
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT
last_name, count(last_name) as total
FROM EMPLOYEES
GROUP BY last_name
ORDER BY total desc
 

 




