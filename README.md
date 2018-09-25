# Getting-and-Cleaning-Data-Project

This repository contains the following files:

README.md - a description of all files
CodeBook.md -  a descrtiption of the contents of the data set
run.analysis.r - the r script that was used to perform the analysis
tidydata.txt - the file resulting form the analysis

The run.analysis.r file does the following:

1. Imports all data (feature, activity, test and train)
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Merges the training and the test sets to create one data set.
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject. The name is tidydata.txt.
