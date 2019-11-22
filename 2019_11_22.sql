--상향식 계층 쿼리
--특정 노드로부터 자신의 부모노드를 탐색(트리 전체 탐색 X)
--디자인팀을 시작으로 상위 부서를 조회
--dept0_00_0
SELECT level lv, deptcd, LPAD(' ',(level-1)*4,' ')||dept_h.deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd;

--실습 4
SELECT *
FROM h_sum;

SELECT /*level lv,*/ LPAD(' ',(level-1)*4,' ')||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--실습 5
SELECT *
FROM no_emp;

SELECT LPAD(' ',(level-1)*4,' ')||org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch (가지치기)
--계층쿼리에서 WHERE절은 START WITH, CONNECT BY 절이 전부 적용된 이후에 실행된다.

--dept_h 테이블을 최상위 노드부터 하향식으로 조회
SELECT deptcd, LPAD(' ',4*(level-1), ' ')||deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT deptcd, LPAD(' ',4*(level-1), ' ')||deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
AND deptnm != '정보기획부';

--CONNECT_BY_ROOT(col) : col의 최상위 노드 컬럼 값
--SYS_CONNECT_BY_PATH(col, 구분자) : col의 계층구조 순서를 구분자로 이은 경로
        --LTRIM을 사용하면 최상위 노드의 왼쪽 구분자를 없앨 수 있음.
--CONNECT_BY_ISLEAF : 해당 row가 leaf 노드인지 판별한다.
SELECT LPAD(' ',4*(level-1), ' ')||org_cd org_cd,
    CONNECT_BY_ROOT(org_cd) root_org_cd,
    LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-') path_org_cd,
    CONNECT_BY_ISLEAF isleaf
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--실습 6
SELECT *
FROM board_test;

--실습 7?
SELECT seq, LPAD(' ',4*(level-1), ' ')||title title
FROM board_test
START WITH parent_seq is null
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq desc;

--실습 7 계층쿼리 유지, 정렬
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

--emp테이블에서 직원의 정보와 (급여가 다음번으로 큰 급여를 가진 회원)의 급여를 같이 출력
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