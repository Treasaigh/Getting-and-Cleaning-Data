Coursera Getting and Cleaning Data Course Project 

Introduction
This is the course project for the Coursera Getting and Cleaning Data class of the Data Science signature track offered by John Hopkins Bloomberg School of Public Health.  It is designed to teach how to gather, clean, and manage data from a variety of sources. This is the third course in the Johns Hopkins Data Science Specialization. 

The purpose of this project is to demonstrate your ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 
     1) a tidy data set as described below, 
     2) a link to a Github repository with your script for performing the analysis, and 
     3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject.

Th dataset was downloade and stored in a working directory "UCI HAR Dataset":    
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

1. Read data from the targeted files and set the working directory
2.  Then the path variable was set using file.path 
3. The data was then read in the data from files.
4. Merged the training and the test sets to create one data set. 
5. Edited and modified the column names. 
6. Extracted only the measurements on the mean and standard deviation for each measurement. 
7. Used descriptive activity names to name the activities in the data set
8. Appropriately labels the data set with descriptive activity names. 
9. Then createsda second, independent tidy data set with the average of each variable for each activity and each subject. 
10. Finally, wrote the dataset to a txt file 
