CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
DROP TABLE titles;


CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no
;

DROP TABLE unique_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
	retirement_titles.first_name,
	retirement_titles.last_name,
	retirement_titles.title

INTO unique_titles
FROM retirement_titles
WHERE (to_date='9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

SELECT * FROM unique_titles

DROP TABLE retiring_titles;

SELECT COUNT(unique_titles.emp_no), unique_titles.title
INTO retiring_titles
FROM unique_titles 
GROUP BY unique_titles.title
ORDER BY COUNT (unique_titles.emp_no) DESC;

SELECT * FROM retiring_titles;

--Deliverable 2
CREATE TABLE dept_emp (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_elligibility
FROM employees
	INNER JOIN dept_emp
	ON (employees.emp_no = dept_emp.emp_no)
	INNER JOIN titles 
	ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (dept_emp.to_date= '9999-01-01')
ORDER BY employees.emp_no;

SELECT * FROM mentorship_elligibility;
