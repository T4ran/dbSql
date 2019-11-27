--1.leaf node 찾기
SELECT org_cd, no_emp, connect_by_isleaf leaf
FROM no_emp
START WITH parent_org_cd IS null
CONNECT BY PRIOR org_cd = parent_org_cd;
--
SELECT a.*, rownum rn, a.lv + rownum gr
FROM
(SELECT org_cd, parent_org_cd, no_emp, level lv, connect_by_isleaf leaf
FROM no_emp
START WITH parent_org_cd IS null
CONNECT BY PRIOR org_cd = parent_org_cd) a
START WITH leaf = 1
CONNECT BY org_cd = PRIOR parent_org_cd;
--
SELECT *
FROM
(SELECT org_cd, parent_org_cd, SUM(s_emp) s_emp
FROM
(SELECT org_cd, parent_org_cd, no_emp, lv, leaf, rn, gr, org_cnt,
       SUM(no_emp/org_cnt) OVER (PARTITION BY GR
                         ORDER BY rn
                         ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW) s_emp
FROM
(SELECT a.*, rownum rn, a.lv + rownum gr, COUNT(org_cd) OVER (PARTITION BY org_cd) org_cnt
FROM
(SELECT org_cd, parent_org_cd, no_emp, level lv, connect_by_isleaf leaf
FROM no_emp
START WITH parent_org_cd IS null
CONNECT BY PRIOR org_cd = parent_org_cd) a
START WITH leaf = 1
CONNECT BY org_cd = PRIOR parent_org_cd))
GROUP BY org_cd, parent_org_cd)
START WITH parent_org_cd IS NULL
CONNECT BY PRIOR org_cd = parent_org_cd;

--PL/SQL
--할당 연산 :=
--dbms_out.put_line("");

--set serveroutput on; --출력 기능 활성화

set serveroutput on;

--PL/SQL
--declare : 변수, 상수 선언
--begin : 로직 실행
--exception : 예외처리
--desc dept;
--
set serveroutput on;
DECLARE
    deptno NUMBER(2);
    dname VARCHAR2(14);
BEGIN
    dbms_output.put_line('test');
END;
/
set serveroutput on;
DECLARE
    deptno NUMBER(2);
    dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dname : ' ||dname||'('||deptno||')');
END;
/

set serveroutput on;
DECLARE
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dname : ' ||dname||'('||deptno||')');
END;
/

--10번부서의 부서이름과 LOC정보를 화면에 출력하는 프로시저
--프로시저명 : printdept
CREATE OR REPLACE PROCEDURE printdept
IS
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dname, loc = '||dname||', '||loc);
END;
/

exec printdept;

CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE)
IS
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    dbms_output.put_line('dname, loc = '||dname||', '||loc);
END;
/

exec printdept_p(30);

--실습 1
CREATE OR REPLACE PROCEDURE printemp(p_empno IN emp.empno%TYPE)
IS
    ename emp.ename%TYPE;
    dname dept.dname%TYPE;
BEGIN
    SELECT a.ename, b.dname
    INTO ename, dname
    FROM emp a JOIN dept b ON (a.deptno = b.deptno)
    WHERE a.empno = p_empno;
    
    dbms_output.put_line('ename, dname = '||ename||', '||dname);
END;
/

exec printemp(7369);

SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept on (emp.deptno = dept.deptno);

--실습 2
SELECT *
FROM dept_test;

DROP TABLE dept_test;
commit;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

CREATE OR REPLACE PROCEDURE registdept_test
    (p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE, p_loc IN dept_test.loc%TYPE)
IS
    var_deptno dept_test.deptno%TYPE;
    var_dname dept_test.dname%TYPE;
    var_loc dept_test.loc%TYPE;
BEGIN
    INSERT INTO dept_test (deptno, dname, loc)
    VALUES (var_deptno, var_dname, var_loc);
    
    DBMS_OUTPUT.PUT_LINE('deptno, dname, loc = '||p_deptno||', '||p_dname||', '||p_loc);
END;
/

exec registdept_test(99,'ddit','dajeon');