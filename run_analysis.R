#Get & Set Working Directory 

getwd()
setwd("C:/Users/blagad/Desktop/Coursera R")

#Installing & loading packages
install.packages("dplyr")
install.packages("data.table")

library(dplyr)
library(data.table)

#Create dataframes for each file to merge
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#combine X train & x test data 
X <- rbind(x_train, x_test)

#combine y train & xy test data 
Y <- rbind(y_train, y_test)

#combine subject data 
Subject <- rbind(sub_train, sub_test)
MergeData <- cbind(Subject, Y, X)

#Extract only the measurements on the mean and standard deviation
Mean_Std.Extract <- MergeData %>% select(subject, code, contains("mean"), contains("std"))
Mean_Std.Extract$code <- activities[Mean_Std.Extract$code, 2]

#rename variables to proper name following tidy guidelines (Not sure if Angle and 
#Gravity need to be capitalized) 
names(Mean_Std.Extract)[2] = "activity"
names(Mean_Std.Extract)<-gsub("Acc", "Accelerometer", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("Gyro", "Gyroscope", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("BodyBody", "Body", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("Mag", "Magnitude", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("angle", "Angle", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("gravity", "Gravity", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("^t", "Time", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("^f", "Frequency", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("tBody", "TimeBody", names(Mean_Std.Extract))
names(Mean_Std.Extract)<-gsub("-mean()", "Mean", names(Mean_Std.Extract), ignore.case = TRUE)
names(Mean_Std.Extract)<-gsub("-std()", "STD", names(Mean_Std.Extract), ignore.case = TRUE)
names(Mean_Std.Extract)<-gsub("-freq()", "Frequency", names(Mean_Std.Extract), ignore.case = TRUE)


#From data in step 4, create 2nd independent tidy dataset with averages of 
#each variable for each activity and each subject.
FinalData <- Mean_Std.Extract %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

str(FinalData)
