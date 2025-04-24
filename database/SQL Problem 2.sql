-- SQL Problem 2
--SELECT Site_name, MAX(Area) FROM Site;
-- DuckDB throws the error above because  it does not know which Site Name to
--  pair the max area without specifying. It also does not allow aggregates, so it does not know where 
-- to look for the max.


-- Part 2
SELECT Site_name, Area FROM Site ORDER BY Area DESC LIMIT 1;

-- Part 3

SELECT Site_name, Area FROM Site WHERE Area = (SELECT Area FROM Site ORDER BY Area DESC LIMIT 1);


