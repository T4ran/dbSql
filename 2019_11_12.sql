--
desc emp;

INSERT INTO emp(empno, ename, job)
VALUES (9999,'brown',null);

SELECT *
FROM emp
WHERE empno=9999;

rollback;

desc emp;

SELECT *
FROM user_tab_columns
WHERE table_name = 'EMP'
ORDER BY column_id;

INSERT INTO emp VALUES(9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);
commit;

SELECT *
FROM emp;
rollback;

DELETE emp
WHERE empno=9999;

INSERT INTO emp(empno, ename)
SELECT deptno, dname
FROM dept;

--UPDATE
--UPDATE 테이블 SET 컬럼=값, 컬럼=값...
--WHERE condition

SELECT *
FROM dept;

UPDATE dept SET dname='대덕IT', loc='ym'
WHERE deptno = 99;

SELECT *
FROM emp;

--사원번호가 9999인 직원을 emp 테이블에서 삭제
DELETE emp
WHERE empno = 9999;

--부서테이블을 이용해서 emp 테이블에 입력한 5건 데이터 삭제
DELETE emp
WHERE empno IN
(SELECT deptno
FROM dept);

rollback;

DELETE emp
WHERE empno < 100;

commit;

------TRUNCATE
----TRUNCATE TABLE dept;
--복구가 되지 않는 삭제 방법.
--로그를 남기지 않고 삭제한다.

--LV1 --> LV3
SET TRANSACTION isolation LEVEL SERIALIZABLE;
--LV1
SET TRANSACTION isolation LEVEL READ COMMITTED;

--table생성
--DDL : AUTO COMMIT, rollback이 안된다.
--CREATE
CREATE TABLE ranger_new(
    ranger_no NUMBER,   --숫자 타입
    ranger_name VARCHAR2(50),   --문자 : VARCHAR2, CHAR
    reg_dt DATE DEFAULT sysdate     --DEFAULT : SYSDATE
);

desc ranger_new;

--ddl rollback 시도
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000,'brown');

SELECT *
FROM ranger_new;
commit;

--table삭제
--DROP TABLE TABLE_NAME
DROP TABLE ranger_new;

--날짜 타입에서 특정 필드 가져오기
--ex : sysdate에서 년도만 가져오기
SELECT TO_CHAR(sysdate,'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, TO_CHAR(reg_dt,'MM'),
EXTRACT(MONTH FROM reg_dt) mm, EXTRACT(YEAR FROM reg_dt) year, EXTRACT(DAY FROM reg_dt) day
FROM ranger_new;

--제약조건
--DEPT 모방하여 DEPT_TEST 생성
desc dept;
CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY,   --deptno 컬럼을 식별자로 지정. 지정되었을 시 값이 중복이 될 수 없으며 또한 null일 수도 없다.
    dname varchar2(14),
    loc varchar2(13)
);

--PRIMARY KEY 제약 조건 확인
--1. deptno컬럼에 null이 들어갈 수 없다.
--2. deptno컬럼에 중복된 값이 들어갈 수 없다.

INSERT INTO dept_test (deptno, dname, loc)
VALUES(null,'ddit','daejeon');
/*명령의 121 행에서 시작하는 중 오류 발생 -
INSERT INTO dept_test (deptno, dname, loc)
VALUES(null,'ddit','daejeon')
오류 보고 -
ORA-01400: cannot insert NULL into ("PC07"."DEPT_TEST"."DEPTNO")*/

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(1,'ddit2','daejeon');
/*명령의 130 행에서 시작하는 중 오류 발생 -
INSERT INTO dept_test VALUES(1,'ddit2','daejeon')
오류 보고 -
ORA-00001: unique constraint (PC07.SYS_C007114) violated*/

rollback;

--사용자 지정 제약조건명을 부여한 PRIMARY KEY
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(1,'ddit2','daejeon');

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(2,null,'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1,'ddit','daejeon');
INSERT INTO dept_test VALUES(2,'ddit','daejeon');

rollback;