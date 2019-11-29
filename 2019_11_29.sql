--CURSOR를 명시적으로 선언하지 않고
--LOOP에서 inline 형태로 cursor 사용

--익명블록
SET SERVEROUTPUT ON;
DECLARE
    --cursor 선언 --> LOOP에서 inline 선언
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        dbms_output.put_line(rec.deptno||', '||rec.dname);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE desc_dt
IS
    tempDate DATE;
    cnt NUMBER;
    result1 NUMBER;
    sum1 NUMBER;
    avg1 NUMBER;
BEGIN
    cnt:=0;
    sum1:=0;

    FOR rec IN (SELECT * FROM dt ORDER BY dt desc) LOOP
        IF cnt > 0 then
            result1 := tempDate - rec.dt;
            tempDate := rec.dt;
            sum1 := sum1 + result1;
        ELSE
            tempDate := rec.dt;
        END IF;
        cnt := cnt + 1;
    END LOOP;
    
    avg1 := sum1 / (cnt-1);
    
    dbms_output.put_line(avg1);
END;
/

exec desc_dt;

--cursor 로직제어 실습 4.5
CREATE OR REPLACE PROCEDURE daily_cycle (p_date VARCHAR2) IS
    TYPE cycle_row IS RECORD(
        cid cycle.cid%TYPE,
        pid cycle.pid%TYPE,
        cnt cycle.cnt%TYPE,
        dt VARCHAR2(8));
    
    TYPE cycle_tab IS TABLE OF cycle_row;    
    date_cycle cycle_tab;
BEGIN
    SELECT a.cid, a.pid, a.cnt, TO_CHAR(b.dt, 'YYYYMMDD') dt
    BULK COLLECT INTO date_cycle
    FROM cycle a JOIN
    (
    SELECT TRUNC(TO_DATE(p_date,'YYYYMM'),'MONTH') + (level-1) dt,
           TO_CHAR(TO_DATE(p_date, 'YYYYMM') + (level-1), 'd') d
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_date,'YYYYMM')),'DD')
    ) b ON (a.day = b.d);

    DELETE FROM daily WHERE DT LIKE (p_date||'%');

    FOR i IN 1..date_cycle.count LOOP
        INSERT INTO daily VALUES (date_cycle(i).cid, date_cycle(i).pid, date_cycle(i).dt, date_cycle(i).cnt);
    END LOOP;
    
    COMMIT;
END;
/

exec daily_cycle('201912');

SELECT *
FROM daily;