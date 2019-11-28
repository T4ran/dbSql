--�ǽ� 3
CREATE OR REPLACE PROCEDURE updatedept_test
    (p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE, p_loc IN dept_test.loc%TYPE)
IS
BEGIN
    UPDATE dept_test
    SET dname = p_dname,
        loc = p_loc
    WHERE deptno=p_deptno;
    
    commit;
    
    DBMS_OUTPUT.PUT_LINE('deptno, dname, loc = '||p_deptno||', '||p_dname||', '||p_loc);
END;
/

exec updatedept_test(99,'ddit_m','dajeon');
SELECT * FROM dept_test;

--ROWTYPE : ���̺��� �� ���� �����͸� ���� �� �ִ� ���� Ÿ��
SET SERVEROUTPUT ON;
DECLARE
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line(dept_row.deptno||', '||
                         dept_row.dname||', '||
                         dept_row.loc);
END;
/

--���պ��� : record
DECLARE
    TYPE dept_row IS RECORD(deptno NUMBER(2), dname dept.dname%TYPE);
    
    v_row dept_row;
BEGIN
    SELECT deptno, dname
    INTO v_row
    FROM dept
    WHERE deptno=10;
    
    dbms_output.put_line(v_row.deptno||', '||v_row.dname);
END;
/

--tabletype
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    --java : Ÿ�� ������
    --pl/sql : ������ Ÿ��
    
    v_dept dept_tab;
BEGIN
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    --dbms_output.put_line(v_dept(0).dname); �ε����� 1���� �����Ѵ�.
    FOR i IN 1..v_dept.count LOOP
        dbms_output.put_line(v_dept(i).dname);
    END LOOP;
END;
/

select *
from dept;

--IF
--ELSIF
--END IF;

DECLARE
    ind BINARY_INTEGER;
BEGIN
    ind := 2;
    
    IF ind = 1 THEN
        dbms_output.put_line('IF '||ind);
    ELSIF ind = 2 THEN
        dbms_output.put_line('ELSIF '||ind);
    ELSE
        dbms_output.put_line('ELSE');
    END IF;
END;
/

--FOR LOOP
--FOR �ε������� IN ���۰�..���ᰪ LOOP
--END LOOP;
DECLARE
BEGIN
    FOR i IN 1..4 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

--LOOP : ��� ���� �Ǵ� ������ LOOP �ȿ��� ����
--java : while(true)

DECLARE
    i NUMBER;
BEGIN
    i :=0;
    
    LOOP
        dbms_output.put_line(i);
        i := i+1;
        EXIT WHEN i>=5;
    END LOOP;
END;
/

 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;

SELECT *
FROM dt;

--Loop�� ����Ͽ� ��¥���� ����� ���϶�.
--���� ��� : 5�� <== ��� �޼���
DECLARE
    TYPE dt_tab IS TABLE OF dt%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    dt_test dt_tab;
    i NUMBER;
    sum1 NUMBER;
    result NUMBER;
BEGIN
    SELECT dt
    BULK COLLECT INTO dt_test
    FROM dt
    ORDER BY dt desc;

    i := 1;
    sum1 := 0;
    
    LOOP
        result := dt_test(i).dt - dt_test(i+1).dt;
        sum1 := sum1 + result;
        EXIT WHEN i=(dt_test.count-1);
        i := i+1;
    END LOOP;
    
    result := sum1 / i;
    
    dbms_output.put_line(result);
END;
/

--
SELECT *
FROM dt
ORDER BY dt desc;

SELECT AVG(sub)
FROM
    (SELECT *
    FROM
        (SELECT dt, LEAD(dt) OVER (ORDER BY dt desc) lead, (dt - LEAD(dt) OVER (ORDER BY dt desc)) sub
        FROM dt
        ORDER BY dt desc)
    WHERE sub is not null);
    
--
SELECT a.rn rn1, a.dt adt, b.rn rn2, b.dt bdt, (a.dt-b.dt) sdt, AVG(a.dt-b.dt) avg_dt
FROM
(SELECT rownum rn, dt
FROM dt
ORDER BY dt desc) a JOIN
(SELECT rownum rn, dt
FROM dt
ORDER BY dt desc) b ON (a.rn+1 = b.rn)
GROUP BY a.rn, a.dt, b.rn, b.dt, (a.dt-b.dt);

--
SELECT MAX(dt), MIN(dt), (MAX(dt)-MIN(dt))/(COUNT(*)-1)
FROM dt;

--
DECLARE
    CURSOR dept_cursor IS
        SELECT deptno, dname FROM dept;
    
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    --Ŀ�� ����
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_deptno, v_dname;
        dbms_output.put_line(v_deptno||', '||v_dname);
        EXIT WHEN dept_cursor%NOTFOUND; --���̻� ���� �����Ͱ� ���� �� ����
    END LOOP;
END;
/

--FOR LOOP CURSOR ����
DECLARE
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
    
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    FOR rec IN dept_cursor LOOP
        dbms_output.put_line(rec.deptno || ', ' || rec.dname);
    END LOOP;
END;
/

--�Ķ���Ͱ� �ִ� ����� Ŀ��
DECLARE
    CURSOR emp_cursor(p_job emp.job%TYPE) IS
        SELECT empno, ename, job
        FROM emp
        WHERE job = p_job;
BEGIN
    FOR emp IN emp_cursor('SALESMAN') LOOP
        dbms_output.put_line(emp.empno||', '||emp.ename||', '||emp.job);
    END LOOP;
END;
/