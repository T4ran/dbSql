SELECT *
FROM tax;

SELECT SIDO, SIGUNGU, ROUND(sal/people, 2) point
FROM tax
ORDER BY point desc;

--연말정산 납입액
CREATE TABLE TAX_ORDER_BY_SAL AS
SELECT SIDO, SIGUNGU, sal, ROUND(sal/people, 2) point
FROM tax
ORDER BY sal desc;

--버거지수
CREATE TABLE FASTFOOD_POINT AS
SELECT main.SIDO, main.SIGUNGU, round(main.cnt/sub.cnt, 2) point
FROM (SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('버거킹','맥도날드','KFC')
GROUP BY SIDO, SIGUNGU) main FULL OUTER JOIN
(SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY SIDO, SIGUNGU) sub
ON (main.SIDO||main.SIGUNGU = sub.SIDO||sub.SIGUNGU)
WHERE round(main.cnt/sub.cnt, 2) IS NOT NULL
ORDER BY point desc;

--시도, 시군구, 버거지수, 연말정산 납입액
SELECT *
FROM fastfood_point;

SELECT *
FROM TAX_ORDER_BY_SAL;

SELECT a.SIDO, a.SIGUNGU, a.point FASTFOOD_POINT, b.SIDO, b.SIGUNGU, b.point TAX_POINT
FROM fastfood_point a LEFT OUTER JOIN TAX_ORDER_BY_SAL b ON (a.SIDO||a.SIGUNGU = b.SIDO||b.SIGUNGU)
ORDER BY a.point desc;

SELECT a.SIDO, a.SIGUNGU, a.POINT, b.SIDO, b.SIGUNGU, b.point
FROM
(SELECT main.SIDO, main.SIGUNGU, round(main.cnt/sub.cnt, 2) point
FROM (SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('버거킹','맥도날드','KFC')
GROUP BY SIDO, SIGUNGU) main FULL OUTER JOIN
(SELECT SIDO, SIGUNGU, COUNT(SIGUNGU) cnt
FROM fastfood
WHERE gb IN ('롯데리아')
GROUP BY SIDO, SIGUNGU) sub
ON (main.SIDO||main.SIGUNGU = sub.SIDO||sub.SIGUNGU)
ORDER BY main.SIDO, main.SIGUNGU) a,
(SELECT SIDO, SIGUNGU, sal, ROUND(sal/people, 2) point
FROM tax
ORDER BY sal desc) b
WHERE a.SIDO||a.SIGUNGU = b.SIDO||b.SIGUNGU;

--emp_test 제거
drop table emp_test;

--multiple insert를 위한 테스트 테이블 생성
--empno, ename 두개의 컬럼을 갖는 emp_test, emp_test2 테이블을
--emp 테이블로부터 생성한다. (CTAS)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp
WHERE 1=2;

--INSERT ALL
--하나의 INSERT SQL 문장으로 여러 테이블에 데이터를 입력
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 1, 'brown' FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;

SELECT *
FROM emp_test;

--INSERT ALL 컬럼 정의
rollback;

INSERT ALL
    INTO emp_test (empno) VALUES (empno)
    INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

--multiple insert(conditional insert)
rollback;
INSERT ALL
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


--INSERT FIRST
rollback;
INSERT FIRST
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno < 5 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 3 empno, 'brown' ename FROM dual UNION ALL
SELECT 6 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--MERGE : 조건에 만족하는 데이터가 있으면 UPDATE
--        조건에 만족하는 데이터가 없으면 INSERT

--empno가 7369인 데이터를 emp 테이블로부터 복사(INSERT)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno=7369;

SELECT *
FROM emp_test;

--emp테이블의 데이터중 emp_test 테이블의 empno와 같은 값을 갖는 데이터가 있을경우
--emp_test.ename = ename || '_merge'값으로 update
--데이터가 없을 경우 emp_test테이블에 insert
ALTER TABLE emp_test MODIFY (ename VARCHAR(20));

MERGE INTO emp_test
USING emp ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
UPDATE SET emp_test.ename = emp.ename || '_merge'
WHEN NOT MATCHED THEN
INSERT VALUES (emp.empno, emp.ename);

--다른 테이블을 통하지 않고 테이블 자체의 데이터 존재 유무로 merge 하는 경우

--empno=1, ename='brown'
--empno가 같은 값이 있으면 ename을 'brown'으로 update
--empno가 같은 값이 없으면 신규 insert

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 1)
WHEN MATCHED THEN
    UPDATE SET ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN
    INSERT VALUES (1, 'brown');
    
SELECT *
FROM emp_test;

SELECT 'X'
FROM emp_test
WHERE empno=1;

UPDATE emp_teset set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');

--실습 1
SELECT *
FROM emp;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null, SUM(sal)
FROM emp;

--rollup
--group by의 서브 그룹을 생성
--GROUP BY ROLLUP({col,})
--컬럼을 오른쪽부터 제거해가면서 나온 서브그룹을
--GROUP BY 하여 UNION한 것과 동일
--ex : GROUP BY ROLLUP (job, deptno)
--     GROUP BY job, deptno
--     UNION
--     GROUP BY job
--     UNION
--     GROUP BY --> 총계(모든 행에 대해 그룹함수 적용)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--위에서 만든 쿼리를 롤업하여 작성
SELECT deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

--GROUPING SETS (col1, col2...)
--GROUPING SETS의 나열된 항목이 하나의 서브그룹으로 GROUP BY 절에 이용된다.
--GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp 테이블을 이용하여 부서별 급여합과 담당업무(job)별 급여합을 구하시오.
--부서번호, job, 급여합계
SELECT deptno,null job ,sum(sal)
FROM emp
GROUP BY deptno
UNION
SELECT null, job, sum(sal)
FROM emp
GROUP BY job;

SELECT deptno, job, sum(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job));