### Getting and Cleaning Data - Course Project ###

#########
# README
#########

This repository hosts the R script and documentation files for the course project of "Getting and Cleaning data", available in coursera.

Files:
CodeBook.md describes the variables, the data, and any transformations or work that was performed to clean up the data.

run_analysis.R contains all the code to perform the analyses described in the 5 steps. They can be launched in RStudio by just importing the file. With the downloaded and unzipped dataset, the R script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average 
   of each variable for each activity and each subject.

The output of the 5th step is called 'tidy_data.txt', and it is also included.
