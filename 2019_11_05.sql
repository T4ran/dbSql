--UPDATE TABLE_NAME SET COLLUM_NAME = DATA
--WHERE COLLUM_NAME = DATA;
--COMMIT;

--년월 파라미터가 주어졌을 때 해당 년월의 일수를 구하는 문제
--201911 => 30 // 201912 => 31

SELECT :yyyymm param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD') dt
FROM DUAL;

explain plan for
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT empno, ename, sal, TO_CHAR(sal, 'L000999,999.99') sal_fmt
FROM emp;

--function null
--nvl
SELECT empno, ename, comm, nvl(comm, 0) nvl_Comm, sal + comm, sal + nvl(comm, 0)
FROM emp;

--NVL2(coll, coll이 null일 경우 표현되는 값, coll null이 아닐경우 표현되는 값)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 같으면 null
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2...)
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, mgr,NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n, coalesce(mgr, 9999) mgr_n
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
FROM users;

--case when
SELECT empno, ename, job, sal,
       case
            when job = 'SALESMAN' then sal*1.05
            when job = 'MANAGER' then sal*1.10
            when job = 'PRESIDENT' then sal*1.20
            else sal
       end case_sal
FROM emp;

SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal*1.05, 'MANAGER', sal*1.10, 'PRESIDENT', sal*1.20, sal) decode_sal
FROM emp;

--emp 테이블을 이용하여 deptno에 따라 부서명으로 변경하여 조회하라
/*
10->ACCOUNTING
20->RESEARCH
30->SALES
40->OPERATIONS
그 외 -> DDIT
*/
SELECT empno, ename, 

CASE
    WHEN deptno=10 then 'ACCOUNTING'
    WHEN deptno=20 then 'RESEARCH'
    WHEN deptno=30 then 'SALES'
    WHEN deptno=40 then 'OPERATIONS'
    else 'DDIT'
END DNAME,

DECODE(deptno, 
    10, 'ACCOUNTING', 
    20, 'RESEARCH', 
    30, 'SALES', 
    40, 'OPERATIONS', 
        'DDIT') DNAME
FROM emp;

SELECT empno, ename, TO_CHAR(hiredate, 'YYYY/MM/DD') hiredate,
CASE
    --WHEN MOD(TO_CHAR(hiredate, 'YYYY'),2) = MOD(TO_CHAR(SYSDATE, 'YYYY'),2)   --실행됨
    --WHEN MOD(TO_CHAR(TO_DATE(SYSDATE-hiredate),'YYYY'),2) = 0                 --에러
    WHEN MOD(TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(hiredate,'YYYY'),2) = 0
    THEN '건강검진 대상자'
    else '건강검진 비대상자'
END contact_to_doctor
FROM emp;

SELECT
CASE
    WHEN MOD(TO_CHAR(SYSDATE,'YYYY'),2)=0 THEN '짝수'
    else '홀수'
END this_year
FROM dual;

SELECT empno, ename, hiredate,
CASE
    WHEN MOD(TO_CHAR(hiredate,'YYYY'),2)=0 THEN '짝수'
    else '홀수'
END this_year
FROM emp;

SELECT userid, usernm, alias, reg_dt,
CASE
    WHEN MOD(TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(reg_dt,'YYYY'),2) = 0
    THEN '건강검진 대상자'
    else '건강검진 비대상자'
END contact_to_doctor
FROM users;

--그룹함수(AVG, MAX, MIN, SUM, COUNT)
--그룹함수는 NULL값을 계산대상에서 제외한다.
--SUM(comm), COUNT(*), COUNT(mgr)

--직원중 가장 높은 급여를 받는 사람
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal), COUNT(sal)
FROM emp;

--부서별 가장 높은 급여
--GROUP BY 절에 기술되지 않은 컬럼이 SELECT절에 기술될 경우 에러
SELECT
DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 'DDIT') DNAME,
MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, SUM(sal) sum_sal,
COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno
ORDER BY max_sal DESC;


