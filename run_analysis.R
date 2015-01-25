library(plyr) 
library(reshape2) 

########################################################################################################## 

## Coursera Getting and Cleaning Data Course Project 
## Tracy Wilson 
## getdata-010

# runAnalysis.R File Description: 

# This script will perform the following steps on the UCI HAR Dataset downloaded from  
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
#     1) a tidy data set as described below, 
#     2) a link to a Github repository with your script for performing the analysis, and 
#     3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
########################################################################################################## 

# Clean up workspace 
rm(list=ls()) 

# 1. Read data from the targeted files.

message("setting working directory") 
# set the working directory
setwd("D:/Users/Tracy/Documents/R/UCI HAR Dataset")

# set the path variable
path_rf <- file.path("D:/Users/Tracy/Documents/R" , "UCI HAR Dataset")


# Read in the data from files:

## Merges the training and the test sets to create one data set. 
dataSet <- list() 

message("reading features.txt") 
dataSet$features <- read.table(paste(path_rf, "features.txt", sep="/"), col.names=c('id', 'name'), stringsAsFactors=FALSE) 

message("reading activity_features.txt") 
dataSet$activity_labels <- read.table(paste(path_rf, "activity_labels.txt", sep="/"), col.names=c('id', 'Activity')) 

message("reading and merging test data") 
dataSet$test <- cbind(subject=read.table(paste(path_rf, "test", "subject_test.txt", sep="/"), col.names="Subject"), 
                      y=read.table(paste(path_rf, "test", "y_test.txt", sep="/"), col.names="Activity.ID"), 
                      x=read.table(paste(path_rf, "test", "x_test.txt", sep="/"))) 

message("reading and merging train data") 
dataSet$train <- cbind(subject=read.table(paste(path_rf, "train", "subject_train.txt", sep="/"), col.names="Subject"), 
                       y=read.table(paste(path_rf, "train", "y_train.txt", sep="/"), col.names="Activity.ID"), 
                       x=read.table(paste(path_rf, "train", "X_train.txt", sep="/"))) 

message("Edit/Modifying column names") 
rename.features <- function(col) { 
  col <- gsub("tBody", "Time.Body", col) 
  col <- gsub("tGravity", "Time.Gravity", col) 
  
  col <- gsub("fBody", "FFT.Body", col) 
  col <- gsub("fGravity", "FFT.Gravity", col) 
  
  
  col <- gsub("\\-mean\\(\\)\\-", ".Mean.", col) 
  col <- gsub("\\-std\\(\\)\\-", ".Std.", col) 
  
  col <- gsub("\\-mean\\(\\)", ".Mean", col) 
  col <- gsub("\\-std\\(\\)", ".Std", col) 
  
  return(col) 
} 

## Extracts only the measurements on the mean and standard deviation for each measurement. (#2)
message("Extracting the measurements on the mean and standard deviation") 
tidyData <- rbind(dataSet$test, dataSet$train)[,c(1, 2, grep("mean\\(|std\\(", dataSet$features$name) + 2)] 


## Uses descriptive activity names to name the activities in the data set (#3)
message("Naming the activities") 
names(tidyData) <- c("Subject", "Activity.ID", rename.features(dataSet$features$name[grep("mean\\(|std\\(", dataSet$features$name)])) 

## Appropriately labels the data set with descriptive activity names. (#4)
message("Labelling the data set") 
tidyData <- merge(tidyData, dataSet$activity_labels, by.x="Activity.ID", by.y="id") 
tidyData <- tidyData[,!(names(tidyData) %in% c("Activity.ID"))] 

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. (#5)
message("Creating tidy data set with the averages of each variable and subject") 
tidyMeanData <- ddply(melt(tidyData, id.vars=c("Subject", "Activity")), .(Subject, Activity), summarise, MeanSamples=mean(value)) 

message("Writing the CSV files") 
write.table(tidyData, file = "tidyData.txt",row.names = FALSE) 
write.table(tidyMeanData, file = "tidyDataMean.txt",row.names = FALSE) 