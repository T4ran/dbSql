--����
--WHERE
--������
--�� : =, !=, <>(���� �ʴ�), >=, >, <=, <
--BETWEEN start AND end
--IN (set)
--LIKE 'S%' (% : �ټ��� ���ڿ��� ��Ī, _ : �ѱ��� ��Ī)
--IS NULL(���� NULL�� ��� IS�� ���Ѵ�.)
--AND, OR, NOT

--emp ���̺��� �Ի����ڰ� 1981�� 6�� 1�Ϻ��� 1986�� 12�� 31�� ���̿� �ִ� ���� ���� ��ȸ
--BETWEEN AND
SELECT *
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('1981/06/01','YYYY/MM/DD')
AND TO_DATE('1986/12/31','YYYY/MM/DD');
-- >=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD')
AND hiredate <= TO_DATE('1986/12/31','YYYY/MM/DD');

--emp ���̺��� ������(mgr)�� �ִ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno = 78
OR empno >= 780 AND empno <= 789        --AND�� OR���� ���� ����ȴ�.
OR empno >= 7800 AND empno <= 7899;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%'
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--order by �÷��� | ��Ī | �÷��ε���
--order by�� WHERE������ ���ش�.
--emp ���̺��� ename �������� �������� ����

SELECT *
FROM emp
ORDER BY ename;
--ORDER BY ename ASC;

--ASC�� default���̹Ƿ� �����ϸ� ������������ ���ĵȴ�.

SELECT *
FROM emp
ORDER BY ename DESC;

--job�� �������� ������������ ����, ���� job�� ���� ���
--���(empno)���� �������� ����

SELECT *
FROM emp
ORDER BY job DESC, empno;

--��Ī���� �����ϱ�
--��� ��ȣ(empno), �����(ename), ����(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY 2;

--�ǽ� 1
--dept ���̺� ��� ���� �μ��̸� �������� ���� ��ȸ
SELECT deptno, dname, loc
FROM dept
ORDER BY dname;
--dept ���̺� ��� ���� �μ���ġ �������� ���� ��ȸ
SELECT deptno, dname, loc
FROM dept
ORDER BY loc DESC;

--�ǽ� 2
--emp ���̺��� ��(comm) ������ ���� ��ȸ
--�� ������������ ��ȸ�ϵ� �󿩰� ������� ��� ������������ ����

SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno;

--�ǽ� 3
--emp ���̺��� ������ ������ ���� ��ȸ
--���� �������� ������� ��� ��������

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

--�ǽ� 4
--emp ���̺��� �μ� ��ȣ 10�� Ȥ�� 30���� ��� ���� ��ȸ
--�޿��� 1500���� ũ�� �̸����� ���������Ͽ� ��ȸ

SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30)
AND sal > 1500
ORDER BY ename DESC;


SELECT rownum
FROM emp;

--emp ���̺��� ���(empno), �̸�(ename)�� �޿� �������� �������� ����
--���ĵ� ��������� ROWNUM�� ���

SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;

--ROWNUM ���� �ǽ� 1
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE rownum <= 10;

--ROWNUM ���� �ǽ� 2
SELECT a.*
FROM
(SELECT rownum rn, empno, ename
FROM emp) a
WHERE rn > 10
AND rn <= 20;

SELECT *
FROM emp;

--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'ABCDEFG' AS msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--���ڿ� ��ҹ��� ���� �Լ�
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('heLLo, wOrlD')
FROM dual;

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--�º�(TABLE�� �÷�)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ���Ѵ�.

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ�
--LENGTH : ���ڿ��� ����
--INSTR  : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù��° �ε���    ����° �Ķ���ʹ� ���ڿ� �ε��� ���ĺ��� ã�´ٴ� �ǹ�
--LPAD   : ���ڿ��� ���ʿ� Ư�� ���ڿ��� ����, �ι�° �Ķ������ ���ں��� ������ ����° �Ķ������ ���ڷ� ä���.
--RPAD   : ���ڿ��� �����ʿ� Ư�� ���ڿ��� ����, �ι�° �Ķ������ ���ں��� ������ ����° �Ķ������ ���ڷ� ä���.
SELECT CONCAT('HELLO',CONCAT(',',' WORLD')) CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) SUBSTR1,
       SUBSTR('HELLO, WORLD', 1, 5) SUBSTR2,
       LENGTH('HELLO, WORLD') LENGTH,
       INSTR('HELLO, WORLD', 'O') INSTR,
       INSTR('HELLO, WORLD', 'O', 6) INSTR,
       LPAD('HELLO, WORLD', 15, '*') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD
FROM dual;
