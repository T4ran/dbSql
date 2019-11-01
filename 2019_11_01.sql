--복습
--WHERE
--연산자
--비교 : =, !=, <>(같지 않다), >=, >, <=, <
--BETWEEN start AND end
--IN (set)
--LIKE 'S%' (% : 다수의 문자열과 매칭, _ : 한글자 매칭)
--IS NULL(값이 NULL일 경우 IS로 비교한다.)
--AND, OR, NOT

--emp 테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일 사이에 있는 직원 정보 조회
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

--emp 테이블에서 관리자(mgr)이 있는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno = 78
OR empno >= 780 AND empno <= 789        --AND가 OR보다 먼저 연산된다.
OR empno >= 7800 AND empno <= 7899;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%'
AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--order by 컬럼명 | 별칭 | 컬럼인덱스
--order by는 WHERE다음에 써준다.
--emp 테이블을 ename 기준으로 오름차순 정렬

SELECT *
FROM emp
ORDER BY ename;
--ORDER BY ename ASC;

--ASC는 default값이므로 생략하면 오름차순으로 정렬된다.

SELECT *
FROM emp
ORDER BY ename DESC;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을 경우
--사번(empno)으로 오름차순 정렬

SELECT *
FROM emp
ORDER BY job DESC, empno;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY 2;

--실습 1
--dept 테이블 모든 정보 부서이름 오름차순 정렬 조회
SELECT deptno, dname, loc
FROM dept
ORDER BY dname;
--dept 테이블 모든 정보 부서위치 내림차순 정렬 조회
SELECT deptno, dname, loc
FROM dept
ORDER BY loc DESC;

--실습 2
--emp 테이블에서 상여(comm) 보유자 정보 조회
--상여 내림차순으로 조회하되 상여가 같을경우 사번 오름차순으로 정렬

SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno;

--실습 3
--emp 테이블에서 관리자 보유자 정보 조회
--직업 오름차순 같은경우 사번 내림차순

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

--실습 4
--emp 테이블에서 부서 번호 10번 혹은 30번인 사람 정보 조회
--급여가 1500보다 크며 이름으로 내림차순하여 조회

SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30)
AND sal > 1500
ORDER BY ename DESC;


SELECT rownum
FROM emp;

--emp 테이블에서 사번(empno), 이름(ename)을 급여 기준으로 오름차순 정렬
--정렬된 결과순으로 ROWNUM을 출력

SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;

--ROWNUM 정렬 실습 1
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE rownum <= 10;

--ROWNUM 정렬 실습 2
SELECT a.*
FROM
(SELECT rownum rn, empno, ename
FROM emp) a
WHERE rn > 10
AND rn <= 20;

SELECT *
FROM emp;

--FUNCTION
--DUAL 테이블 조회
SELECT 'ABCDEFG' AS msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--문자열 대소문자 관련 함수
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('heLLo, wOrlD')
FROM dual;

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--좌변(TABLE의 컬럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못한다.

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열
--LENGTH : 문자열의 길이
--INSTR  : 문자열에 특정 문자열이 등장하는 첫번째 인덱스    세번째 파라미터는 문자열 인덱스 이후부터 찾는다는 의미
--LPAD   : 문자열의 왼쪽에 특정 문자열을 삽입, 두번째 파라미터의 숫자보다 작으면 세번째 파라미터의 문자로 채운다.
--RPAD   : 문자열의 오른쪽에 특정 문자열을 삽입, 두번째 파라미터의 숫자보다 작으면 세번째 파라미터의 문자로 채운다.
SELECT CONCAT('HELLO',CONCAT(',',' WORLD')) CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) SUBSTR1,
       SUBSTR('HELLO, WORLD', 1, 5) SUBSTR2,
       LENGTH('HELLO, WORLD') LENGTH,
       INSTR('HELLO, WORLD', 'O') INSTR,
       INSTR('HELLO, WORLD', 'O', 6) INSTR,
       LPAD('HELLO, WORLD', 15, '*') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD
FROM dual;
