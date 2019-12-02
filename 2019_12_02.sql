--익명 블록
SET serveroutput ON;

DECLARE
    --사원이름을 저장할 스칼라 변수(1개의 값)
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp;
    --조회결과는 여러건인데 스칼라 변수에 값을 저장하려함. ==> 에러
    
    --발생예외, 발생예외를 특정하기 힘들 경우 OTHERS (Java : Exception)
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Exception others');
END;
/

--사용자 정의 예외
DECLARE
    --emp 테이블 조회시 결과가 없을 경우 발생시킬 사용자 정의 예외
    --예외명 EXCEPTION;    --변수명 변수타입
    NO_EMP EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno=9999;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('데이터 미존재');
                RAISE NO_EMP;
    END;
    
    EXCEPTION
        WHEN NO_EMP THEN
            dbms_output.put_line('no_emp exception');
END;
/

--사원번호를 인자하고, 해당 사원번호에 해당하는 사원 이름을 리턴하는 함수
CREATE OR REPLACE FUNCTION getEmpName(p_empno emp.empno%TYPE)
RETURN VARCHAR2
IS
    --선언부
    ret_ename emp.ename%TYPE;
BEGIN
    --기능
    SELECT ename
    INTO ret_ename
    FROM emp
    WHERE empno=p_empno;
    
    RETURN ret_ename;
END;
/

SELECT getEmpName(7369)
FROM dual;

SELECT empno, ename, getEmpName(empno)
FROM emp;

--실습 1
CREATE OR REPLACE FUNCTION getdeptname (p_deptno dept.deptno%TYPE)
RETURN VARCHAR2
IS
    return_dname dept.dname%TYPE;
BEGIN
    BEGIN
        SELECT dname
        INTO return_dname
        FROM dept
        WHERE deptno=p_deptno;
    END;
    
    RETURN return_dname;
END;
/

SELECT deptno, dname, getdeptname(deptno)
FROM dept;

--실습 2
SELECT deptcd, LPAD(' ',(LEVEL-1)*4,' ')||deptnm detpnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;
--위의 출력결과와 같은 결과가 나올 수 있도록 LPAD()부분을 함수로 만든다.
CREATE OR REPLACE FUNCTION indent (p_level NUMBER, p_dname dept.dname%TYPE)
RETURN VARCHAR2
IS
    return_deptnm VARCHAR2(100);
BEGIN
    BEGIN
        SELECT LPAD(' ',(p_level-1)*4,' ')||p_dname
        INTO return_deptnm
        FROM dual;
    END;
    
    RETURN return_deptnm;
END;
/

SELECT *
FROM dept_h;

SELECT deptcd, indent(LEVEL, deptnm) as deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

--
CREATE TABLE user_history(
    userid VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt DATE
);

--users 테이블의 pass 컬럼이 변경될 경우
--users_history에 변경전 pass를 이력으로 남기는 트리거
CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users --users 테이블 업데이트 전
    FOR EACH ROW
    
    BEGIN
        /*
            :NEW.컬럼명 - UPDATE 쿼리시 작성한 값
            :OLD.컬럼명 - 현재 테이블 값
        */
        IF :NEW.pass != :OLD.pass THEN
            INSERT INTO user_history
            VALUES (:OLD.userid, :OLD.pass, sysdate);
        END IF;
    END;
/

SELECT *
FROM users;

COMMIT;

UPDATE users SET pass = 'brownpass'
WHERE userid = 'brown';

rollback;

SELECT *
FROM user_history;

UPDATE users SET pass = 'newpass';