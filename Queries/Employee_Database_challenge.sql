-- Create Retirement Titles 
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM titles
INNER JOIN employees
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

-- Create Unique Titles
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
--INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no;

-- Create Retiring Tables
SELECT COUNT (title), title 
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Create Mentorship Elegibility
SELECT DISTINCT ON (employees.emp_no)employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
--INTO mentorship_eligibility
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01'
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;


-- SUMMARY RESPONSE TABLES -- 

-- COUNT total employees eligible for mentorship
SELECT COUNT (title) AS employees_eligible_mentorship, title 
--INTO employees_eligible_mentorship
FROM mentorship_eligibility
GROUP BY title
ORDER BY employees_eligible_mentorship DESC;

-- Overall employees.
SELECT DISTINCT ON (employees.emp_no) 
	employees.emp_no,
	titles.title
--INTO count_all_employees
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no;

-- overall employee count
SELECT COUNT (title) AS total_employees, title 
--INTO 
FROM count_all_employees
GROUP BY title
ORDER BY total_employees DESC;





