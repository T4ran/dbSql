--�������� �ǽ� 3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'WARD');