-- SELECT : 조회할 컬럼 명시
--         - 전체 컬럼 조회 : *
--         - 일부 컬럼 : 해당 컬럼명 나열 (,구분)
-- FROM : 조회할 테이블 명시
-- 쿼리를 여러줄에 나누어서 작성해도 상관 없다.
-- 단 keyword는 붙여서 작성

-- 모든 컬럼 조회
SELECT * FROM prod;

-- 특정 컬럼만 조회
SELECT prod_id, prod_name
FROM prod;

--예제
--1) lprod 테이블의 모든 컬럼조회
SELECT * FROM lprod;

--2) buyer 테이블에서 buyer_id, buyer_name컬럼만 조회
SELECT buyer_id, buyer_name
FROM buyer;

--3) cart 테이블에서 모든 데이터를 조회
SELECT * FROM cart;

--4) member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회
SELECT mem_id, mem_pass, mem_name
FROM member;

--연산자   /   날짜연산
--date type + 정수 : 일자를 더한다.
--null을 포함한 연산의 결과는 항상 null이다.
SELECT userid, usernm, reg_dt, reg_dt + 5 reg_dt_after5,
    reg_dt - 5 AS reg_dt_before5
FROM users;

COMMIT;

SELECT * FROM users;



--실습

--문제 1) prod 테이블에서 prod_id, prod_name 조회(단, 별칭은 id, name으로 할것)
SELECT prod_id AS id, prod_name name   --별칭을 붙일 경우 뒤에 AS를 붙여주어야 한다. 하지만 쓰지 않아도 문제는 없다.
FROM prod;
--문제 2) lprod 테이블에서 lprod_gu, lprod_nm 조회(별칭 gu, nm)
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;
--문제 3) buyer 테이블에서 buyer_id, buyer_name 조회(별칭 바이어아이디, 이름)
SELECT buyer_id 바이어아이디, buyer_name 이름   --한글로 별칭쓸때에도 ""는 필요가 없다. 단, 대소문자를 구분할 경우는 써준다.
FROM buyer;

--문자열 결합
--java + => sql ||          -- ||연산이 실제 데이터에는 영향이 없고 출력할 때만 적용된다.
--CONCAT(str, str) 함수       --CONCAT또한 실제 데이터에는 영향없음.
--users테이블의 userid, usernm
SELECT userid, usernm, userid || usernm, CONCAT(userid, usernm)
FROM users;

--문자열 상수(컬럼에 담긴 데이터가 아니라 개발자가 직접 임력한 문자열)
SELECT '사용자 아이디 : ' || userid,
        CONCAT('사용자 아이디 : ' , userid)
FROM users;

--실습 sel_con1]
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name AS QUERY
FROM user_tables;


--desc table
--테이블에 정의된 컬럼을 알고 싶을 때
--1.desc
--2.select * ....
desc emp;

SELECT *
FROM emp;

--WHERE절, 조건 연산자
SELECT *
FROM users
WHERE userid = 'brown';

--usernm이 샐리인 데이터를 조회하는 쿼리 작성
SELECT *
FROM users
WHERE usernm = '샐리';


COMMIT;