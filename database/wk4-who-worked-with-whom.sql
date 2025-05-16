-- Who worked with whom?
--camp assignment lists where each person worked and when 

--self join of a table is a regular join, but just joining two copies of the same table
--SELECT * FROM Camp_assignment A JOIN Camp_assignment B



-- Step 1. To the above join, add an ON clause that selects only those rows 
--where the two people (the “A” person and the “B” person) worked at the same site: 
--ON A.Site = .... You should wind up with a table with 15521 rows.

SELECT * FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site;

-- Step 2 We’ve matched up people working at the same site, but they don’t necessarily overlap in time. 
--To the previous ON clause, add another condition that checks that the “A” person’s and the “B” person’s date ranges 
--overlap. If you are unsure of the formula to do this, it may be helpful to consult this StackOverflow post. 
--Your table should be down to 3500 rows.

SELECT * FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site AND (A.Start <= B.END) AND (A.END >= B.START);


-- Step 3: add a clause WHERE A.Site = 'lkri' so you have only 8 rows. 
--If you look closely, you can see that there are rows representing people working with themselves, 
--which is not what we’re interested in. Also, every pair of people working together is represented 
--by two rows, which are identical but with the names in different order. We only want one row per 
--unique pair of people. We can clean this up by adding a condition to the clause, A.Observer < B.Observer. 
--I.e., we only want ordered, distinct pairs. Your table should be down to 2 rows.

SELECT A.Site, A.Observer as Observer_1, B.Observer as Observer_2 FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site AND (A.Start <= B.END) AND (A.END >= B.START)
    WHERE A.Site = 'lkri'
    AND A.Observer < B.Observer;

-- Bonus problem
-- Produce a nicer table by joinig with the Personnel table
--You’ll need to join with the Personnel table twice, once for each observer column. 
--You may need give abbreviations to tables (e.g., JOIN Personnel AS p1) to distinguish the tables and columns. 
--You can do it!


CREATE TEMP TABLE Observers AS
    SELECT A.Site, A.Observer as Observer_1, B.Observer as Observer_2 FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site AND (A.Start <= B.END) AND (A.END >= B.START)
    WHERE A.Site = 'lkri'
    AND A.Observer < B.Observer;

SELECT * FROM Observers;
SELECT p1.abbreviation, p2.abbreviation, p1.Name as Name_1, p2.Name as Name_2 FROM Personnel p1 JOIN Personnel p2
    ON p1.Abbreviation = p2.Abbreviation
    JOIN Observers O 
    ON (O.Observer_1 = p1.Abbreviation AND O.Observer_2 = p2.Abbreviation);

-- SOLUTION BELOW
SELECT Site, 
  p1.Name AS Name_1,
  p2.Name AS Name_2
FROM Observers O
JOIN Personnel p1 ON O.Observer_1 = p1.Abbreviation
JOIN Personnel p2 ON O.Observer_2 = p2.Abbreviation;
-- SOLUTION ^^
