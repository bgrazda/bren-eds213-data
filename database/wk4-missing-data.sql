-- Which sites have no egg data? 
--Bird_eggs table, the Site table, or both

--testing queries
SELECT (*) FROM Bird_eggs; -- lists whole table
SELECT DISTINCT Site FROM Bird_eggs; -- lists unique sites in bird_Eggs table

--Using a Code NOT IN (subquery) clause.
SELECT Code FROM Site 
    WHERE Code NOT IN (SELECT Site FROM Bird_eggs); -- not in subquery clause solution


--Using an outer join with a WHERE clause that selects the desired rows
SELECT Code FROM Site LEFT JOIN Bird_eggs
    ON Code = Site
    WHERE Site IS NULL
    ORDER BY Code ASC
    ; 

--Using the set operation EXCEPT.
SELECT Code FROM Site
    EXCEPT
    SELECT Site FROM Bird_eggs
    ORDER BY Code ASC;

