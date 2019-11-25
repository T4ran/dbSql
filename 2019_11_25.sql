--member ���̺��� �̿��Ͽ� member2 ���̺��� ����
--member2 ���̺��� ������ ȸ��(mem_id='a001')�� ����(mem_job)�� '����'���� ���� ��
--commit �ϰ� ��ȸ

CREATE TABLE member2 AS
SELECT *
FROM member;

commit;

SELECT *
FROM member2;

UPDATE member2
SET mem_job='����'
WHERE mem_id='a001';

SELECT mem_id, mem_name, mem_job
FROM member2;


--��ǰ�� ��ǰ ���� ����(BUY_QTY) �հ�, ��ǰ ����(BUY_COST) �ݾ� �հ�
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

--���� �ǽ� 1

--�μ��� ��ŷ

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