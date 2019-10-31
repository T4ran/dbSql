--테이블에서 데이터 조회
/*
    SELECT 컬럼, | express (문자열상수) [as] 별칭
    FROM 데이터를 조회할 테이블(VIEW)
    WHERE 조건 (condition)
*/
DESC user_tables;

SELECT *
FROM user_tables
WHERE TABLE_NAME != 'CART';

--숫자 비교 연산
--부서번호가 30번 보다 크거나 같은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno >= 30;

--부서번호가 30번보다 작은 부서에 속한 직원 조회
SELECT *
FROM EMP
WHERE deptno < 30;

--입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');  //아래와 같이 TO_DATE를 써주지 않아도 좋지만, 범용적으로 쓸 수 있도록 써주는게 좋다.
//WHERE hiredate >= '1982/01/01';

--AND - WHERE 이후 조건을 더 붙여줄 때 사용한다.

--col BETWEEN X AND Y 연산
--컬럼의 값이 X보다 크거나 같고, Y보다 작거나 같은 데이터
--급여(sal)가 1000보다 크거나 같고, 2000보다 작거나 같은 데이터

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다.
SELECT *
FROM emp
WHERE sal >= 1000 AND sal <= 2000 AND deptno = 30;

--조건에 맞는 데이터 조회하기 실습1
--emp 테이블에서 1982년 1월 1일부터 1983년 1월 1일까지의 입사일자를 만족하는 사람의
--ename, hiredate데이터 조회(단, 연산자를 BETWEEN으로 사용)

SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD')
AND TO_DATE('1983/01/01','YYYY/MM/DD');

--연산자를 비교연산자(>=, >, <, <=)로 사용

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');




