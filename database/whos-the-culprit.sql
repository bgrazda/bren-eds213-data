-- Whos the culprit?
-- Brooke Grazda

SELECT * FROM Camp_assignment; -- first attempt, exploring camp assignment

SELECT Site, Observer, Start, "End" FROM Camp_assignment -- tried looking through camp assignment 
    WHERE Site = 'nome';


SELECT * FROM Bird_nests -- testing if these filters work 
    WHERE Site = 'nome'
    AND Date_found BETWEEN '1998-01-01' AND '2008-12-30';


-- SOLUTION BELOW
SELECT Personnel.name, COUNT(*) as Num_floated_nests FROM Bird_nests JOIN Personnel ON Bird_nests.Observer = Personnel.Abbreviation
      WHERE Site = 'nome'
      AND Year >= 1998 AND YEAR <= 2008
      AND ageMethod = 'float'
      GROUP BY Observer, Name
      HAVING Num_floated_nests = 36; -- where does not take aggregate functions so need to use HAVING function 
      
-- Answer: Emilie D'Astrous is the culprit
    