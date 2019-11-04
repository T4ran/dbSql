SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('1981.06.01','YYYY.MM.DD');

--ROWNUM
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

SELECT ROWNUM, a.*
FROM
(SELECT e.*
FROM emp e
ORDER BY ename) a;

SELECT a.*
FROM
(SELECT ROWNUM rn, e.*
FROM emp e
ORDER BY ROWNUM) a
WHERE rn BETWEEN 10 AND 14;

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ�
--LENGTH : ���ڿ��� ����
--INSTR  : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù��° �ε���    ����° �Ķ���ʹ� ���ڿ� �ε��� ���ĺ��� ã�´ٴ� �ǹ�
--LPAD   : ���ڿ��� ���ʿ� Ư�� ���ڿ��� ����, �ι�° �Ķ������ ���ں��� ������ ����° �Ķ������ ���ڷ� ä���.
--RPAD   : ���ڿ��� �����ʿ� Ư�� ���ڿ��� ����, �ι�° �Ķ������ ���ں��� ������ ����° �Ķ������ ���ڷ� ä���.
--        ����° �Ķ���Ͱ� ������ ���鹮�ڰ� ���Եȴ�.
SELECT CONCAT('HELLO',CONCAT(',',' WORLD')) CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5)
       SUBSTR1,
       SUBSTR('HELLO, WORLD', 1, 5) SUBSTR2,
       LENGTH('HELLO, WORLD') LENGTH,
       INSTR('HELLO, WORLD', 'O') INSTR,
       INSTR('HELLO, WORLD', 'O', 6) INSTR,
       LPAD('HELLO, WORLD', 15, '*') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD,
       --REPLACE(�������ڿ�, �������ڿ����� �����ϰ����ϴ� ��� ���ڿ�, ���湮�ڿ�)
       REPLACE(REPLACE('HELLO, WORLD','HELLO','hello'), 'WORLD', 'world')
FROM dual;

--ROUND(������, �ݿø� ��� �ڸ���)
SELECT ROUND(105.54, 1) r1,
       ROUND(105.55, 1) r2,
       ROUND(105.55, 0) r3,
       ROUND(105.55, -1) r4
FROM dual;

SELECT empno, ename, sal, (sal - MOD(sal,1000))/1000 qutient, MOD(sal, 1000) reminder
FROM emp;

--TRUNC
SELECT TRUNC(105.54, 1) t1,
       TRUNC(105.55, 1) t2,
       TRUNC(105.55, 0) t3,
       TRUNC(105.55, -1) t4
FROM dual;

--SYSDATE : ����Ŭ�� ��ġ�� ������ ���� ��¥ + �ð������� ����
--������ ���ڰ� ���� �Լ�

--TO_CHAR : DATE Ÿ���� ���ڿ��� ��ȯ
--��¥�� ���ڿ��� ��ȯ�ÿ� ������ ����
SELECT TO_CHAR(SYSDATE + 1*1/24/60/60,'RRRR/MM/DD HH24/MI/SS'), TO_CHAR(SYSDATE + 2*1/24/60/60,'RRRR/MM/DD HH24/MI/SS')
FROM dual;

--date �ǽ� 1
--2019/12/31�� date�������� ǥ��
SELECT TO_CHAR(TO_DATE('2019/12/31', 'RRRR/MM/DD'), 'RRRR/MM/DD') LASTDAY,
--5�� ������¥
    TO_CHAR(TO_DATE('2019/12/31', 'RRRR/MM/DD')-5, 'RRRR/MM/DD') LASTDAY_BEFORE5,
--���糯¥
    TO_CHAR(SYSDATE, 'RRRR/MM/DD') NOW,
--���糯¥���� 3����
    TO_CHAR(SYSDATE-3, 'RRRR/MM/DD') NOW_BEFORE3
FROM dual;

--date format
--�⵵ : YYYY, YY, RRRR, RR
--YYYY = RRRR
--YY != RR  50�⵵���� Ŭ��� ����� �ٸ���
--D : ������ ���ڷ� ǥ��
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'),'YYYY/MM/DD') R1,
       TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'),'YYYY/MM/DD') R2,
       TO_CHAR(TO_DATE('35/03/01', 'YY/MM/DD'),'YYYY/MM/DD') Y1,
       TO_CHAR(TO_DATE('55/03/01', 'YY/MM/DD'),'YYYY/MM/DD') Y2,
       TO_CHAR(SYSDATE, 'D') d,
       TO_CHAR(SYSDATE, 'IW') iw,
       TO_CHAR(TO_DATE('20191229', 'YYYYMMDD'), 'IW') THIS_YEAR
FROM DUAL;

SELECT
    TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME,
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--��¥�� �ݿø�(ROUND), ����(TRUNC)
--ROUND(DATE, '����') YYYY,MM,DD
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       TO_CHAR(ROUND(hiredate + 0.6, 'DD'), 'YYYY/MM/DD HH24:MI:SS') round_yyyy
FROM emp
WHERE ename = 'SMITH';

--TRUNC ����

--��¥ ���� �Լ�
--MONTHS_BETWEEN(DATE, DATE) : �� ��¥ ������ ���� ��
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
       MONTHS_BETWEEN(TO_DATE('20191117','YYYYMMDD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTHS(DATE, ������) : DATE�� �������� ���� ��¥
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
    ADD_MONTHS(hiredate,467) add_months
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, ����) : DATE ���� ù��° ������ ��¥
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') next_sat
FROM dual;

--LAST_DAY(DATE) : ����� ������ ���� ��ȯ
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

SELECT TO_DATE('20191104', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') test,
TO_DATE('20191201', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') test2
FROM dual;

--201908 �� �ϼ�
SELECT ADD_MONTHS(TO_DATE('201908', 'YYYYMM'),1) - TO_DATE('201908', 'YYYYMM') DT
FROM dual;