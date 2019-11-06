--그룹함수
--multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT 절에는 GROUP BY 절에 기술된 COL, EXPRESS 표기 가능

--직원중 가장 높은 급여 조회
SELECT MAX(sal) max_sal
FROM emp;

--부서별 가장 높은 급여
--GROUP BY 절에 기술되지 않은 컬럼이 SELECT절에 기술될 경우 에러
SELECT
DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 'DDIT') DNAME,
MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 'DDIT')
ORDER BY max_sal DESC;

SELECT
CASE
    WHEN deptno = 10 then 'ACCOUNTING'
    WHEN deptno = 20 then 'RESEARCH'
    WHEN deptno = 30 then 'SALES'
    else 'DDIT'
END DNAME,
MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY
CASE
    WHEN deptno = 10 then 'ACCOUNTING'
    WHEN deptno = 20 then 'RESEARCH'
    WHEN deptno = 30 then 'SALES'
    else 'DDIT'
END
ORDER BY max_sal DESC;

--실습4
--입사년월별로 몇명이 입사했는지 조회
SELECT TO_CHAR(hiredate,'YYYYMM') hire_YYYYMM, COUNT(TO_CHAR(hiredate,'YYYYMM')) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

--실습5
--입사년별로 몇명이 입사했는지 조회
SELECT TO_CHAR(hiredate,'YYYY') hire_YYYY, COUNT(TO_CHAR(hiredate,'YYYY')) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');

--실습6
--회사에 존재하는 부서의 수 조회
SELECT COUNT(cnt) cnt
FROM(SELECT COUNT(deptno) cnt
FROM emp
GROUP BY deptno);

desc dept;

SELECT COUNT(deptno) cnt
FROM dept;

--JOIN
--emp 테이블에는 dname 컬럼이 없다 -> 부서번호밖에 없음.
desc emp;

--emp테이블에 DNAME컬럼 추가
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

UPDATE emp SET dname = 'ACCONTING' WHERE DEPTNO=10;
UPDATE emp SET dname = 'RESEARCH' WHERE DEPTNO=20;
UPDATE emp SET dname = 'SALES' WHERE DEPTNO=30;
COMMIT;

ALTER TABLE emp DROP COLUMN DNAME;

--ansi natural join : 테이블의 컬럼명이 같은 컬럼을 기준으로 JOIN
SELECT deptno, emp.ename, dept.dname
FROM emp NATURAL JOIN DEPT;

--ORACLE join
SELECT emp.empno, emp.ename, emp.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI JOING WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.job = 'SALESMAN';

--JOIN with ON(개발자가 조인 컬럼을 on절에 직접 기술)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

--SELF JOIN : 같은 테이블끼리 조인
--emp테이블의 mgr 정보를 참고하기 위해서 emp 테이블과 조인을 해야한다.
--a : 직원정보, b : 관리자
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON(a.mgr = b.empno)
WHERE a.empno between 7369 and 7698;

SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno between 7369 and 7698
AND a.mgr = b.empno;

--non-equijoing
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

desc dept;

--실습 0
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
ORDER BY a.deptno;