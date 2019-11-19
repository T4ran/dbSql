--hr �������� �ۼ�

SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC07';

SELECT *
FROM pc07.v_emp_dept;

--sem �������� ��ȸ��ȯ�� ���� V_EMP_DEPT view�� hr �������� ��ȸ�ϱ� ���ؼ���
--������.view�̸� �������� ����ؾ� �Ѵ�.
--�̶� �Ź� �������� ����ϱ� ���ŷӱ� ������ synonym�� ����Ѵ�.

--����
CREATE SYNONYM V_EMP_DEPT FOR PC07.V_EMP_DEPT;

--����
CREATE SYNONYM V_EMP_DEPT;

--PC07.V_EMP_DEPT => V_EMP_DEPT
SELECT *
FROM V_EMP_DEPT;

ALTER USER PC07 IDENTIFIED BY java123;      --�ý��۰���(������)�� ���ΰ����� ��й�ȣ�� �ٲ� �� �ִ�.

--dictionary
--���ξ� : USER : ����� ���� ��ü
--        ALL : ����ڰ� ��밡���� ��ü
--        DBA : ������ ������ ��ü ��ü(�Ϲ� ����ڴ� ��� �Ұ�)
--        V$ : �ý��۰� ���õ� view(�Ϲ� ����ڴ� ��� �Ұ�)

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN ('PC07','HR');

/*
    ����Ŭ���� ������ SQL�̶�?
    ���ڰ� �ϳ��� Ʋ���� �ȵ�
    ���� sql���� ���� ����� ����� ���� ���� DBMS������
    ���� �ٸ� SQL�� �νĵȴ�.
*/

SELECT /*bind_test*/* FROM emp;
Select /*bind_test*/* FROM emp;
Select /*bind_test*/*  FROM emp WHERE empno=7369;
Select /*bind_test*/*  FROM emp WHERE empno=7499;
Select /*bind_test*/*  FROM emp WHERE empno=7521;

SELECT /*bind_test*/* FROM emp WHERE empno = :empno;

SELECT *
FROM V$SQL
WHERE SQL_TEXT LIKE '%bind_test%';