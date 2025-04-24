-- Continuing with SQL
-- Somewhat arbitrary but illustrative query
SELECT Species, COUNT(*) AS Nest_count FROM Bird_nests
    WHERE Site = 'nome'
    GROUP BY Species
    HAVING Nest_count > 10
    ORDER BY Species LIMIT 2;

-- We can nest queries!
SELECT Scientific_name, Nest_count FROM
    (SELECT Species, COUNT(*) AS Nest_count FROM Bird_nests
    WHERE Site = 'nome'
    GROUP BY Species
    HAVING Nest_count > 10
    ORDER BY Species 
    LIMIT 2) JOIN Species
    ON Species = Code;
    
-- Outer joins
CREATE TEMP TABLE a (
    cola INTEGER
    common INTEGER
);
INSERT INTO a VALUES (1, 1), (2, 2), (3, 3);
SELECT * FROM a;


-- The joins we've been doing so far have been 'inner' joins
SELECT * FROM a JOIN b using (common);
SELECT * FROM a JOIN b ON a.common = b.common;

-- By doing an outer join either left or right, we'll add certain missing rows
SELECT * FROM a LEFT JOIN b ON a.common = b.common;
SELECT * FROM a RIGHT JOIN b ON a.common = b.common;

-- Running example: what species do not have any nest data?
SELECT COUNT(DISTINCT Species) FROM Bird_nests;

-- method 1
SELECT Code FROM Species 
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests); -- Likely the more efficient species

SELECT Code FROM Species
    WHERE Code NOT IN (SELECT Species FROM Bird_nests); -- Same answer as the query above

-- method 2
SELECT Code, Species FROM Species LEFT JOIN Bird_nests   
    ON Code = Species
    WHERE Species IS NULL; -- This line finds all the codes do not have a species in the bird nests table

-- It's also possible to join a table with itself, a so-called 'self join'
-- HOMEWORK PROBLEM HINT

-- Understanding a limitation of DuckDB
SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Let's add in Observer
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- there can only be one value for observer because NEST_ID is the primary key, and it repeats the values for each NEST_ID when joining with BIRD_EGGS
SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%';

-- DuckDB solution #1:
SELECT Nest_ID, Observer, COUNT(*) As Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (NEST_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID, Observer;

-- DuckDB solution #2
SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Views: a virtual table
CREATE VIEW my_nests AS
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

.tables
SELECT * FROM my_nests;
SELECT Nest_ID, Name, Num_eggs
    FROM my_nests JOIN Personnel
    On Observer = Abbreviation;

-- view
-- temp table
--whats the diff?

CREATE TEMP TABLE my_nests_temp_table AS
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;
.table

-- What about modifications (inserts, updates, deletes) on a view? Possible?
-- It depends
--- Whether its theoretically possible 
--- How smart the database is

-- Last topic: set operations
--- UNION, UNION ALL, INTERSECT, EXCEPT

SELECT * FROM bird_eggs LIMIT 5;
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS Length, Width*25.4 AS Width 
    From Bird_eggs
    WHERe Book_page LIKE 'b14%'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width
    From Bird_eggs
    WHERe Book_page NOT LIKE 'b14%';

-- Method 3 for running example
SELECT Code FROM Species
EXCEPT 
SELECT DISTINCT Species FROM Bird_nests; 