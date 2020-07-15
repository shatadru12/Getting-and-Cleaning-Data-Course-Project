# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Michael Galarnyk

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#loading the packages
library(dplyr)
library(reshape2)

#reading data
features <- read.table("~/UCI HAR Dataset/features.txt")
activities <- read.table("~/UCI HAR Dataset/activity_labels.txt")

train <- read.table("~/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt")

test <- read.table("~/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt")

#Appropriate labeling of the data set with descriptive variable names (step 4)
colnames(train) <- features$V2 
train$activity <- y_train$V1

train$subject <- factor(subject_train$V1)

colnames(test) <- features$V2
test$activity <- y_test$V1

test$subject <- factor(subject_test$V1)

#Merging the training and the test sets to create one data set. (step 1)
dataset <- rbind(test, train) 

#Extraction of only the measurements on the mean and standard deviation 
#for each measurement (step 2)
column.names <- colnames(dataset)
column.names.filtered <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE)
dataset.filtered <- dataset[, column.names.filtered] 

#Using descriptive activity names to name the activities in the data set (step 3)
dataset.filtered$activitylabel <- factor(dataset.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and each 
#subject. (step 5)
features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE)
dataset.melt <-melt(dataset.filtered, id = c('activitylabel', 'subject'), measure.vars = features.colnames)
dataset.tidy <- dcast(dataset.melt, activitylabel + subject ~ variable, mean)


write.table(dataset.tidy, file = "tidydataset.txt", row.names = FALSE)
