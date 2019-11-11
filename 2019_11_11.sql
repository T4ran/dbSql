--�������� �ǽ� 3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'WARD');

--ANY : �����ϴ� ���� �ϳ��� �ִ°�
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD'));

--ALL : ���� �����ϴ°�
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD'));

--DISTINCT : �ߺ� ����
--� ������ ������ ������ ���� �ʴ� ���� ���� ��ȸ
--NOT IN ������ NULL���� ������ ��� ��ȸ�� �����ʴ´�.
--���� ���ǹ��� ��ġ�� ���ؾ� �Ѵ�.
SELECT *
FROM emp
WHERE empno NOT IN
(SELECT mgr
FROM emp
WHERE mgr IS NOT NULL);

SELECT *
FROM emp
WHERE empno NOT IN
(SELECT nvl(mgr,0)
FROM emp);

--pair wise
--��� 7499, 7782�� ������ ������, �μ���ȣ ��ȸ
--�����߿� �����ڿ� �μ���ȣ�� (7698, 30)�̰ų� (7839, 10)�� ���
--mgr, deptno �÷��� ���ÿ� ������Ű�� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE (mgr, deptno) IN
(SELECT mgr, deptno
FROM emp
WHERE empno IN (7499, 7782));

SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN(SELECT deptno
              FROM emp
              WHERE empno IN (7499, 7782));
              
--SCALAR SUBQUERY : SELECT ���� �����ϴ� ���� ����(��, ���� �ϳ��� ��, �ϳ��� �÷�)
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno,
(SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;

SELECT (SELECT SYSDATE FROM dual) sdt
FROM dual;

--sub4 ������ ����
SELECT *
FROM dept;
INSERT INTO dept VALUES(99,'ddit','daejeon');
commit;

--sub �ǽ� 4
SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno FROM emp);

--�ǽ� 5
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid = 1);
                
--�ǽ� 6
--cid=2�� �����ϴ� ������ cid=1�� �����ϴ� ��ǰ�� ���� ������ ��ȸ
SELECT *
FROM cycle
WHERE pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cid = 1;
        
--�ǽ� 7
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle JOIN customer ON(cycle.cid = customer.cid) JOIN product ON(cycle.pid = product.pid)
WHERE product.pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cycle.cid = 1;

--EXISTS MAIN������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ
--�����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������
--���ɸ鿡�� ����

--MGR�� �����ϴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE EXISTS(SELECT 'x'
            FROM emp
            WHERE empno = a.mgr);
            
--MGR�� �������� �ʴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE NOT EXISTS(SELECT *
            FROM emp
            WHERE empno = a.mgr);
            
--�ǽ� 8
SELECT *
FROM emp a
WHERE mgr IS NOT NULL;

--�μ��� �Ҽӵ� ������ �ִ� �μ� ���� ��ȸ
SELECT *
FROM dept d
WHERE EXISTS(SELECT ''
            FROM emp
            WHERE deptno = d.deptno);
            
--���տ���
--����� 7566 �Ǵ� 7698�� ��� ��ȸ(���,�̸�)
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);
--UNION : ������, �ߺ��� ����, �뷮�� �����͸� ó���� �� ���ϰ� ���ϴ�.
--UNION ALL : �ߺ��� ���������ʰ�, �� �Ʒ� ������ ����, UNION �����ں��� ���ɸ鿡�� �����ϴ�.
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);

--INTERSECT(������ : �� �Ʒ� ���հ� ���� ������)
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);

--MINUS(������ : �� ���տ��� �Ʒ� ������ ���� ������)
--���� ����
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);
