--���� ����
--RDBMS�� Ư���� ������ �ߺ��� �ִ� ������ ���踦 �Ѵ�.
--EMP ���̺��� ������ ������ ����, �ش� ������ �Ҽ� �μ������� �μ���ȣ�� �����ְ�, �μ���ȣ�� ����
--dept ���̺�� ������ ���� �ش� �μ��� ������ ������ �� �ִ�.

--���� ��ȣ, ���� �̸�, ������ �Ҽ� �μ� ��ȣ, �μ� �̸�
--emp, dept
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept;

--�μ���ȣ, �μ���, �ش�μ��� �ο���
SELECT dept.deptno, dept.dname, COUNT(*) CNT
FROM dept JOIN emp ON(dept.deptno=emp.deptno)
GROUP BY dept.deptno, dept.dname;

SELECT COUNT(*), COUNT(empno), COUNT(mgr), COUNT(comm)
FROM emp;

--OUTER JOIN : ���� ���а� ������ �Ǿ� ������ ��ȸ
--LEFT OUTER JOIN : JOIN KEYWORD ���ʿ� ��ġ�� ���̺��� ��ȸ ������ �ǵ����ϴ� ���� ����
--RIGHT OUTER JOIN : JOIN KEYWORD �����ʿ� ��ġ�� ���̺��� ��ȸ ������ �ǵ����ϴ� ���� ����
--FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - �ߺ�����
--oracle outer join�� left, right�� �����Ѵ�.

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

--oracle outer ���������� outer ���̺��� ��� �÷��� (+)�� �ٿ���� �Ѵ�.
SELECT a.empno, a.ename, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+) = 10;

--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON(a.mgr = b.empno);

--OUTER JOIN �ǽ� 1
SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b ON(a.buy_prod = b.PROD_ID AND buy_date = TO_DATE('05/01/25','YY/MM/DD'));

SELECT a.buy_date, a.buy_prod, b.prod_id, b.prod_name, a.BUY_QTY
FROM buyprod a, prod b
WHERE a.buy_prod(+) = b.PROD_ID
AND buy_date(+) = TO_DATE('05/01/25','YY/MM/DD');

--�ǽ� 2
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

--�ǽ� 3
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

--�ǽ� 4
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT p.pid, p.pnm, nvl(c.cid,1) cid, nvl(c.day,0) day, nvl(c.cnt,0) cnt
FROM cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND c.cid = 1);

--�ǽ� 5
SELECT *
FROM customer;

SELECT p.pid, p.pnm, nvl(c.cid,1) cid, nvl(cu.cnm,'brown') cnm, nvl(c.day,0) day, nvl(c.cnt,0) cnt
FROM
(cycle c RIGHT OUTER JOIN product p ON(c.pid = p.pid AND c.cid = 1))
LEFT OUTER JOIN customer cu ON(c.cid = cu.cid);

--CROSS JOIN �ǽ� 1
SELECT c.cid, cnm, pid, pnm
FROM customer c, product p;

SELECT c.cid, cnm, pid, pnm
FROM customer c CROSS JOIN product p;

--subquery : main ������ ���ϴ� �κ� ����
--���Ǵ� ��ġ : 
--SELECT - scalar subquery(�ϳ��� ��� �ϳ��� �÷��� ��ȸ�Ǵ� ����)
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
       
--SUB �ǽ� 1         
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--�ǽ� 2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);

--�ǽ� 3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'WARD');