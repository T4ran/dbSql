--�׷��Լ�
--multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT ������ GROUP BY ���� ����� COL, EXPRESS ǥ�� ����

--������ ���� ���� �޿� ��ȸ
SELECT MAX(sal) max_sal
FROM emp;

--�μ��� ���� ���� �޿�
--GROUP BY ���� ������� ���� �÷��� SELECT���� ����� ��� ����
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

--�ǽ�4
--�Ի������� ����� �Ի��ߴ��� ��ȸ
SELECT TO_CHAR(hiredate,'YYYYMM') hire_YYYYMM, COUNT(TO_CHAR(hiredate,'YYYYMM')) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

--�ǽ�5
--�Ի�⺰�� ����� �Ի��ߴ��� ��ȸ
SELECT TO_CHAR(hiredate,'YYYY') hire_YYYY, COUNT(TO_CHAR(hiredate,'YYYY')) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');

--�ǽ�6
--ȸ�翡 �����ϴ� �μ��� �� ��ȸ
SELECT COUNT(cnt) cnt
FROM(SELECT COUNT(deptno) cnt
FROM emp
GROUP BY deptno);

desc dept;

SELECT COUNT(deptno) cnt
FROM dept;

--JOIN
--emp ���̺��� dname �÷��� ���� -> �μ���ȣ�ۿ� ����.
desc emp;

--emp���̺� DNAME�÷� �߰�
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

UPDATE emp SET dname = 'ACCONTING' WHERE DEPTNO=10;
UPDATE emp SET dname = 'RESEARCH' WHERE DEPTNO=20;
UPDATE emp SET dname = 'SALES' WHERE DEPTNO=30;
COMMIT;

ALTER TABLE emp DROP COLUMN DNAME;

--ansi natural join : ���̺��� �÷����� ���� �÷��� �������� JOIN
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

--JOIN with ON(�����ڰ� ���� �÷��� on���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

--SELF JOIN : ���� ���̺��� ����
--emp���̺��� mgr ������ �����ϱ� ���ؼ� emp ���̺�� ������ �ؾ��Ѵ�.
--a : ��������, b : ������
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

--�ǽ� 0
SELECT a.empno, a.ename, a.deptno, b.dname
FROM emp a JOIN dept b ON(a.deptno = b.deptno)
ORDER BY a.deptno;