### Getting and Cleaning Data - Course Project ###

#############
# Code Book
#############

## Introduction
The script, run_analysis.R, performs the 5 steps described in the course project's definition: 
First, all the similar data are merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.

Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.

As activity data are addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.

On the whole dataset, those columns with vague column names are corrected.

Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called tidy_data.txt, and uploaded to this repository.


## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 
 
## Attribute Information
For each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment.


## Code Sections
Section 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, read into tables the data located in

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

Assign column names and merge to create one data set.

Section 2. Extract only the measurements on the mean and standard deviation for each measurement.
Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns.

Section 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activity type table to inlude the descriptive activity names

Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject


## Activity Labels
* `WALKING` (value `1`): subject was walking during the test/train
* `WALKING_UPSTAIRS` (value `2`): subject was walking up a staircase during the test/train
* `WALKING_DOWNSTAIRS` (value `3`): subject was walking down a staircase during the test/train
* `SITTING` (value `4`): subject was sitting during the test/train
* `STANDING` (value `5`): subject was standing during the test/train
* `LAYING` (value `6`): subject was laying down during the test/train


## Notes
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.