--�������� Ȱ��ȭ / ��Ȱ��ȭ
--� ���������� Ȱ��ȭ/��Ȱ��ȭ ��ų ���

--emp fk���� (dept���̺��� deptno�÷� ����)
--FK_EMP_DEPT ��Ȱ��ȭ
ALTER TABLE emp DISABLE CONSTRAINT fk_emp_dept;

--���� ���ǿ� ����Ǵ� �����͸� �־��
INSERT INTO emp (empno, ename, deptno)
VALUES (9999,'brown',80);

--FK_EMP_DEPT Ȱ��ȭ
ALTER TABLE emp ENABLE CONSTRAINT fk_emp_dept;
--���� ���ǿ� ����Ǵ� �����Ͱ� �����Ͽ� ENABLE ��ų �� ����.
DELETE emp
WHERE deptno='80';
--FK_EMP_DEPT Ȱ��ȭ
ALTER TABLE emp ENABLE CONSTRAINT fk_emp_dept;

commit;

--���� ������ �����ϴ� ���̺� ��� view : USER_TABLES
--���� ������ �����ϴ� ���� ���� view : USER_CONSTRAINTS
--���� ������ �����ϴ� ���� ������ �÷� : USER_CONS_COLUMNS

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='CYCLE';

--FK_EMP_DEPT
SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'PK_CYCLE';

--���̺� ������ ���� ���� ��ȸ(VIEW ����)
--���̺�� / �������Ǹ� / �÷��� / �÷�������
SELECT a.table_name, a.constraint_name, b.column_name, b.position
FROM user_constraints a, user_cons_columns b
WHERE a.constraint_name = b.constraint_name
AND a.constraint_type = 'P'
ORDER BY a.table_name, b.position;

--emp ���̺�� 8���� �÷� �ּ��ޱ�

--���̺� �ּ� view : USER_TAB_COMMENTS;\

SELECT *
FROM user_tab_comments
WHERE table_name = 'EMP';

--emp ���̺� �ּ�
COMMENT ON TABLE emp IS '���';

--emp ���̺��� �÷� �ּ�
SELECT *
FROM user_col_comments;

--EMPNO ENAME JOB MGR HIREDATE SAL comm DEPTNO
COMMENT ON COLUMN emp.empno IS '�����ȣ';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.job IS '��� ����';
COMMENT ON COLUMN emp.mgr IS '������ ���';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '��';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

SELECT *
FROM emp;

--�ǽ� 1
SELECT a.TABLE_NAME TABLE_NAME, a.TABLE_TYPE TABLE_TYPE, a.COMMENTS TAB_COMMENT,
    b.COLUMN_NAME COLUMN_NAME, b.COMMENTS COL_COMMENT
FROM user_tab_comments a JOIN user_col_comments b ON (a.table_name = b.table_name)
WHERE a.table_name IN ('CUSTOMER','PRODUCT','CYCLE','DAILY');

--VIEW ����(emp���̺��� sal, comm �÷��� ����)
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--INLINE VIEW
SELECT *
FROM(
    SELECT empno, ename, job, mgr, hiredate, deptno
    FROM emp
);

--VIEW
SELECT *
FROM v_emp;

--���ε� ���� ����� view�� ���� : v_emp_dept
--emp, dept : �μ���, �����ȣ, �����, ������, �Ի�����
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT b.dname, a.empno, a.ename, a.job, a.hiredate
FROM emp a JOIN dept b ON(a.deptno = b.deptno);

SELECT *
FROM v_emp_dept;

--VIEW ����
DROP VIEW v_emp;

--VIEW�� �����ϴ� ���̺��� �����͸� �����ϸ� VIEW���� ������ ����.
--dept 30 - SALES
SELECT *
FROM dept;

--dept���̺��� SALES => MARKET SALES
UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno = 30;

rollback;

--HR �������� v_emp_dept view�� ��ȸ ���� �ο�
GRANT SELECT ON v_emp_dept TO hr;

--SEQUENCE ���� (�Խñ� ��ȣ �ο��� ������)
CREATE SEQUENCE seq_post
INCREMENT BY 1
START WITH 1;

SELECT seq_post.nextval, seq_post.currval
FROM dual;

SELECT seq_post.currval
FROM dual;

SELECT *
FROM post
WHERE reg_id = 'brown'
AND title = '����'
AND reg_dt = TO_DATE('2019/11/14 15:40:15','YYYY/MM/DD HH24:MI:SS');

SELECT *
FROM post
WHERE post_id = 1;

CREATE SEQUENCE seq_emp_test;

INSERT INTO emp_test VALUES (seq_emp_test.nextval,'brown');

SELECT *
FROM emp_test;

--index
--rowid : ���̺� ���� ������ �ּ�, �ش� �ּҸ� �˸�
--������ ���̺� �����ϴ� ���� �����ϴ�.
SELECT product.*, ROWID
FROM product;

--�����ȹ�� ���� �ε��� ��뿩�� Ȯ��
--emp ���̺� empno�÷��� �������� �ε����� ���� ��
ALTER TABLE emp DROP CONSTRAINT pk_emp;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

--�ε����� ���� ������ empno=7369�� �����͸� ã�� ����
--emp ���̺� ��ü�� ã�ƺ��� �Ѵ� => TABLE FULL SCAN

--���� ��ȹ ��ȸ
SELECT *
FROM TABLE(dbms_xplan.display);