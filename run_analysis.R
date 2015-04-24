##course project for Cleaning and Getting Data
library(plyr)
library(dplyr)
library(reshape2)

## downloading data
if(!file.exists('UCI_HAR_DATASET/features.txt')){
  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,destfile = "project_data.zip")
  unzip(zipfile="project_data.zip")
}

##read in the tables for subject, x, and y for both train and test

##file strings for important files
f_feature <- "UCI HAR Dataset/features.txt"
f_activities <- "UCI HAR Dataset/activity_labels.txt"
f_testSubject <- "UCI HAR Dataset/test/subject_test.txt"
f_testX <- "UCI HAR Dataset/test/X_test.txt"
f_testY <- "UCI HAR Dataset/test/y_test.txt"
f_trainSubject <- "UCI HAR Dataset/train/subject_train.txt"
f_trainX <- "UCI HAR Dataset/train/X_train.txt"
f_trainY <- "UCI HAR Dataset/train/y_train.txt"

##data tables for files
tbl_features <-tbl_df(read.table(f_feature,sep=" "))
tbl_activities <- tbl_df(read.table(f_activities, sep=" "))
tbl_testSubject <- tbl_df(read.table(f_testSubject, sep = " "))
tbl_testX <- tbl_df(read.table(f_testX))
tbl_testY <- tbl_df(read.table(f_testY, sep = " "))
tbl_trainSubject <- tbl_df(read.table(f_trainSubject, sep = " "))
tbl_trainX <- tbl_df(read.table(f_trainX))
tbl_trainY <- tbl_df(read.table(f_trainY, sep = " "))
##rename data columns to the features
names(tbl_testX) <- tbl_features$V2
names(tbl_trainX) <- tbl_features$V2

##collate the subject, y, and x files for both the test and train subjects
test <- tbl_df(cbind(tbl_testSubject,tbl_testY,tbl_testX))
train <- tbl_df(cbind(tbl_trainSubject,tbl_trainY,tbl_trainX))

##rename the first two columns to be readable
names(test)[1:2] <- c("Subject","Activities")
names(train)[1:2] <- c("Subject","Activities")

##merge test and train tables by essentially stacking them on top of each other
allSubjects <- rbind(train,test)

##correct column names to be valid in future statements
names(allSubjects) <- make.names(names(allSubjects),unique=TRUE)

##extract only those features that are means or standard deviations
allSubjectMeansStd <- select(allSubjects,1,2,contains("mean"),contains("std"))

##pull in activity names by joining the activities table to the main table and 
names(tbl_activities) <- c("Activities","Activity")
allSubjectMeansStdAct <- select(join(allSubjectMeansStd,tbl_activities, by="Activities"),1,"Activity"=89,3:88)

##rename variables for readability
names(allSubjectMeansStdAct) <- c("Subject","Activity","tBodyAcc.mean.X","tBodyAcc.mean.Y","tBodyAcc.mean.Z" ,"tGravityAcc.mean.X","tGravityAcc.mean.Y","tGravityAcc.mean.Z","tBodyAccJerk.mean.X","tBodyAccJerk.mean.Y","tBodyAccJerk.mean.Z","tBodyGyro.mean.X","tBodyGyro.mean.Y","tBodyGyro.mean.Z","tBodyGyroJerk.mean.X","tBodyGyroJerk.mean.Y","tBodyGyroJerk.mean.Z","tBodyAccMag.mean","tGravityAccMag.mean","tBodyAccJerkMag.mean","tBodyGyroMag.mean","tBodyGyroJerkMag.mean","fBodyAcc.mean.X","fBodyAcc.mean.Y","fBodyAcc.mean.Z","fBodyAcc.meanFreq.X","fBodyAcc.meanFreq.Y","fBodyAcc.meanFreq.Z","fBodyAccJerk.mean.X","fBodyAccJerk.mean.Y","fBodyAccJerk.mean.Z","fBodyAccJerk.meanFreq.X","fBodyAccJerk.meanFreq.Y","fBodyAccJerk.meanFreq.Z","fBodyGyro.mean.X","fBodyGyro.mean.Y","fBodyGyro.mean.Z","fBodyGyro.meanFreq.X","fBodyGyro.meanFreq.Y","fBodyGyro.meanFreq.Z","fBodyAccMag.mean","fBodyAccMag.meanFreq","fBodyAccJerkMag.mean","fBodyAccJerkMag.meanFreq","fBodyGyroMag.mean","fBodyGyroMag.meanFreq","fBodyGyroJerkMag.mean","fBodyGyroJerkMag.meanFreq","angle.tBodyAccMean.gravity","angle.tBodyAccJerkMean.gravityMean","angle.tBodyGyroMean.gravityMean","angle.tBodyGyroJerkMean.gravityMean","angle.X.gravityMean","angle.Y.gravityMean","angle.Z.gravityMean","tBodyAcc.std.X","tBodyAcc.std.Y","tBodyAcc.std.Z","tGravityAcc.std.X","tGravityAcc.std.Y","tGravityAcc.std.Z","tBodyAccJerk.std.X","tBodyAccJerk.std.Y","tBodyAccJerk.std.Z","tBodyGyro.std.X","tBodyGyro.std.Y","tBodyGyro.std.Z","tBodyGyroJerk.std.X","tBodyGyroJerk.std.Y","tBodyGyroJerk.std.Z","tBodyAccMag.std","tGravityAccMag.std","tBodyAccJerkMag.std","tBodyGyroMag.std","tBodyGyroJerkMag.std","fBodyAcc.std.X","fBodyAcc.std.Y","fBodyAcc.std.Z","fBodyAccJerk.std.X","fBodyAccJerk.std.Y","fBodyAccJerk.std.Z","fBodyGyro.std.X","fBodyGyro.std.Y","fBodyGyro.std.Z","fBodyAccMag.std","fBodyAccJerkMag.std","fBodyGyroMag.std","fBodyGyroJerkMag.std" )       

##average each measure grouped by subject and activity
groupAll <- group_by(allSubjectMeansStdAct,Subject,Activity)
summaryAll <- summarise_each(groupAll,funs(mean))

##melt into narrow form 
meltSummary <- melt(summaryAll, id=c("Subject","Activity"),variable.name = "Signal_Measurement",value.name="Mean")

##write file

write.table(meltSummary,"tidy_data.txt",row.name=FALSE,sep=",")
