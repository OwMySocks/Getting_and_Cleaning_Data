##course project for Cleaning and Getting Data


## downloading data
if(!file.exists('UCI_HAR_DATASET/features.txt')){
  fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,destfile = "project_data.zip")
  unzip(zipfile="project_data.zip")
}

##read in the tables for subject, x, and y for both train and test



##collate the subject, y, and x files with added factor value of "test" or "train" for the participant type



##merge test and train tables 



##extract only those features that are means or standard deviations


##pull in activity names


##rename variables for readability