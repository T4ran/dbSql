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

--IN 연산자
--COL IN (Values)
--부서번호가 10 혹은 20인 직원 조회
SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 20;

SELECT *
FROM emp
WHERE deptno IN (10, 20);

--실습 3) userid가 brown, cony, sally인 데이터를 조회
--IN연산자 사용

SELECT userid AS "아이디", usernm AS "이름", alias AS "별명"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

--LIKE 연산자
--COL LIKE 'S%'
--COL의 값이 대문자 S로 시작하는 모든 값
--COL LIKE 'S____' <= 'S _ _ _ _'
--COL의 값이 대문자 S로 시작하고 문자열의 개수가 5개인 값

--emp 테이블에서 직원이름이 S로 시작하는 모든 직원 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--실습 4) member 테이블에서 회원의 성이 신씨인 사람의 mem_id, mem_name을 조회
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--실습 5) member 테이블에서 회원의 이름에 이가 들어간 사람의 mem_id와 mem_name을 조회
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--NULL 비교
--col IS NULL
--EMP 테이블에서 MGR 정보가 없는 사람(NULL) 조회

SELECT *
FROM emp
WHERE mgr IS NULL;
//WHERE mgr IS NOT NULL;

--소속 부서가 10번이 아닌 직원들
SELECT *
FROM emp
WHERE deptno != '10';

--실습 6) emp 테이블에서 상여(comm)가 있는 회원의 정보 조회
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

--논리 연산 NOT
--emp 테이블에서 관리자(mgr) 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr != 7698
AND mgr != 7839;
//WHERE mgr NOT IN (7698, 7839);

--IN, NOT IN 연산자의 NULL 처리
--emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
AND mgr IS NOT NULL;
//WHERE mgr NOT IN (7698, 7839, NULL); <= 잘못된 예시
//IN 연산자에서 결과값에 NULL이 있을 경우 의도하지 않는 동작을 한다.

--실습 7) emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년06월01일 이후인 직원의 정보 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--실습 8) emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회
--IN, NOT IN 연산자 사용불가
SELECT *
FROM emp
WHERE deptno != 10
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--실습 9) emp 테이블에서 부서 번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원 정보 조회
--NOT IN 연산자 사용
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--실습 10) emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원 정보 조회
--(부서는 10, 20, 30만 있다고 가정하고 IN연산자를 사용)
SELECT *
FROM emp
WHERE deptno IN (20,30)
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--실습 11) emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원 정보 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--실습 12) emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';