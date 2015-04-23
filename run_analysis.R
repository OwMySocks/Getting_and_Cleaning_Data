##course project for Cleaning and Getting Data
library(dplyr)
library(plyr)
library(reshape2)

## downloading data
##if(!file.exists('UCI_HAR_DATASET/features.txt')){
##  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##  download.file(fileURL,destfile = "project_data.zip")
##  unzip(zipfile="project_data.zip")
##}

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
##collate the subject, y, and x files with added factor value of "test" or "train" for the participant type
test <- tbl_df(cbind(tbl_testSubject,tbl_testY,tbl_testX))
train <- tbl_df(cbind(tbl_trainSubject,tbl_trainY,tbl_trainX))
names(test)[1:2] <- c("Subject","Activities")
names(train)[1:2] <- c("Subject","Activities")
##merge test and train tables 
allSubjects <- rbind(train,test)
## correct column names to be valid 
names(allSubjects) <- make.names(names(allSubjects),unique=TRUE)

##extract only those features that are means or standard deviations
allSubjectMeansStd <- select(allSubjects,1,2,contains("mean"),contains("std"))

##pull in activity names
names(tbl_activities) <- c("Activities","Activity")
allSubjectMeansStdAct <- select(join(allSubjectMeansStd,tbl_activities, by="Activities"),1,"Activity"=89,3:88)

##rename variables for readability


##average each measure grouped by subject and activity
groupAll <- group_by(allSubjectMeansStdAct,Subject,Activity)
summaryAll <- summarise_each(groupAll,funs(mean))
summary <- allSubjectMeansStdAct %>% group_by(Subject,Activity) %>%summarise_each(funs(mean))

##melt into narrow form 
meltSummary <- melt(summaryAll, id=c("Subject","Activity"),variable.name = "signalMeasurement",value.name="mean")

