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




