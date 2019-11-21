--
SELECT job, deptno,
    GROUPING(job), GROUPING(deptno), sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--GROUPING(cube, rollup 절의 사용된 컬럼)
--해당 컬럼이 소계 계산에 사용된 경우 1 사용되지 않은 경우 2

--case1. GROUPING(job)=1 AND GROUPING(deptno)=1
--      job --> '총계'
--cese else
--      job --> job
SELECT CASE WHEN GROUPING(job)=1 AND GROUPING(deptno)=1 THEN '총계'
       ELSE job
       END job,
       CASE WHEN GROUPING(job)=0 AND GROUPING(deptno)=1 THEN job||' : 소계'
       WHEN GROUPING(job)=0 AND GROUPING(deptno)=0 THEN TO_CHAR(deptno)
       ELSE ' '
       END deptno,
    GROUPING(job), GROUPING(deptno), sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--실습 3
SELECT deptno, job, sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno, job);

--실습 4
SELECT b.dname, job, sum(sal) sal
FROM emp JOIN dept b ON (emp.deptno = b.deptno)
GROUP BY ROLLUP(b.dname, job);

--실습 5
SELECT 
CASE WHEN GROUPING(dname)=1 AND GROUPING(job)=1 THEN '총합'
ELSE dname
END dname, job, sum(sal) sal--, GROUPING(dname), GROUPING(job)
FROM emp JOIN dept b ON (emp.deptno = b.deptno)
GROUP BY ROLLUP(b.dname, job);

--CUBE (col1, col2...)      --방향성이 없다. ROLLUP과 차이
--GROUP BY CUBE (job, deptno)
--00 : GROUP BY job, deptno
--0X : GROUP BY job
--X0 : GROUP BY deptno
--XX : 모든 데이터에 대해서

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);

---------------------------------------------------------

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY deptno, job;

---------------------------------------------------------
--subquery advanced
CREATE TABLE emp_test AS 
SELECT *
FROM emp;

SELECT *
FROM emp_test;

ALTER TABLE emp_test ADD (dname varchar2(14));

UPDATE emp_test
SET dname = 
(SELECT dname
FROM dept
WHERE emp_test.deptno = dept.deptno);

commit;

ALTER TABLE dept_test ADD (empcnt number);

SELECT * FROM dept_test;

--실습 1
UPDATE dept_test
SET empcnt =
(SELECT COUNT(deptno) FROM emp_test WHERE dept_test.deptno = emp_test.deptno);

--실습 2
insert into dept_test values(98,'it2','daejeon',null);

commit;

delete dept_test
WHERE deptno NOT IN (
    SELECT deptno
    FROM (
        SELECT deptno, COUNT(*)
        FROM emp_test 
        GROUP BY deptno));

DELETE dept_test
WHERE NOT EXISTS (SELECT deptno
                  FROM emp_test
                  WHERE emp_test.deptno = dept_test.deptno);

--실습 3
UPDATE emp_test
SET sal = sal + 200
WHERE empno IN(
    SELECT empno
    FROM emp_test a JOIN (SELECT deptno, AVG(sal) avg
                          FROM emp_test
                          GROUP BY deptno) b ON(a.deptno = b.deptno)
    WHERE sal < avg);
    
SELECT *
FROM emp_test;

--emp, emp_test empno컬럼으로 같은 값 끼리 조회
--1. emp.empno, emp.ename, emp.sal, emp_test.sal
--2. emp.empno, emp.ename, emp.sal, emp_test.sal, 해당 사원이 속한 부서의 급여평균(emp기준)
SELECT a.empno, a.ename, c.job, a.deptno, a.sal, c.sal, a.avg_sal
FROM emp_test c JOIN (SELECT a.empno, a.ename, a.sal, a.deptno, b.avg_sal
FROM emp a JOIN (SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno) b ON (a.deptno = b.deptno)) a ON (c.empno = a.empno);