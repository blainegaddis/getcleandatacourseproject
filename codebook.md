The run_analysis.R script performs the data preparation and the 5 steps required in the project instructions.

Download the dataset:
  * Dataset downloaded and extracted under the folder UCI HAR Dataset

Assign each data to variables:
  * features <- features.txt : 561 rows, 2 columns
    Features selected for this database are from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
  * activities <- activity_labels.txt : 6 rows, 2 columns
    List of activities performed when corresponding measurements were taken and its codes (labels)
  * sub_test <- test/sub_test.txt : 2947 rows, 1 column
    Contains test data of volunteer test subjects being observed
  * x_test <- test/X_test.txt : 2947 rows, 561 columns
    Contains recorded features test data
  * y_test <- test/y_test.txt : 2947 rows, 1 column
    Contains test data of activities’ code labels
  * sub_train <- test/sub_train.txt : 7352 rows, 1 column
    Contains train data of volunteer subjects being observed
  * x_train <- test/X_train.txt : 7352 rows, 561 columns
    Contains recorded features train data
  * y_train <- test/y_train.txt : 7352 rows, 1 column
    Contains train data of activities’code labels

Merges the training and test data sets to create one data set:
  * X (10299 rows, 561 columns) created by merging x_train and x_test using rbind() function
  * Y (10299 rows, 1 column) created by merging y_train and y_test using rbind() function
  * Subject (10299 rows, 1 column) created by merging sub_train and sub_test using rbind() function
  * MergeData (10299 rows, 563 columns) created by merging Subject, Y and X using cbind() function

Extracts the means and standard deviations for each measurement:
  * Mean_Std.Extract (10299 rows, 88 columns) created by subsetting MergeData, selecting columns: subject, code, and means and standard deviations for each measurement

Uses descriptive activity names to name the activities in the data set:
  * Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names:
  * code column in TidyData renamed into activities
  * All Acc in column’s name replaced by Accelerometer
  * All Gyro in column’s name replaced by Gyroscope
  * All BodyBody in column’s name replaced by Body
  * All Mag in column’s name replaced by Magnitude
  * All ^f in column’s name replaced by Frequency
  * All ^t in column’s name replaced by Time

Creates a second, independent tidy data set with average of each variable for each activity and each subject
  * FinalData (180 rows, 88 columns) created by sumarizing Mean_Std.Extract taking means of each variable for each activity and each subject, after grouping by subject and activity.
  * Export FinalData to FinalData.txt file.
