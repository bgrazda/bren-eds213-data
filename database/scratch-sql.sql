SELECT DISTINCT Code, Scientific_name FROM Species
    INNER JOIN Bird_nests ON Species.Code = Bird_nests.Species
    INNER JOIN Bird_eggs ON Bird_nests.Nest_ID = Bird_eggs.Nest_ID
    ORDER BY Scientific_name ASC;





