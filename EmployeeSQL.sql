-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/1vE3eF
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title" VARCHAR(10)   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "Sex" CHAR(6)   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

Select * from salaries;
Select * from employees;
--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name,  e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

---2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT e.last_name,  e.first_name, e.hire_date
FROM employees e WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d
ON dm.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no;

--4. List the department of each employee with the following information: employee number, last name, 
--first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';

SELECT * FROM departments;

--6. List all employees in the Sales department, including their employee number, last name, 
--first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR
d.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT e.last_name, COUNT(e.last_name) AS "Frequency count"
FROM employees e
GROUP BY e.last_name
ORDER BY COUNT(e.last_name) DESC;








