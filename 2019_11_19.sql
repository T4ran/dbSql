SELECT *
FROM tax;

SELECT SIDO, SIGUNGU, ROUND(sal/people, 2) point
FROM tax
ORDER BY point desc;

--�������� ���Ծ�
CREATE TABLE TAX_ORDER_BY_SAL AS
SELECT SIDO, SIGUNGU, sal, ROUND(sal/people, 2) point
FROM tax
ORDER BY sal desc;

--��������
CREATE TABLE FASTFOOD_POINT AS
SELECT main.SIDO, main.SIGUNGU, round(main.cnt/sub.cnt, 2) point
FROM (SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
GROUP BY SIDO, SIGUNGU) main FULL OUTER JOIN
(SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY SIDO, SIGUNGU) sub
ON (main.SIDO||main.SIGUNGU = sub.SIDO||sub.SIGUNGU)
WHERE round(main.cnt/sub.cnt, 2) IS NOT NULL
ORDER BY point desc;

--�õ�, �ñ���, ��������, �������� ���Ծ�
SELECT *
FROM fastfood_point;

SELECT *
FROM TAX_ORDER_BY_SAL;

SELECT a.SIDO, a.SIGUNGU, a.point FASTFOOD_POINT, b.SIDO, b.SIGUNGU, b.point TAX_POINT
FROM fastfood_point a LEFT OUTER JOIN TAX_ORDER_BY_SAL b ON (a.SIDO||a.SIGUNGU = b.SIDO||b.SIGUNGU)
ORDER BY a.point desc;

SELECT a.SIDO, a.SIGUNGU, a.POINT, b.SIDO, b.SIGUNGU, b.point
FROM
(SELECT main.SIDO, main.SIGUNGU, round(main.cnt/sub.cnt, 2) point
FROM (SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
GROUP BY SIDO, SIGUNGU) main FULL OUTER JOIN
(SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('�Ե�����')
GROUP BY SIDO, SIGUNGU) sub
ON (main.SIDO||main.SIGUNGU = sub.SIDO||sub.SIGUNGU)
ORDER BY main.SIDO, main.SIGUNGU) a,
(SELECT SIDO, SIGUNGU, sal, ROUND(sal/people, 2) point
FROM tax
ORDER BY sal desc) b
WHERE a.SIDO||a.SIGUNGU = b.SIDO||b.SIGUNGU;

--emp_test ����
drop table emp_test;

--multiple insert�� ���� �׽�Ʈ ���̺� ����
--empno, ename �ΰ��� �÷��� ���� emp_test, emp_test2 ���̺���
--emp ���̺�κ��� �����Ѵ�. (CTAS)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp
WHERE 1=2;

--INSERT ALL
--�ϳ��� INSERT SQL �������� ���� ���̺� �����͸� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 1, 'brown' FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;

SELECT *
FROM emp_test;

--INSERT ALL �÷� ����
rollback;

INSERT ALL
    INTO emp_test (empno) VALUES (empno)
    INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

--multiple insert(conditional insert)
rollback;
INSERT ALL
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


--INSERT FIRST
rollback;
INSERT FIRST
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno < 5 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 3 empno, 'brown' ename FROM dual UNION ALL
SELECT 6 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--MERGE : ���ǿ� �����ϴ� �����Ͱ� ������ UPDATE
--        ���ǿ� �����ϴ� �����Ͱ� ������ INSERT

--empno�� 7369�� �����͸� emp ���̺�κ��� ����(INSERT)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno=7369;

SELECT *
FROM emp_test;

--emp���̺��� �������� emp_test ���̺��� empno�� ���� ���� ���� �����Ͱ� �������
--emp_test.ename = ename || '_merge'������ update
--�����Ͱ� ���� ��� emp_test���̺� insert
ALTER TABLE emp_test MODIFY (ename VARCHAR(20));

MERGE INTO emp_test
USING emp ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
UPDATE SET emp_test.ename = emp.ename || '_merge'
WHEN NOT MATCHED THEN
INSERT VALUES (emp.empno, emp.ename);

--�ٸ� ���̺��� ������ �ʰ� ���̺� ��ü�� ������ ���� ������ merge �ϴ� ���

--empno=1, ename='brown'
--empno�� ���� ���� ������ ename�� 'brown'���� update
--empno�� ���� ���� ������ �ű� insert

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 1)
WHEN MATCHED THEN
    UPDATE SET ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN
    INSERT VALUES (1, 'brown');
    
SELECT *
FROM emp_test;

SELECT 'X'
FROM emp_test
WHERE empno=1;

UPDATE emp_teset set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');

--�ǽ� 1
SELECT *
FROM emp;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null, SUM(sal)
FROM emp;

--rollup
--group by�� ���� �׷��� ����
--GROUP BY ROLLUP({col,})
--�÷��� �����ʺ��� �����ذ��鼭 ���� ����׷���
--GROUP BY �Ͽ� UNION�� �Ͱ� ����
--ex : GROUP BY ROLLUP (job, deptno)
--     GROUP BY job, deptno
--     UNION
--     GROUP BY job
--     UNION
--     GROUP BY --> �Ѱ�(��� �࿡ ���� �׷��Լ� ����)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--������ ���� ������ �Ѿ��Ͽ� �ۼ�
SELECT deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

--GROUPING SETS (col1, col2...)
--GROUPING SETS�� ������ �׸��� �ϳ��� ����׷����� GROUP BY ���� �̿�ȴ�.
--GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp ���̺��� �̿��Ͽ� �μ��� �޿��հ� ������(job)�� �޿����� ���Ͻÿ�.
--�μ���ȣ, job, �޿��հ�
SELECT deptno,null job ,sum(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null, job, sum(sal)
FROM emp
GROUP BY job;

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job));