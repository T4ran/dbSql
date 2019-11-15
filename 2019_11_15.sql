--emp ���̺� empno�÷��� �������� PRIMARY KEY�� ����
--PRIMARY KEY = UNIQUE + NOT NULL
--UNIQUE => �ش� �÷����� UNIQUE INDEX�� �ڵ����� ����

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7369;

SELECT *
FROM TABLE(dbms_xplan.display);

--empno �÷����� �ε����� �����ϴ� ��Ȳ���� �ٸ� �÷� ������ �����͸� ��ȸ �ϴ� ���
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

--�ε��� ���� �÷��� SELECT ���� ����� ���
--���̺� ������ �ʿ� ����.

--�÷��� �ߺ��� ������ non-unique �ε��� ������
--unique index���� �����ȹ ��
--PRIMARY KEY ���� ���� ����(unique �ε��� ����)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX IDX_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp ���̺� job�÷����� �ι�° �ε��� ����
--job �÷��� �ٸ� �ο��� job �÷��� �ߺ��� ������ �÷��̴�.
CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--emp ���̺� job, ename �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_emp_03 ON emp (job, ename);

--emp ���̺� ename, job �÷��� �������� non-unique �ε��� ����
CREATE INDEX idx_emp_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename LIKE '%C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--HINT�� ����� �����ȹ ����
EXPLAIN PLAN FOR
SELECT /*+ INDEX(emp idx_emp_04)*/ *
FROM emp
WHERE job='MANAGER'
AND ename LIKE '%C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--CREATE INDEX idx_emp_04 ON emp (ename, job);
--index �ǽ� 1
CREATE TABLE DEPT_TEST AS SELECT * FROM DEPT WHERE 1 = 1;

CREATE UNIQUE INDEX idx_dept_test_01 ON dept_test (deptno);

CREATE INDEX idx_dept_test_02 ON dept_test (dname);

CREATE INDEX idx_dept_test_03 ON dept_test (deptno, dname);

--index �ǽ� 2
DROP INDEX idx_dept_test_01;
DROP INDEX idx_dept_test_02;
DROP INDEX idx_dept_test_03;

--index �ǽ� 3
CREATE INDEX idx_emp_test_01 ON emp (empno);
CREATE INDEX idx_emp_test_02 ON emp (ename);
CREATE INDEX idx_emp_test_03 ON emp (sal, deptno);
CREATE INDEX idx_emp_test_04 ON emp (deptno);
CREATE INDEX idx_emp_test_05 ON emp (mgr, deptno);

DROP INDEX idx_emp_test_041;

EXPLAIN PLAN FOR
SELECT *
FROM EMP, DEPT
WHERE EMP.deptno = DEPT.deptno
AND EMP.deptno = 10
AND EMP.empno LIKE '78%';

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT B.*
FROM EMP A, EMP B
WHERE A.mgr = B.empno
AND A.deptno=30;

SELECT *
FROM TABLE(dbms_xplan.display);

