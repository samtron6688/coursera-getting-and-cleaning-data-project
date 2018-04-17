### Getting and Cleaning Data - Course Project ###

################
# Get the data
################
# Download the .zip file and put it in the "data" folder
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/data_set.zip", method = "curl")

# Unzip the file
unzip(zipfile = "./data/data_set.zip", exdir = "./data")

# Unzipped files are in the folder: UCI HAR Dataset. Get the list of the files
path_rf <- file.path("./data" , "UCI HAR Dataset")
#files <- list.files(path_rf, recursive=TRUE)
#files

# For the purposes of this project, the files in the Inertial Signals folders are not used.
# The files that will be used to load data are listed as follows:
# test/subject_test.txt
# test/X_test.txt
# test/y_test.txt
# train/subject_train.txt
# train/X_train.txt
# train/y_train.txt
# features.txt
# activity_labels.txt

################
# Read the data
################
# Read the Activity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "y_test.txt" ), header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "y_train.txt"), header = FALSE)

# Read the Subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"), header = FALSE)

# Read the Fearures files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ), header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"), header = FALSE)

################################################################
# Merges the training and test data sets to create one data set
################################################################
# Concatenate the data tables by rows
dataSubject  <- rbind(dataSubjectTrain,  dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

# Set names to variables
names(dataSubject)  <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames   <- read.table(file.path(path_rf, "features.txt"), head = FALSE)
names(dataFeatures) <- dataFeaturesNames$V2

# Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
data <- cbind(dataFeatures, dataCombine)

##########################################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement
##########################################################################################
# Subset Name of Features by measurements on the mean and standard deviation
# i.e., taken Names of Features with “mean()” or “std()”
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset the data frame by selected names of Features
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
data <- subset(data, select = selectedNames)

#########################################################################
# Uses descriptive activity names to name the activities in the data set
#########################################################################
# Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)

# Factorize variable "activity" in the data frame using descriptive activity names
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])

# check
# head(data$activity,30)

#####################################################################
# Appropriately labels the data set with descriptive variable names
#####################################################################
names(data)<-gsub("^t", "time",           names(data))
names(data)<-gsub("^f", "frequency",      names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope",    names(data))
names(data)<-gsub("Mag", "Magnitude",     names(data))
names(data)<-gsub("BodyBody", "Body",     names(data))

##########################################################
# Creates a second,independent tidy data set and ouput it
##########################################################
install.packages("plyr")
library(plyr)
data2 <- aggregate(. ~subject + activity, data, mean)
data2 <- data2[order(data2$subject, data2$activity), ]
write.table(data2, file = "tidy_data.txt", row.name = FALSE)

