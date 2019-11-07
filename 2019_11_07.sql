/*
emp 테이블에는 부서번호만 존재
emp 테이블에서 부서명을 조회하기 위해서는 dept 테이블과 조인을 통해 부서명 조회

join
ANSI :
테이블명 JOIN 테이블2 ON (테이블.COL = 테이블2.COL)
emp JOIN dept ON (emp.deptno = dept.deptno)

ORACLE :
FORM 테이블, 테이블2 WHERE 테이블.COL = 테이블2.COL
FROM emp, dept 
WHERE emp.deptno = dept.deptno
*/

--사원번호, 사원명, 부서번호, 부서명
SELECT empno, ename, emp.deptno, dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

