-- New table containing retiring employee number, first, last name, title, hire date, salary
--65424 results in the list
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, s.salary
INTO retirement_info_with_title
FROM retirement_info as e
INNER JOIN title as t 
ON (e.emp_no=t.emp_no)
INNER JOIN salaries as s
ON (e.emp_no=s.emp_no)

-- Create a new table with title duplicates removed
-- 41380 results
SELECT emp_no, first_name, last_name, title, from_date, salary
INTO retirement_info_without_duplicate_title
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   		FROM retirement_info_with_title) tmp 
WHERE rn = 1;

--frequency count of the employee title 
select title, count(title)
into count_by_title
from retirement_info_without_duplicate_title
group by title

-- List of potential mentors
-- 1549 count
Select e.emp_no, e.first_name,e.last_name, t.title, t.from_date, t.to_date
into mentor_data
from employees as e
inner join title as t
on(e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (t.to_date = ('9999-01-01'));