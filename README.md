# Getting-and-Cleaning-Data-Course-Project

The script analyzes the files from UCI HAR Datasets (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The files were extracted to a working directory.

The script uses the following files of the directory:

1. features.txt
2. activity_labels.txt
3. train/X_train.txt
4. train/Y_train.txt
5. train/subject_train.txt
6. test/X_test.txt 
7. test/y_test.txt 
8. test/subject_test.txt

## How the Script Works: 

1. Loads the packages required for the analysis.
2. The above mentioned files are read with read.table() function and stored with appropriate names.
3. The columns of the dataset is appropriately labeled with the features names. (step 4)
4. The training and test datasets are merged into one daataset called the 'dataset'. (step 1)
5. Regular Expression is used to extracts only the measurements on the mean and standard deviation for each measurement. (step 2)
6. Descriptive activity names to name the activities in the data set are set using the factor() function. (step 3)
7. From the data set in step 4 a second independent tidy data set is created with the average of each variable for each activity and each subject. (step 5)
