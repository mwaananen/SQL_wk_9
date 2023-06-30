-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/PeNdhN
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

--Drop Table
Drop table "Titles";
Drop table "Employees";
Drop table "Departments";
Drop table "Department_Personel";
Drop table "Manager";
Drop table "Salaries";


--Create Titles table
CREATE TABLE "Titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" 
	PRIMARY KEY ("title_id")
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" 
	PRIMARY KEY ("emp_no")
);

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" 
	PRIMARY KEY ("dept_no")
);

CREATE TABLE "Department_Personel" (
    "emp_no"  int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    CONSTRAINT "pk_Department_Personel" 
	PRIMARY KEY ("emp_no","dept_no")
);

CREATE TABLE "Manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_Manager" 
	PRIMARY KEY ("dept_no","emp_no")
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

--ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title" FOREIGN KEY("emp_title")
--REFERENCES "Titles" ("title_id");

--ALTER TABLE "Department_Personel" ADD CONSTRAINT "fk_Department_Personel_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "Employees" ("emp_no");

--ALTER TABLE "Department_Personel" ADD CONSTRAINT "fk_Department_Personel_dept_no" FOREIGN KEY("dept_no")
--REFERENCES "Departments" ("dept_no");

--ALTER TABLE "Manager" ADD CONSTRAINT "fk_Manager_dept_no" FOREIGN KEY("dept_no")
--REFERENCES "Departments" ("dept_no");

--ALTER TABLE "Manager" ADD CONSTRAINT "fk_Manager_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "Workers" ("emp_no");

--ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "Employees" ("emp_no");
Select * From "Employees";
Select * From "Salaries";



--List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM "Employees" as e
join "Salaries" as s on s.emp_no = e.emp_no;

--List the first name, last name, and hire date 
--for the employees who were hired in 1986.
select e.last_name, e.first_name, e.hire_date
FROM "Employees" as e
where e.hire_date = '1986-01-01' and '1986-12-31';

--List the manager of each department 
--along with their department number, 
--department name, employee number, last name, and first name.
select e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name 
FROM "Departments" as d
join "Manager" as dm on d.dept_no = dm.dept_no
join "Employees" as e on dm.emp_no = e.emp_no;

--List the department number for each employee
--along with that employee’s employee number, 
--last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM "Employees" as e
join "Department_Personel" as dp on e.emp_no = de.emp_no
join "Departments" as d on de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee 
--whose first name is Hercules and 
--whose last name begins with the letter B.
select first_name, last_name, sex
FROM "Employees"
where first_name = "Hercules" and last_name like "B%";

--List each employee in the Sales department, 
--including their employee number, last name, and first name.
select e.emp_no, e.last_name, e.first_name
FROM "Employees" as e
join "Department_Personel" as dp on e.emp_no = de.emp_no
join "Departments" as d on de.dept_no = d.dept_no
where d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" as e
join "Department_Personel" as dp on e.emp_no = de.emp_no
join "Departments" as d on de.dept_no = d.dept_no
where d.dept_name = 'Sales and Development';

--List the frequency counts, in descending order, 
--of all the employee last names (that is, how many employees share each last name).
select last_name, count(*) as frequency
FROM Employees
group by last_name
order by frequency desc;