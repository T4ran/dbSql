--
desc emp;

INSERT INTO emp(empno, ename, job)
VALUES (9999,'brown',null);

SELECT *
FROM emp
WHERE empno=9999;

rollback;

desc emp;

SELECT *
FROM user_tab_columns
WHERE table_name = 'EMP'
ORDER BY column_id;

INSERT INTO emp VALUES(9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);
commit;

SELECT *
FROM emp;
rollback;

DELETE emp
WHERE empno=9999;

INSERT INTO emp(empno, ename)
SELECT deptno, dname
FROM dept;

--UPDATE
--UPDATE ���̺� SET �÷�=��, �÷�=��...
--WHERE condition

SELECT *
FROM dept;

UPDATE dept SET dname='���IT', loc='ym'
WHERE deptno = 99;

SELECT *
FROM emp;

--�����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE emp
WHERE empno = 9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5�� ������ ����
DELETE emp
WHERE empno IN
(SELECT deptno
FROM dept);

rollback;

DELETE emp
WHERE empno < 100;

commit;

------TRUNCATE
----TRUNCATE TABLE dept;
--������ ���� �ʴ� ���� ���.
--�α׸� ������ �ʰ� �����Ѵ�.

--LV1 --> LV3
SET TRANSACTION isolation LEVEL SERIALIZABLE;
--LV1
SET TRANSACTION isolation LEVEL READ COMMITTED;

--table����
--DDL : AUTO COMMIT, rollback�� �ȵȴ�.
--CREATE
CREATE TABLE ranger_new(
    ranger_no NUMBER,   --���� Ÿ��
    ranger_name VARCHAR2(50),   --���� : VARCHAR2, CHAR
    reg_dt DATE DEFAULT sysdate     --DEFAULT : SYSDATE
);

desc ranger_new;

--ddl rollback �õ�
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000,'brown');

SELECT *
FROM ranger_new;
commit;

--table����
--DROP TABLE TABLE_NAME
DROP TABLE ranger_new;

--��¥ Ÿ�Կ��� Ư�� �ʵ� ��������
--ex : sysdate���� �⵵�� ��������
SELECT TO_CHAR(sysdate,'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, TO_CHAR(reg_dt,'MM'),
EXTRACT(MONTH FROM reg_dt) mm, EXTRACT(YEAR FROM reg_dt) year, EXTRACT(DAY FROM reg_dt) day
FROM ranger_new;

--��������
--DEPT ����Ͽ� DEPT_TEST ����
desc dept;
CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY,   --deptno �÷��� �ĺ��ڷ� ����. �����Ǿ��� �� ���� �ߺ��� �� �� ������ ���� null�� ���� ����.
    dname varchar2(14),
    loc varchar2(13)
);

--PRIMARY KEY ���� ���� Ȯ��
--1. deptno�÷��� null�� �� �� ����.
--2. deptno�÷��� �ߺ��� ���� �� �� ����.

INSERT INTO dept_test (deptno, dname, loc)
VALUES(null,'ddit','daejeon');
/*����� 121 �࿡�� �����ϴ� �� ���� �߻� -
INSERT INTO dept_test (deptno, dname, loc)
VALUES(null,'ddit','daejeon')
���� ���� -
ORA-01400: cannot insert NULL into ("PC07"."DEPT_TEST"."DEPTNO")*/

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(1,'ddit2','daejeon');
/*����� 130 �࿡�� �����ϴ� �� ���� �߻� -
INSERT INTO dept_test VALUES(1,'ddit2','daejeon')
���� ���� -
ORA-00001: unique constraint (PC07.SYS_C007114) violated*/

rollback;

--����� ���� �������Ǹ��� �ο��� PRIMARY KEY
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(1,'ddit2','daejeon');

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(2,null,'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(2,'ddit','daejeon');

rollback;