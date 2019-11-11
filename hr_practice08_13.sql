--실습 8
SELECT regions.region_id, region_name, country_name
FROM regions JOIN countries ON (regions.region_id = countries.region_id);

--실습 9
SELECT regions.region_id, region_name, country_name, city
FROM regions JOIN countries ON (regions.region_id = countries.region_id)
JOIN locations ON (countries.country_id = locations.country_id)
WHERE region_name = 'Europe';

--실습 10
SELECT regions.region_id, region_name, country_name, city, department_name
FROM regions JOIN countries ON (regions.region_id = countries.region_id)
JOIN locations ON (countries.country_id = locations.country_id)
JOIN departments ON (locations.location_id = departments.location_id)
WHERE region_name = 'Europe';

--실습 11
SELECT regions.region_id, region_name, country_name, city, department_name, first_name||last_name name
FROM regions JOIN countries ON (regions.region_id = countries.region_id)
JOIN locations ON (countries.country_id = locations.country_id)
JOIN departments ON (locations.location_id = departments.location_id)
RIGHT OUTER JOIN employees ON (departments.department_id = employees.department_id)
WHERE region_name = 'Europe';

--실습 12
SELECT employee_id, first_name||last_name name, employees.job_id, job_title
FROM employees JOIN jobs ON (employees.job_id = jobs.job_id);

--실습 13
SELECT a.manager_id mng_id, b.first_name||b.last_name mgr_name,
a.employee_id, a.first_name||a.last_name name, a.job_id, jobs.job_title
FROM employees a JOIN employees b ON (a.manager_id = b.employee_id)
JOIN jobs ON(a.job_id = jobs.job_id);