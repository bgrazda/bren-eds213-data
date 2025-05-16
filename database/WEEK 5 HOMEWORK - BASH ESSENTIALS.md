WEEK 5 HOMEWORK - BASH ESSENTIALS

1. Compare the output of these three commands:

ls
ls .
ls "$(pwd)/../ASDN_csv"

Explain why you see what you see.

These commands all print out the same files within subdirectory.


2. Try the following two commands:

wc -l *.csv
cat *.csv | wc -l


The first prints filenames and line counts. The second prints a bare number. Why does it print that number, and why does it not print any filenames?

The first command lists the number of lines and all files in the subdir, while the second prints a the total number of lines because of the concatenate command (cat) in bash sums the number of lines in all files.


3. You want to count the total number of lines in all CSV files and try this command:

cat *.csv | wc -l species.csv

What happens and why?

The number of lines in species.csv is outputted because the command asks for that specific file.

4. You’re given

name=Moe

and you’d like to print “Moe_Howard”. You try this:

echo "$name_Howard"

but that doesn’t quite work. What fix can you apply to $name, while keeping it inside the quotation marks, to make this command give the desired effect?

echo "${name}_Howard" 

5. You create a script and run it like so:

bash myscript.sh *.csv

What are the values of variables $1 and $#? Explain why the script does not see just one argument passed to it.

Two arguments are being passed in: the first is the name of the shell script we are creating (e.g., myscript.sh), and the second is a wildcard representing all the CSV files in the current subdirectory. $1 refers to the first argument (the shell script name), while $@ or $2, $3, etc., would refer to the CSV files. $# actually represents the number of arguments passed, not the arguments themselves.



6. You create a script and run it like so:

bash myscript.sh "$(date)" $(date)

In your script, what is the value of variable $3?

The $3 would be month because it is a date time object, and it includes the entire date string as $1. So, $2 is year and $3 is month.

7. Create a file you don’t care about (because you’re about to destroy it):

echo "yo ho a line of text" > junk_file.txt
echo "another line" >> junk_file.txt

You want to sort the lines in this file, so you try:

sort junk_file.txt

Well that prints the lines in sorted order, but it doesn’t actually change the file. You recall section 7 and try:

sort junk_file.txt > junk_file.txt

What happens and why? How can you sort the lines in your file? (Hint: it involves creating a second file and using mv.)

All forms of > are destructive: Bash overwrites any existing file with an empty file before the program is run. 

When you try to assign that back to junk_file.txt, it is assigning that empty file. Instead, you can assign the sort junk_file.txt to an intermediate file called something different and then assign that file to junk_file.txt.


8. You want to delete all files ending in .csv, so you type (don’t actually try this):

rm * .csv

but as can be seen, your thumb accidentally hit the space bar and you got an extra space in there. What will rm do in this case?

It will delete all of your files in the subdirectory! The space between the asterisk and the .csv tells bash to delete them instead of the ones with just the .csv extension.