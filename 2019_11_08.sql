--조인 복습
--RDBMS의 특성상 데이터 중복을 최대 배제한 설계를 한다.
--EMP 테이블에는 직원의 정보가 존재, 해당 직원의 소속 부서정보는 부서번호만 갖고있고, 부서번호를 통해
--dept 테이블과 조인을 통해 해당 부서의 정보를 가져올 수 있다.

--직원 번호, 직원 이름, 직원의 소속 부서 번호, 부서 이름
--emp, dept
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept;

--부서번호, 부서명, 해당부서의 인원수
SELECT dept.deptno, dept.dname, COUNT(*) CNT
FROM dept JOIN emp ON(dept.deptno=emp.deptno)
GROUP BY dept.deptno, dept.dname;

SELECT COUNT(*), COUNT(empno), COUNT(mgr), COUNT(comm)
FROM emp;

--OUTER JOIN : 조인 실패가 기준이 되어 데이터 조회
--LEFT OUTER JOIN : JOIN KEYWORD 왼쪽에 위치한 테이블이 조회 기준이 되도록하는 조인 형태
--RIGHT OUTER JOIN : JOIN KEYWORD 오른쪽에 위치한 테이블이 조회 기준이 되도록하는 조인 형태
--FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - 중복제거
--oracle outer join은 left, right만 존재한다.

SELECT a.empno, a.ename, a.mgr, b.ename mname
FROM emp a JOIN emp b ON(b.empno = a.mgr);

SELECT a.empno, a.ename, a.mgr, b.ename mname
FROM emp a LEFT OUTER JOIN emp b ON(b.empno = a.mgr);

SELECT a.empno, a.ename, a.mgr, b.ename mname
FROM emp a, emp b
WHERE a.mgr = b.empno(+);

SELECT a.empno, a.ename, a.mgr, b.ename mname
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno)
WHERE b.deptno = 10;

--oracle outer 문법에서는 outer 테이블인 모든 컬럼에 (+)를 붙여줘야 한다.
SELECT a.empno, a.ename, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+) = 10;

--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON(a.mgr = b.empno);

--OUTER JOIN 실습 1
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a, prod b
WHERE a.buy_prod(+) = b.PROD_ID
AND buy_date(+) = TO_DATE('05/01/25','YY/MM/DD');

--실습 2
SELECT 
DECODE(a.buy_date,NULL,TO_DATE('05/01/25','YY/MM/DD'),a.buy_date) buy_date,
a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

SELECT 
CASE
    WHEN a.buy_date IS NULL
    THEN TO_DATE('05/01/25','YY/MM/DD')
    else a.buy_date
END buy_date,
a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

--실습 3
SELECT 
DECODE(a.buy_date,NULL,TO_DATE('05/01/25','YY/MM/DD'),a.buy_date) buy_date,
a.buy_prod, b.prod_id, b.prod_name, 
DECODE(a.BUY_QTY,NULL,0,buy_qty) buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

SELECT 
DECODE(a.buy_date,NULL,TO_DATE('05/01/25','YY/MM/DD'),a.buy_date) buy_date,
a.buy_prod, b.prod_id, b.prod_name, 
nvl(a.buy_qty,0) buy_qty
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

--실습 4
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT p.pid, p.pnm, nvl(c.cid,1) cid, nvl(c.day,0) day, nvl(c.cnt,0) cnt
FROM cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND c.cid = 1);

--실습 5
SELECT *
FROM customer;

SELECT p.pid, p.pnm, nvl(c.cid,1) cid, nvl(cu.cnm,'brown') cnm, nvl(c.day,0) day, nvl(c.cnt,0) cnt
FROM
(cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND c.cid = 1))
LEFT OUTER JOIN customer cu ON(c.cid = cu.cid);

--CROSS JOIN 실습 1
SELECT c.cid, cnm, pid, pnm
FROM customer c, product p;

SELECT c.cid, cnm, pid, pnm
FROM customer c CROSS JOIN product p;

--subquery : main 쿼리에 속하는 부분 쿼리
--사용되는 위치 : 
--SELECT - scalar subquery(하나의 행과 하나의 컬럼만 조회되는 쿼리)
--FROM - inline view
--WHERE - subquery

--SCALAR subquery
SELECT empno, ename, (SELECT SYSDATE FROM dual) now
FROM emp;

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
       
--SUB 실습 1         
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--실습 2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--실습 3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'WARD');