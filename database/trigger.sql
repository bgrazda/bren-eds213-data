--- SQLite looks a lot like duckdb
.schema

.tables

.mode table

SELECT * FROM Species;


.nullvalue -NULL-
-- Time to create out trigger
CREATE TRIGGER Fix_up_species
AFTER INSERT ON Species
FOR EACH ROW
BEGIN 
    UPDATE Species
        SET Scientific_name = NULL
        WHERE Code = new.Code AND Scientific_name = '';
END;

--test it
INSERT INTO Species
    VALUES ('efgh', 'thing2', '', 'Study Species');

SELECT * FROM Species;


