--member 테이블을 이용하여 member2 테이블을 생성
--member2 테이블에서 김은대 회원(mem_id='a001')의 직업(mem_job)을 '군인'으로 변경 후
--commit 하고 조회

CREATE TABLE member2 AS
SELECT *
FROM member;

commit;

SELECT *
FROM member2;

UPDATE member2
SET mem_job='군인'
WHERE mem_id='a001';

SELECT mem_id, mem_name, mem_job
FROM member2;


--제품별 제품 구매 수량(BUY_QTY) 합계, 제품 구입(BUY_COST) 금액 합계
SELECT *
FROM buyprod
ORDER BY buy_prod;

SELECT buy_prod, prod_name, SUM(buy_qty), sum(buy_cost)
FROM buyprod JOIN prod ON (buyprod.buy_prod = prod.prod_id)
GROUP BY buy_prod, prod_name
ORDER BY buy_prod;

CREATE VIEW VW_PROD_BUY AS
SELECT *
FROM (SELECT buy_prod, prod_name, SUM(buy_qty), sum(buy_cost)
FROM buyprod JOIN prod ON (buyprod.buy_prod = prod.prod_id)
GROUP BY buy_prod, prod_name
ORDER BY buy_prod);

SELECT *
FROM USER_VIEWS;

--도전 실습 1

--부서별 랭킹

SELECT a.ename, a.sal, a.deptno, rownum rn
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc) a;

SELECT a.*, b.*
FROM
(SELECT deptno, count(*) cnt
FROM emp
GROUP BY deptno) a JOIN
(SELECT rownum rn
FROM emp) b ON (a.cnt>=b.rn)
ORDER BY a.deptno, b.rn;

--
SELECT ename, sal, deptno,
    ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;