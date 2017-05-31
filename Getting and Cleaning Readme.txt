Line 1 loads the necessary packages to run the analysis script

Lines 4-10 import all the data and assigns it to different names

Lines 12 and 13 combine by row both types of subject data and name the variable

Lines 15 and 16 are used to extract the second column and make syntactically valid names of the data

Lines 18 and 19 combine by row both types of subject data and name the variable

Line 21 extracts on the data that matches mean or sd

Line 23 combines by row two types of data into a vector

Lines 25 to 30 replaces all the activity types with their respective names as character strings

Line 32 combines by column three types of data that we are working with

Lines 34 to 39 returns all the rows that match the activity types

Lines 41 to 46 group the data by the subjectId, takes the mean of that column

Lines 48 to 49 create a sequence from 1 to 30, combines it by row into the tidy data table

Lines 51 to 53 creates a repetition of each activity type 30 times and combines it by row into a data frame

Line 55 names the activity type column

Line 57 combines by column the subjects, activity type and tidy data frames.

Line 59 exports the tidy data table into a txt file