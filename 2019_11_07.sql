/*
emp 테이블에는 부서번호만 존재
emp 테이블에서 부서명을 조회하기 위해서는 dept 테이블과 조인을 통해 부서명 조회

join
ANSI :
테이블명 JOIN 테이블2 ON (테이블.COL = 테이블2.COL)
emp JOIN dept ON (emp.deptno = dept.deptno)

ORACLE :
FORM 테이블, 테이블2 WHERE 테이블.COL = 테이블2.COL
FROM emp, dept 
WHERE emp.deptno = dept.deptno
*/

--사원번호, 사원명, 부서번호, 부서명
SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--실습 2
SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
AND sal > 2500
ORDER BY a.deptno;

SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
WHERE sal > 2500
ORDER BY a.deptno;

--실습 3
SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
AND sal > 2500
AND empno > 7600
ORDER BY a.deptno;

SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
WHERE sal > 2500
AND empno > 7600
ORDER BY a.deptno;

--실습 4
SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
AND sal > 2500
AND empno > 7600
AND dname = 'RESEARCH'
ORDER BY a.deptno;

SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
WHERE sal > 2500
AND empno > 7600
AND dname = 'RESEARCH'
ORDER BY a.deptno;

SELECT *
FROM prod;

SELECT *
FROM lprod;

--데이터 결합 실습
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod_lgu = lprod_gu)
ORDER BY lprod_gu;

--데이터 결합 실습 2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM  prod JOIN buyer ON(prod_buyer = buyer_id)
ORDER BY buyer_id;

--데이터 결합 실습 3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE mem_id = cart_member
AND cart_prod = prod_id;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(mem_id=cart_member) JOIN prod ON(cart_prod=prod_id);

--데이터 결합 실습 4
SELECT customer.cid, cnm, pid, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
WHERE cnm = 'brown' OR cnm = 'sally';

--데이터 결합 실습 5
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON(cycle.pid = product.pid)
WHERE cnm = 'brown' OR cnm = 'sally';

--데이터 결합 실습 6
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt) cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON(cycle.pid = product.pid)
GROUP BY customer.cid, cnm, cycle.pid, pnm
ORDER BY cid;

--데이터 결합 실습 7
SELECT cycle.pid, pnm, SUM(cnt) cnt
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm
ORDER BY pid;

--데이터 결합 실습 8
SELECT regions.region_id, region_name, country_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id);