SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('1981.06.01','YYYY.MM.DD');

--ROWNUM
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

SELECT ROWNUM, a.*
FROM
(SELECT e.*
FROM emp e
ORDER BY ename) a;

SELECT a.*
FROM
(SELECT ROWNUM rn, e.*
FROM emp e
ORDER BY ROWNUM) a
WHERE rn BETWEEN 10 AND 14;

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열
--LENGTH : 문자열의 길이
--INSTR  : 문자열에 특정 문자열이 등장하는 첫번째 인덱스    세번째 파라미터는 문자열 인덱스 이후부터 찾는다는 의미
--LPAD   : 문자열의 왼쪽에 특정 문자열을 삽입, 두번째 파라미터의 숫자보다 작으면 세번째 파라미터의 문자로 채운다.
--RPAD   : 문자열의 오른쪽에 특정 문자열을 삽입, 두번째 파라미터의 숫자보다 작으면 세번째 파라미터의 문자로 채운다.
--        세번째 파라미터가 없으면 공백문자가 삽입된다.
SELECT CONCAT('HELLO',CONCAT(',',' WORLD')) CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5)
       SUBSTR1,
       SUBSTR('HELLO, WORLD', 1, 5) SUBSTR2,
       LENGTH('HELLO, WORLD') LENGTH,
       INSTR('HELLO, WORLD', 'O') INSTR,
       INSTR('HELLO, WORLD', 'O', 6) INSTR,
       LPAD('HELLO, WORLD', 15, '*') LPAD,
       RPAD('HELLO, WORLD', 15, '*') RPAD,
       --REPLACE(원본문자열, 원본문자열에서 변경하고자하는 대상 문자열, 변경문자열)
       REPLACE(REPLACE('HELLO, WORLD','HELLO','hello'), 'WORLD', 'world')
FROM dual;

--ROUND(대상숫자, 반올림 결과 자리수)
SELECT ROUND(105.54, 1) r1,
       ROUND(105.55, 1) r2,
       ROUND(105.55, 0) r3,
       ROUND(105.55, -1) r4
FROM dual;

SELECT empno, ename, sal, (sal - MOD(sal,1000))/1000 qutient, MOD(sal, 1000) reminder
FROM emp;

--TRUNC
SELECT TRUNC(105.54, 1) t1,
       TRUNC(105.55, 1) t2,
       TRUNC(105.55, 0) t3,
       TRUNC(105.55, -1) t4
FROM dual;

--SYSDATE : 오라클이 설치된 서버의 현재 날짜 + 시간정보를 리턴
--별도의 인자가 없는 함수

--TO_CHAR : DATE 타입을 문자열로 변환
--날짜를 문자열로 변환시에 포맷을 지정
SELECT TO_CHAR(SYSDATE + 1*1/24/60/60,'RRRR/MM/DD HH24/MI/SS'), TO_CHAR(SYSDATE + 2*1/24/60/60,'RRRR/MM/DD HH24/MI/SS')
FROM dual;

--date 실습 1
--2019/12/31을 date형식으로 표현
SELECT TO_CHAR(TO_DATE('2019/12/31', 'RRRR/MM/DD'), 'RRRR/MM/DD') LASTDAY,
--5일 이전날짜
    TO_CHAR(TO_DATE('2019/12/31', 'RRRR/MM/DD')-5, 'RRRR/MM/DD') LASTDAY_BEFORE5,
--현재날짜
    TO_CHAR(SYSDATE, 'RRRR/MM/DD') NOW,
--현재날짜에서 3일전
    TO_CHAR(SYSDATE-3, 'RRRR/MM/DD') NOW_BEFORE3
FROM dual;

--date format
--년도 : YYYY, YY, RRRR, RR
--YYYY = RRRR
--YY != RR  50년도보다 클경우 결과가 다르다
--D : 요일을 숫자로 표기
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'),'YYYY/MM/DD') R1,
       TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'),'YYYY/MM/DD') R2,
       TO_CHAR(TO_DATE('35/03/01', 'YY/MM/DD'),'YYYY/MM/DD') Y1,
       TO_CHAR(TO_DATE('55/03/01', 'YY/MM/DD'),'YYYY/MM/DD') Y2,
       TO_CHAR(SYSDATE, 'D') d,
       TO_CHAR(SYSDATE, 'IW') iw,
       TO_CHAR(TO_DATE('20191229', 'YYYYMMDD'), 'IW') THIS_YEAR
FROM DUAL;

SELECT
    TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME,
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--날짜의 반올림(ROUND), 절삭(TRUNC)
--ROUND(DATE, '포맷') YYYY,MM,DD
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       TO_CHAR(ROUND(hiredate + 0.6, 'DD'), 'YYYY/MM/DD HH24:MI:SS') round_yyyy
FROM emp
WHERE ename = 'SMITH';

--TRUNC 생략

--날짜 연산 함수
--MONTHS_BETWEEN(DATE, DATE) : 두 날짜 사이의 개월 수
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
       MONTHS_BETWEEN(TO_DATE('20191117','YYYYMMDD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTHS(DATE, 개월수) : DATE에 개월수가 지난 날짜
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
    ADD_MONTHS(hiredate,467) add_months
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, 요일) : DATE 이후 첫번째 요일의 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE, '토') next_sat
FROM dual;

--LAST_DAY(DATE) : 당월의 마지막 일을 반환
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

SELECT TO_DATE('20191104', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') test,
TO_DATE('20191201', 'YYYYMMDD') - TO_DATE('20191101', 'YYYYMMDD') test2
FROM dual;

--201908 의 일수
SELECT ADD_MONTHS(TO_DATE('201908', 'YYYYMM'),1) - TO_DATE('201908', 'YYYYMM') DT
FROM dual;