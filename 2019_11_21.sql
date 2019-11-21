--��ü ������ �޿����
SELECT ROUND(AVG(sal),2)
FROM emp;

--�μ��� ������ �޿� ���
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;

SELECT a.empno, a.ename, a.deptno, b.avg_sal
FROM emp a JOIN (SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno) b ON (a.deptno = b.deptno);

SELECT a.empno, a.ename, c.job, a.deptno, a.sal, c.sal, a.avg_sal
FROM emp_test c JOIN (SELECT a.empno, a.ename, a.sal, a.deptno, b.avg_sal
FROM emp a JOIN (SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno) b ON (a.deptno = b.deptno)) a ON (c.empno = a.empno);