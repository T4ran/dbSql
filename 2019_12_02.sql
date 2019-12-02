--�͸� ���
SET serveroutput ON;

DECLARE
    --����̸��� ������ ��Į�� ����(1���� ��)
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename
    FROM emp;
    --��ȸ����� �������ε� ��Į�� ������ ���� �����Ϸ���. ==> ����
    
    --�߻�����, �߻����ܸ� Ư���ϱ� ���� ��� OTHERS (Java : Exception)
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Exception others');
END;
/

--����� ���� ����
DECLARE
    --emp ���̺� ��ȸ�� ����� ���� ��� �߻���ų ����� ���� ����
    --���ܸ� EXCEPTION;    --������ ����Ÿ��
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
                dbms_output.put_line('������ ������');
                RAISE NO_EMP;
    END;
    
    EXCEPTION
        WHEN NO_EMP THEN
            dbms_output.put_line('no_emp exception');
END;
/

--�����ȣ�� �����ϰ�, �ش� �����ȣ�� �ش��ϴ� ��� �̸��� �����ϴ� �Լ�
CREATE OR REPLACE FUNCTION getEmpName(p_empno emp.empno%TYPE)
RETURN VARCHAR2
IS
    --�����
    ret_ename emp.ename%TYPE;
BEGIN
    --���
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

--�ǽ� 1
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

--�ǽ� 2
SELECT deptcd, LPAD(' ',(LEVEL-1)*4,' ')||deptnm detpnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;
--���� ��°���� ���� ����� ���� �� �ֵ��� LPAD()�κ��� �Լ��� �����.
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

--users ���̺��� pass �÷��� ����� ���
--users_history�� ������ pass�� �̷����� ����� Ʈ����
CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users --users ���̺� ������Ʈ ��
    FOR EACH ROW
    
    BEGIN
        /*
            :NEW.�÷��� - UPDATE ������ �ۼ��� ��
            :OLD.�÷��� - ���� ���̺� ��
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