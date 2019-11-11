--서브쿼리 실습 3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'WARD');

--ANY : 만족하는 것이 하나라도 있는가
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD'));

--ALL : 전부 만족하는가
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD'));

--DISTINCT : 중복 제거
--어떤 직원의 관리자 역할을 하지 않는 직원 정보 조회
--NOT IN 에서는 NULL값이 존재할 경우 조회가 되지않는다.
--따라서 조건문에 조치를 취해야 한다.
SELECT *
FROM emp
WHERE empno NOT IN
(SELECT mgr
FROM emp
WHERE mgr IS NOT NULL);

SELECT *
FROM emp
WHERE empno NOT IN
(SELECT nvl(mgr,0)
FROM emp);

--pair wise
--사번 7499, 7782인 직원의 관리자, 부서번호 조회
--직원중에 관리자와 부서번호가 (7698, 30)이거나 (7839, 10)인 사람
--mgr, deptno 컬럼을 동시에 만족시키는 직원 정보 조회
SELECT *
FROM emp
WHERE (mgr, deptno) IN
(SELECT mgr, deptno
FROM emp
WHERE empno IN (7499, 7782));

SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN(SELECT deptno
              FROM emp
              WHERE empno IN (7499, 7782));
              
--SCALAR SUBQUERY : SELECT 절에 등장하는 서브 쿼리(단, 값이 하나인 행, 하나인 컬럼)
--직원의 소속 부서명을 JOIN을 사용하지 않고 조회
SELECT empno, ename, deptno,
(SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;

SELECT (SELECT SYSDATE FROM dual) sdt
FROM dual;

--sub4 데이터 생성
SELECT *
FROM dept;
INSERT INTO dept VALUES(99,'ddit','daejeon');
commit;

--sub 실습 4
SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno FROM emp);

--실습 5
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid = 1);
                
--실습 6
--cid=2가 애음하는 음료중 cid=1도 애음하는 제품의 애음 정보를 조회
SELECT *
FROM cycle
WHERE pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cid = 1;
        
--실습 7
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle JOIN customer ON(cycle.cid = customer.cid) JOIN product ON(cycle.pid = product.pid)
WHERE product.pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cycle.cid = 1;

--EXISTS MAIN쿼리의 컬럼을 사용해서 SUBQUERY에 만족하는 조건이 있는지 체크
--만족하는 값이 하나라도 존재하면 더이상 진행하지 않고 멈추기 때문에
--성능면에서 유리

--MGR가 존재하는 직원 조회
SELECT *
FROM emp a
WHERE EXISTS(SELECT 'x'
            FROM emp
            WHERE empno = a.mgr);
            
--MGR가 존재하지 않는 직원 조회
SELECT *
FROM emp a
WHERE NOT EXISTS(SELECT *
            FROM emp
            WHERE empno = a.mgr);
            
--실습 8
SELECT *
FROM emp a
WHERE mgr IS NOT NULL;

--부서에 소속된 직원이 있는 부서 정보 조회
SELECT *
FROM dept d
WHERE EXISTS(SELECT ''
            FROM emp
            WHERE deptno = d.deptno);
            
--집합연산
--사번이 7566 또는 7698인 사원 조회(사번,이름)
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);
--UNION : 합집합, 중복을 제거, 대량의 데이터를 처리할 때 부하가 심하다.
--UNION ALL : 중복을 제거하지않고, 위 아래 집합을 결합, UNION 연산자보다 성능면에서 유리하다.
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);

--INTERSECT(교집합 : 위 아래 집합간 공통 데이터)
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);

--MINUS(차집합 : 위 집합에서 아래 집합을 제거 데이터)
--순서 있음
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7499);
