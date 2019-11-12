--실습 7
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle JOIN customer ON(cycle.cid = customer.cid) JOIN product ON(cycle.pid = product.pid)
WHERE product.pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cycle.cid = 1;

--실습 9
SELECT pid, pnm
FROM product
WHERE NOT EXISTS(SELECT '' 
            FROM cycle 
            WHERE cycle.pid = product.pid
            AND cycle.cid = 1);
