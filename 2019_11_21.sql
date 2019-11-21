--��ü ������ �޿����
SELECT ROUND(AVG(sal),2)
FROM emp;

--�μ��� ������ �޿� ���
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;

SELECT a.empno, a.ename, a.deptno, b.avg_sal
FROM emp a JOIN (SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno) b ON (a.deptno = b.deptno);

SELECT a.empno, a.ename, c.job, a.deptno, a.sal, c.sal, a.avg_sal
FROM emp_test c JOIN (SELECT a.empno, a.ename, a.sal, a.deptno, b.avg_sal
FROM emp a JOIN (SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno) b ON (a.deptno = b.deptno)) a ON (c.empno = a.empno);



--�޷� �����
--STEP 1. �ش� ����� ���� �����
--CONNECT BY LEVEL
SELECT MAX(sun), MAX(mon), MAX(tue), MAX(wed), MAX(thu), MAX(fri), MAX(sat)
FROM
(SELECT a.*,
DECODE(d, 1, dt) sun, DECODE(d, 2, dt) mon,
DECODE(d, 3, dt) tue, DECODE(d, 4, dt) wed,
DECODE(d, 5, dt) thu, DECODE(d, 6, dt) fri,
DECODE(d, 7, dt) sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level), 'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD')) a)
GROUP BY iw
ORDER BY iw;

--�ǽ� 2
SELECT iw, MAX(sun), MAX(mon), MAX(tue), MAX(wed), MAX(thu), MAX(fri), MAX(sat)
FROM
(SELECT a.*,
DECODE(d, 1, dt) sun, DECODE(d, 2, dt) mon,
DECODE(d, 3, dt) tue, DECODE(d, 4, dt) wed,
DECODE(d, 5, dt) thu, DECODE(d, 6, dt) fri,
DECODE(d, 7, dt) sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level), 'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD')) a)
GROUP BY iw
ORDER BY iw;

--iw�� ����Ʈ
SELECT a.iw
FROM
(SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level), 'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD')) a
GROUP BY a.iw
ORDER BY a.iw;

--��� ��¥ ���̺�
SELECT TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR') + (level-1)
FROM dual
CONNECT BY LEVEL <=
TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/12/31','YYYY/MM/DD')-TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/01/01','YYYY/MM/DD')+1;

SELECT TO_DATE('19/12/31','YY/MM/DD') - TO_DATE('19/01/01','YY/MM/DD')+1
FROM dual;--1���� �������� ���ϴ� ����(19�����)

SELECT TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/12/31','YYYY/MM/DD')-TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/01/01','YYYY/MM/DD')+1
FROM dual;

--��� ��¥ ���̺��� iw�� d�� ���� ����
SELECT a.dt,
TO_CHAR(a.dt+1, 'iw') iw,
TO_CHAR(a.dt, 'd') d
FROM
(SELECT TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR') + (level-1) dt
FROM dual
CONNECT BY LEVEL <=
TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/12/31','YYYY/MM/DD')-TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/01/01','YYYY/MM/DD')+1) a;

--����
SELECT MAX(sun) sun, MAX(mon) mon, MAX(tue) tue, MAX(wed) wed, MAX(thu) thu, MAX(fri) fri, MAX(sat) sat
FROM
(
    SELECT c.*,
    DECODE(d, 1, dt) sun, DECODE(d, 2, dt) mon,
    DECODE(d, 3, dt) tue, DECODE(d, 4, dt) wed,
    DECODE(d, 5, dt) thu, DECODE(d, 6, dt) fri,
    DECODE(d, 7, dt) sat
    FROM 
    (
        SELECT a.dt,
        ROUND((TO_CHAR(a.dt,'DDD')-TO_CHAR(a.dt,'d'))/7 + 1) iw,--(a.dt-TO_CHAR(a.dt,'d'))/7 + 1 --TO_CHAR(a.dt+1, 'iw')
        TO_CHAR(a.dt, 'd') d
        FROM
            (SELECT TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR') + (level-1) dt
            FROM dual
            CONNECT BY LEVEL <=
            TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/12/31','YYYY/MM/DD')-TO_DATE(TO_CHAR(TRUNC(TO_DATE(:YYYYMM,'YYYYMM'),'YEAR'),'YYYY')||'/01/01','YYYY/MM/DD')+1) a
    ) c
    WHERE iw IN (
        SELECT a.iw
        FROM
        (
            SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
                   TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level), 'iw') iw,
                   TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
            FROM dual
            CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD')
        ) a
        GROUP BY a.iw)
)
GROUP BY iw
ORDER BY iw;--TODO

--���� ���� ������

SELECT *
FROM sales;

SELECT TRUNC(dt, 'MONTH'), SUM(sales.sales)
FROM sales
GROUP BY TRUNC(dt, 'MONTH')
ORDER BY TRUNC(dt, 'MONTH');

SELECT
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 01, a.sum) jan,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 02, a.sum) feb,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 03, a.sum) mar,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 04, a.sum) apr,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 05, a.sum) may,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 06, a.sum) jun,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 07, a.sum) jul,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 08, a.sum) agu,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 09, a.sum) sep,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 10, a.sum) oct,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 11, a.sum) nov,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 12, a.sum) dec
FROM
(SELECT TRUNC(dt, 'MONTH') dt, SUM(sales.sales) sum
FROM sales
GROUP BY TRUNC(dt, 'MONTH')
ORDER BY TRUNC(dt, 'MONTH'))a;

--���� ���� ����
SELECT NVL(MAX(jan),0) jan, NVL(MAX(feb),0) feb, NVL(MAX(mar),0) mar, NVL(MAX(apr),0) apr, NVL(MAX(may),0) may, NVL(MAX(jun),0) jun--, MAX(jul) jul,
--MAX(agu) agu, MAX(sep) sep, MAX(oct) oct, MAX(nov) nov, MAX(dec) dec
FROM
(SELECT
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 01, a.sum) jan,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 02, a.sum) feb,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 03, a.sum) mar,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 04, a.sum) apr,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 05, a.sum) may,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 06, a.sum) jun,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 07, a.sum) jul,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 08, a.sum) agu,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 09, a.sum) sep,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 10, a.sum) oct,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 11, a.sum) nov,
DECODE(TO_CHAR(TRUNC(a.dt,'MONTH'),'MM'), 12, a.sum) dec
FROM
(SELECT TRUNC(dt, 'MONTH') dt, SUM(sales.sales) sum
FROM sales
GROUP BY TRUNC(dt, 'MONTH')
ORDER BY TRUNC(dt, 'MONTH'))a);

-------------------------------------------------------------------------------�޷�, ���� ���� ��

--��������
--START WITH : ������ ���� �κ��� ����
--CONNECT BY : ������ ���� ������ ����

SELECT dept_h.*, level, LPAD(' ',(level-1)*4,' ')||dept_h.deptnm
FROM dept_h
START WITH deptcd = 'dept0' --START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd; --PRIOR ���� ���� ������

--�ǽ� 2
SELECT level lv, deptcd, LPAD(' ',(level-1)*4,' ')||dept_h.deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

