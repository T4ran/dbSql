-- SELECT : ��ȸ�� �÷� ���
--         - ��ü �÷� ��ȸ : *
--         - �Ϻ� �÷� : �ش� �÷��� ���� (,����)
-- FROM : ��ȸ�� ���̺� ���
-- ������ �����ٿ� ����� �ۼ��ص� ��� ����.
-- �� keyword�� �ٿ��� �ۼ�

-- ��� �÷� ��ȸ
SELECT * FROM prod;

-- Ư�� �÷��� ��ȸ
SELECT prod_id, prod_name
FROM prod;

--����
--1) lprod ���̺��� ��� �÷���ȸ
SELECT * FROM lprod;

--2) buyer ���̺��� buyer_id, buyer_name�÷��� ��ȸ
SELECT buyer_id, buyer_name
FROM buyer;

--3) cart ���̺��� ��� �����͸� ��ȸ
SELECT * FROM cart;

--4) member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ
SELECT mem_id, mem_pass, mem_name
FROM member;

--������   /   ��¥����
--date type + ���� : ���ڸ� ���Ѵ�.
--null�� ������ ������ ����� �׻� null�̴�.
SELECT userid, usernm, reg_dt, reg_dt + 5 reg_dt_after5,
    reg_dt - 5 AS reg_dt_before5
FROM users;

COMMIT;

SELECT * FROM users;



--�ǽ�

--���� 1) prod ���̺��� prod_id, prod_name ��ȸ(��, ��Ī�� id, name���� �Ұ�)
SELECT prod_id AS id, prod_name name   --��Ī�� ���� ��� �ڿ� AS�� �ٿ��־�� �Ѵ�. ������ ���� �ʾƵ� ������ ����.
FROM prod;
--���� 2) lprod ���̺��� lprod_gu, lprod_nm ��ȸ(��Ī gu, nm)
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;
--���� 3) buyer ���̺��� buyer_id, buyer_name ��ȸ(��Ī ���̾���̵�, �̸�)
SELECT buyer_id ���̾���̵�, buyer_name �̸�   --�ѱ۷� ��Ī�������� ""�� �ʿ䰡 ����. ��, ��ҹ��ڸ� ������ ���� ���ش�.
FROM buyer;

--���ڿ� ����
--java + => sql ||          -- ||������ ���� �����Ϳ��� ������ ���� ����� ���� ����ȴ�.
--CONCAT(str, str) �Լ�       --CONCAT���� ���� �����Ϳ��� �������.
--users���̺��� userid, usernm
SELECT userid, usernm, userid || usernm, CONCAT(userid, usernm)
FROM users;

--���ڿ� ���(�÷��� ��� �����Ͱ� �ƴ϶� �����ڰ� ���� �ӷ��� ���ڿ�)
SELECT '����� ���̵� : ' || userid,
        CONCAT('����� ���̵� : ' , userid)
FROM users;

--�ǽ� sel_con1]
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name AS QUERY
FROM user_tables;


--desc table
--���̺� ���ǵ� �÷��� �˰� ���� ��
--1.desc
--2.select * ....
desc emp;

SELECT *
FROM emp;

--WHERE��, ���� ������
SELECT *
FROM users
WHERE userid = 'brown';

--usernm�� ������ �����͸� ��ȸ�ϴ� ���� �ۼ�
SELECT *
FROM users
WHERE usernm = '����';


COMMIT;