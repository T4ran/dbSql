--���̺��� ������ ��ȸ
/*
    SELECT �÷�, | express (���ڿ����) [as] ��Ī
    FROM �����͸� ��ȸ�� ���̺�(VIEW)
    WHERE ���� (condition)
*/
DESC user_tables;

SELECT *
FROM user_tables
WHERE TABLE_NAME != 'CART';

--���� �� ����
--�μ���ȣ�� 30�� ���� ũ�ų� ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;

--�μ���ȣ�� 30������ ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE deptno < 30;

--�Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');  //�Ʒ��� ���� TO_DATE�� ������ �ʾƵ� ������, ���������� �� �� �ֵ��� ���ִ°� ����.
//WHERE hiredate >= '1982/01/01';

--AND - WHERE ���� ������ �� �ٿ��� �� ����Ѵ�.

--col BETWEEN X AND Y ����
--�÷��� ���� X���� ũ�ų� ����, Y���� �۰ų� ���� ������
--�޿�(sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--���� BETWEEN AND �����ڴ� �Ʒ��� <=, >= ���հ� ����.
SELECT *
FROM emp
WHERE sal >= 1000 AND sal <= 2000 AND deptno = 30;

--���ǿ� �´� ������ ��ȸ�ϱ� �ǽ�1
--emp ���̺��� 1982�� 1�� 1�Ϻ��� 1983�� 1�� 1�ϱ����� �Ի����ڸ� �����ϴ� �����
--ename, hiredate������ ��ȸ(��, �����ڸ� BETWEEN���� ���)

SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD')
AND TO_DATE('1983/01/01','YYYY/MM/DD');

--�����ڸ� �񱳿�����(>=, >, <, <=)�� ���

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

--IN ������
--COL IN (Values)
--�μ���ȣ�� 10 Ȥ�� 20�� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 20;

SELECT *
FROM emp
WHERE deptno IN (10, 20);

--�ǽ� 3) userid�� brown, cony, sally�� �����͸� ��ȸ
--IN������ ���

SELECT userid AS "���̵�", usernm AS "�̸�", alias AS "����"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

--LIKE ������
--COL LIKE 'S%'
--COL�� ���� �빮�� S�� �����ϴ� ��� ��
--COL LIKE 'S____' <= 'S _ _ _ _'
--COL�� ���� �빮�� S�� �����ϰ� ���ڿ��� ������ 5���� ��

--emp ���̺��� �����̸��� S�� �����ϴ� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--�ǽ� 4) member ���̺��� ȸ���� ���� �ž��� ����� mem_id, mem_name�� ��ȸ
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--�ǽ� 5) member ���̺��� ȸ���� �̸��� �̰� �� ����� mem_id�� mem_name�� ��ȸ
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--NULL ��
--col IS NULL
--EMP ���̺��� MGR ������ ���� ���(NULL) ��ȸ

SELECT *
FROM emp
WHERE mgr IS NULL;
//WHERE mgr IS NOT NULL;

--�Ҽ� �μ��� 10���� �ƴ� ������
SELECT *
FROM emp
WHERE deptno != '10';

--�ǽ� 6) emp ���̺��� ��(comm)�� �ִ� ȸ���� ���� ��ȸ
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE mgr = 7698
AND sal >= 1000;

SELECT *
FROM emp
WHERE mgr = 7698
OR sal >= 1000;

--�� ���� NOT
--emp ���̺��� ������(mgr) ����� 7698�� �ƴϰ�, 7839�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr != 7698
AND mgr != 7839;
//WHERE mgr NOT IN (7698, 7839);

--IN, NOT IN �������� NULL ó��
--emp ���̺��� ������(mgr) ����� 7698, 7839 �Ǵ� null�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
AND mgr IS NOT NULL;
//WHERE mgr NOT IN (7698, 7839, NULL); <= �߸��� ����
//IN �����ڿ��� ������� NULL�� ���� ��� �ǵ����� �ʴ� ������ �Ѵ�.

--�ǽ� 7) emp ���̺��� job�� SALESMAN�̰� �Ի����ڰ� 1981��06��01�� ������ ������ ���� ��ȸ
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--�ǽ� 8) emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ���� ��ȸ
--IN, NOT IN ������ ���Ұ�
SELECT *
FROM emp
WHERE deptno != 10
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--�ǽ� 9) emp ���̺��� �μ� ��ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ���� ���� ��ȸ
--NOT IN ������ ���
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--�ǽ� 10) emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ���� ���� ��ȸ
--(�μ��� 10, 20, 30�� �ִٰ� �����ϰ� IN�����ڸ� ���)
SELECT *
FROM emp
WHERE deptno IN (20,30)
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--�ǽ� 11) emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ���� ���� ��ȸ
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--�ǽ� 12) emp���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';