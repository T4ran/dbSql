--hr 계정에서 작성

SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC07';

SELECT *
FROM pc07.v_emp_dept;

--sem 계정에서 조회권환을 받은 V_EMP_DEPT view를 hr 계정에서 조회하기 위해서는
--계정명.view이름 형식으로 기술해야 한다.
--이때 매번 계정명을 기술하기 번거롭기 때문에 synonym을 사용한다.

--생성
CREATE SYNONYM V_EMP_DEPT FOR PC07.V_EMP_DEPT;

--삭제
CREATE SYNONYM V_EMP_DEPT;

--PC07.V_EMP_DEPT => V_EMP_DEPT
SELECT *
FROM V_EMP_DEPT;

ALTER USER PC07 IDENTIFIED BY java123;      --시스템계정(관리자)와 본인계정만 비밀번호를 바꿀 수 있다.

--dictionary
--접두어 : USER : 사용자 소유 객체
--        ALL : 사용자가 사용가능한 객체
--        DBA : 관리자 관점의 전체 객체(일반 사용자는 사용 불가)
--        V$ : 시스템과 관련된 view(일반 사용자는 사용 불가)

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN ('PC07','HR');

/*
    오라클에서 동일한 SQL이란?
    문자가 하나라도 틀리면 안됨
    다음 sql들은 같은 결과를 만들어 낼지 몰라도 DBMS에서는
    서로 다른 SQL로 인식된다.
*/

SELECT /*bind_test*/* FROM emp;
Select /*bind_test*/* FROM emp;
Select /*bind_test*/*  FROM emp WHERE empno=7369;
Select /*bind_test*/*  FROM emp WHERE empno=7499;
Select /*bind_test*/*  FROM emp WHERE empno=7521;

SELECT /*bind_test*/* FROM emp WHERE empno = :empno;

SELECT *
FROM V$SQL
WHERE SQL_TEXT LIKE '%bind_test%';