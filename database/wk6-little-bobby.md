# Little Bobby Tables 
Brooke Grazda


## Part 1: 
Little Bobby Tables name causes a catastrophe because his name is dropping the entire table and the -- comments out any following code. It has two hyphens so that any code afterward is commented out.


## Part 2:
If Little Bobby Tables kept his name as is, the code would not run, which in a way, is destructive. However, if he removed the parentheses after Robert, then his code could still destroy the table altogether. The first option would not run because there would be dangling parentheses and the second option would run perfectly, destroying the table. 

## Bonus problem:

SELECT * FROM Species WHERE Code = '%s';

where a species code (supplied by the application user) is directly substituted for the query’s %s using Python interpolation. For example, an innocent user might input “wolv”. Craft an input that a devious user could use to:

Add Taylor Swift to the Personnel table
Yet still return the results of the query SELECT * FROM Species WHERE Code = 'wolv' (devious!)


This line replaces the '%s" parameter with the line, and so you can run wolv'; INSERT INTO PERSONNEL (name) VALUES Taylor Swift;-- to hack into the script and add T.

