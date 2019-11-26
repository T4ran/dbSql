SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) drank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp;

--ana실습 1
SELECT empno, ename, sal, deptno,
RANK() OVER (ORDER BY sal desc, empno) sal_rank,
DENSE_RANK() OVER (ORDER BY sal desc, empno)sal_dense_rank,
ROW_NUMBER() OVER (ORDER BY sal desc) sal_row_number
FROM emp;

--실습 2
SELECT empno, ename, deptno,
COUNT(deptno) OVER (PARTITION BY deptno) cnt
FROM emp
GROUP BY empno, ename, deptno;

SELECT empno, ename, deptno, sal,
SUM(sal) OVER (PARTITION BY deptno) cnt
FROM emp
GROUP BY empno, ename, deptno, sal;

SELECT empno, ename, sal, deptno,
ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) cnt
FROM emp
GROUP BY empno, ename, deptno, sal;

--실습 3
SELECT empno, ename, sal, deptno,
MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp
GROUP BY empno, ename, sal, deptno;

--실습 4
SELECT empno, ename, sal, deptno,
MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp
GROUP BY empno, ename, sal, deptno;

--부서별 사원번호가 가장 낮은사람
--부서별 사원번호가 가장 높은사람
SELECT empno, ename, deptno,
FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) f_emp--,
--LAST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) l_emp
FROM emp;

--LAG(이전행)
--현재행
--LEAD (다음행)
--급여가 높은 순으로 정렬했을 때 자신보다 한단계 급여가 낮은 사람의 급여, 높은 사람의 급여
SELECT empno, ename, sal, LAG(sal) OVER (ORDER BY sal) lag_sal, LEAD(sal) OVER (ORDER BY sal) lead_sal
FROM emp;

--실습 5
SELECT empno, ename, hiredate, sal, LEAD(sal) OVER (ORDER BY sal desc, hiredate) lead_sal
FROM emp;

--실습 6
SELECT empno, ename, hiredate, job, sal,
LAG(sal) OVER (PARTITION BY job ORDER BY sal desc, hiredate) lag_sal
FROM emp;

--실습 3
--SELECT f.empno, f.ename, f.sal, (f.sum_all_sal-e.sum_sal) c_sum
--FROM
--(SELECT empno, ename, sal, (SELECT SUM(sal) FROM emp) sum_all_sal
--FROM emp group by empno, ename, sal) f
--JOIN
--(SELECT d.empno, SUM(d.b_sal) sum_sal
--FROM
--    (SELECT w.*
--    FROM
--        (SELECT c.empno, c.sal, b.sal b_sal
--        FROM emp c LEFT OUTER JOIN 
--            (SELECT a.*, rownum rn
--            FROM
--                (SELECT sal
--                FROM emp
--                ORDER BY sal, empno) a) b ON (rownum<b.rn)
--        ) w
--    WHERE w.sal<=B_SAL) d
--GROUP BY d.empno) e ON (f.empno=e.empno)
--ORDER BY sal;
--
--SELECT sal, rownum nm
--FROM emp;
--
--SELECT c.empno, c.ename, c.a_sal, SUM(c.b_sal)
--FROM (SELECT a.empno, a.ename, a.sal a_sal, b.sal b_sal
--FROM emp a LEFT OUTER JOIN 
--(
--    SELECT empno, sal
--    FROM emp
--)b ON (1=1)
--WHERE a.sal <= b.sal) c
--GROUP BY c.empno, c.ename, c.a_sal
--ORDER BY c.a_sal, c.empno;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) b_sal
FROM emp a, emp b
WHERE a.sal>=b.sal
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal, a.empno;
--중복되는 sal의 경우 원치않은 결과가 발생. rownum을 사용하여 수정할것.

--WINDOWING
--UNBOUNDED PRECEDING : 현재 행을 기준으로 선행하는 모든행
--CURRENT ROW : 현재 행
--UNBOUNDED FOLLOWING : 현재 행을 기준으로 후행하는 모든행
--N(정수) PRECEDING : 현재 행을 기준으로 선행하는 N개의 행
--N(정수) FOLLOWING : 현재 행을 기준으로 후행하는 N개의 행

SELECT empno, ename, sal,
SUM(sal) OVER 
(ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal,
SUM(sal) OVER 
(ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) sum_sal2,
SUM(sal) OVER 
(ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sum_sal3
FROM emp;

--실습 7
SELECT empno, ename, deptno, sal,
SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

--
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
                      ROWS BETWEEN UNBOUNDED PRECEDING
                      AND CURRENT ROW) rows_sum,
       SUM(sal) OVER (ORDER BY sal 
                      ROWS UNBOUNDED PRECEDING) rows_sum2,
       SUM(sal) OVER (ORDER BY sal 
                      RANGE UNBOUNDED PRECEDING) range_sum
FROM emp;