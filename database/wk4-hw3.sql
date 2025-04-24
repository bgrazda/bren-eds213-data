-- SQL Problem 3

-- Calculate averages in a temporary table
CREATE TEMP TABLE Avgs AS
     SELECT Nest_ID, AVG((3.14/6)*(Width^2*Length)) AS Avg_volume
         FROM Bird_eggs
         GROUP BY Nest_ID;


-- Create an intermediary table
CREATE TEMP TABLE inter_table AS
     SELECT Species, MAX(Avg_volume) AS Max_avg_volume
     FROM Bird_nests JOIN Avgs USING (Nest_ID)
     GROUP BY Species;


FROM inter_table JOIN Species ON Species.code = inter_table.Species
     SELECT Max_avg_volume, Scientific_name
     ORDER BY Max_avg_volume DESC;