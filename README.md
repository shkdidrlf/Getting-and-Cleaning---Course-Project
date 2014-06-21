Getting-and-Cleaning---Course-Project
=====================================

Data analysis

This File reads every files of Samsung data
and integrate it as a one table

#Call training set and combine it
This part of the code reading all the files of training set
and make all as a one data frame

#Call test set and combine it
This part reads all the files for test of test set
and make all as a one data frame

#name each variables
Set column names on data frame

#combining training and test
make two in one data frame

#Extract mean and standard deviation
mean and standard deviation vector for each measurements
and calculate each measurements

#Average of each variable for each activity and each subject
triple overlapped for loop is used
first loop : subjects 1~30
second loop : activity types 1~6
and then calculate mean of measuresments for each condition
e.g. subject1 and activity type1, subject1 and activity type2 .... subject30 and activity type6
