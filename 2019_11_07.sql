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

