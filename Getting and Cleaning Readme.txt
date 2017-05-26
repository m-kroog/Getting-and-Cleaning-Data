Lines 1 and 2 load the necessary packages to run the analysis script

Lines 4-10 import all the data and assigns it to different names

Lines 12 and 13 combine by row both types of subject data and name the variable

Lines 15 and 16 are used to extract the second column and make syntactically valid names of the data

Lines 18 and 19 combine by row both types of subject data and name the variable

Line 21 extracts on the data that matches mean or sd

Line 23 combines by row two types of data into a vector

Lines 25 to 30 replaces all the activity types with their respective names as character strings

Line 32 combines by column three types of data that we are working with

Lines 34 to 39 returns all the rows that match the activity types

Lines 41 to 46 group the data by the subjectId, takes the mean of that column and then takes the mean of each row

Lines 48 to 49 creates a data frame of all six activity types and names each variable

Line 51 makes the data tidy by combining all the activity types into one column and all the means into another column

Lines 53 to 55 create a sequence from 1 to 30, combines it by column into the tidy data table and names each variable

Line 57 exports the tidy data table into a txt file