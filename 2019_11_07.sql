/*
emp ���̺��� �μ���ȣ�� ����
emp ���̺��� �μ����� ��ȸ�ϱ� ���ؼ��� dept ���̺�� ������ ���� �μ��� ��ȸ

join
ANSI :
���̺�� JOIN ���̺�2 ON (���̺�.COL = ���̺�2.COL)
emp JOIN dept ON (emp.deptno = dept.deptno)

ORACLE :
FORM ���̺�, ���̺�2 WHERE ���̺�.COL = ���̺�2.COL
FROM emp, dept 
WHERE emp.deptno = dept.deptno
*/

--�����ȣ, �����, �μ���ȣ, �μ���
SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�ǽ� 2
SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
AND sal > 2500
ORDER BY a.deptno;

SELECT a.empno, a.ename, a.sal, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
WHERE sal > 2500
ORDER BY a.deptno;

--�ǽ� 3
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

--�ǽ� 4
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

--������ ���� �ǽ�
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod_lgu = lprod_gu)
ORDER BY lprod_gu;

--������ ���� �ǽ� 2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM  prod JOIN buyer ON(prod_buyer = buyer_id)
ORDER BY buyer_id;

--������ ���� �ǽ� 3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE mem_id = cart_member
AND cart_prod = prod_id;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(mem_id=cart_member) JOIN prod ON(cart_prod=prod_id);

--������ ���� �ǽ� 4
SELECT customer.cid, cnm, pid, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
WHERE cnm = 'brown' OR cnm = 'sally';

--������ ���� �ǽ� 5
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON(cycle.pid = product.pid)
WHERE cnm = 'brown' OR cnm = 'sally';

--������ ���� �ǽ� 6
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt) cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON(cycle.pid = product.pid)
GROUP BY customer.cid, cnm, cycle.pid, pnm
ORDER BY cid;

--������ ���� �ǽ� 7
SELECT cycle.pid, pnm, SUM(cnt) cnt
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm
ORDER BY pid;

--������ ���� �ǽ� 8
SELECT regions.region_id, region_name, country_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id);