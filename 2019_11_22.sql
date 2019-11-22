--����� ���� ����
--Ư�� ���κ��� �ڽ��� �θ��带 Ž��(Ʈ�� ��ü Ž�� X)
--���������� �������� ���� �μ��� ��ȸ
--dept0_00_0
SELECT level lv, deptcd, LPAD(' ',(level-1)*4,' ')||dept_h.deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;

--�ǽ� 4
SELECT *
FROM h_sum;

SELECT /*level lv,*/ LPAD(' ',(level-1)*4,' ')||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--�ǽ� 5
SELECT *
FROM no_emp;

SELECT LPAD(' ',(level-1)*4,' ')||org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch (����ġ��)
--������������ WHERE���� START WITH, CONNECT BY ���� ���� ����� ���Ŀ� ����ȴ�.

--dept_h ���̺��� �ֻ��� ������ ��������� ��ȸ
SELECT deptcd, LPAD(' ',4*(level-1), ' ')||deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT deptcd, LPAD(' ',4*(level-1), ' ')||deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '������ȹ��';

--CONNECT_BY_ROOT(col) : col�� �ֻ��� ��� �÷� ��
--SYS_CONNECT_BY_PATH(col, ������) : col�� �������� ������ �����ڷ� ���� ���
        --LTRIM�� ����ϸ� �ֻ��� ����� ���� �����ڸ� ���� �� ����.
--CONNECT_BY_ISLEAF : �ش� row�� leaf ������� �Ǻ��Ѵ�.
SELECT LPAD(' ',4*(level-1), ' ')||org_cd org_cd,
    CONNECT_BY_ROOT(org_cd) root_org_cd,
    LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-') path_org_cd,
    CONNECT_BY_ISLEAF isleaf
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--�ǽ� 6
SELECT *
FROM board_test;

--�ǽ� 7?
SELECT seq, LPAD(' ',4*(level-1), ' ')||title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq desc;

--�ǽ� 7 �������� ����, ����
SELECT seq, LPAD(' ',4*(level-1), ' ')||title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY
CASE WHEN parent_seq IS null THEN seq ELSE parent_seq END desc;

--
SELECT seq, LPAD(' ',4*(level-1), ' ')||title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY
CASE WHEN parent_seq IS null THEN seq ELSE parent_seq END desc;

--
SELECT *
FROM board_test;

ALTER TABLE board_test ADD (gn NUMBER);

SELECT seq, LPAD(' ', 4*(level-1), ' ')||title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq;

--emp���̺��� ������ ������ (�޿��� ���������� ū �޿��� ���� ȸ��)�� �޿��� ���� ���
SELECT a.ename, a.sal, b.sal U_sal, a.rn, b.rn
FROM
(SELECT ename, sal, rownum rn
FROM
    (SELECT ename, sal
    FROM emp
    ORDER BY sal)) a
LEFT OUTER JOIN
(SELECT ename, sal, rownum rn
FROM
    (SELECT ename, sal
    FROM emp
    ORDER BY sal)) b
ON ((a.rn+1)=b.rn);