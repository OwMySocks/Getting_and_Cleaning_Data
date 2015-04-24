---
title: "Codebook- Getting and Cleaning Data Course Project"
author: "Rebecca Everett"
date: "4/23/2015"
class: "Getting and Cleaning Data"
---
##Project Description
The aim of this project was to create a smaller tidy dataset that summarizes the dataset found in the UCI HAR Dataset folder in this repository. This tidy dataset should be composed of the average of each signal measurement or "feature" for each subject and activity pair. 

Further details about the UCI HAR dataset can be found in the README.txt and features_info.txt files found in the UCI HAR Dataset folder. 

##Study Design and data processing
  

###Collection of the raw data
From the UCI HAR documentation: 
  "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.
  
  The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment."

###Notes on the original (raw) data
  The files that ultimately contributed to this tidy set from the raw data are:
  
  - features.txt 
  - activity_labels.txt 
  - test/subject_test.txt
  - test/X_test.txt
  - test/y_test.txt
  - train/subject_train.txt
  - train/X_train.txt
  - train/y_train.txt
  
  The files that appear in the test and train folders are analgolous to each other, only differing in that they are from different sets of subjects. The "subject\_test(train)" files contained a list of subject IDs that lined up with the activity numbers in "y\_test(train)", which also corrosponded on a line-by-line basis with the information in X\_test(train), which was a 561 column matrix. The values of these columns were summarized measurements which corrosponded to the values of the features.txt file. I will go into further detail about the values in features.txt below for those values that were kept in this analysis.

##Creating the tidy datafile

###Guide to create the tidy data file
To create the tidy\_data.txt file, run run\_analysis.R. It will check to see if the needed data has been downloaded and if it hasn't, it will do so. The tidy\_data.txt file will be created in the working directory of R. 

###Cleaning of the data
The steps taken to create the tidy data are as follows:

- The raw data were read into multiple tables in R
- Names of the columns in X\_train.txt and X\_test.txt were changed to match features.txt 
- subject\_test, X\_test, and y\_test were collated together to form a large table, the first two columns were changed to descriptive titles, and the same was done for the anagolous train files
- The train and test files from the last step were combined to form one table 
- The feature columns that were not means or standard deviations were removed. Note- I retained all features that had the word "mean" in them, as the wording of the project prompt was vague enough to create doubt, and in general practice I would rather err on having too much data when the request is unclear.
- The activity labels were brought in and replaced the numeric activity ID
- The remaining signal measurement (feature) names were replaced by slightly more readable names- the system I used is explained below in the "Signal Measurement" variable description 
- The averages of each signal measurement for each activity and subject were found 
- The resulting wide-form 180x88 data table was melted into a narrow form of the same information by creating a column for "Signal_Measurement" that uses the signal measurement names as a factor with a seperate column for the value of each averaged signal measurement/activity/subject. This was done to cut down on the number of columns in the final dataset, but is equivelent to the 180x88 form and both are considered tidy.

##Description of the variables in the tidy_data.txt file
tidy_data.txt is a dataset that is 15480 rows by 4 columns, and each row is the average of the measurements of a feature for a specific activity and subject.

There were 30 subjects, 6 activities, and about 88 features that were measured for each subject/activity. 
 
###Subject
  Class: int
  
  Values: 1:30
  
  Unit: N/A
  
  Naming: Numbers 1:30, corrosponding to the subject ID number
  
  These were taken from the subject\_test.txt and subject_\train.txt files in UCI HAR Dataset.
  
###Activity
  Class: Factor w/ 6 levels
  
  Values: 
  
  - WALKING
  - WALKING DOWNSTAIRS
  - WALKING UPSTAIRS
  - LAYING
  - SITTING
  - STANDING
  
  Unit: N/A
  
  These were taken from the numerical values in the y\_test.txt and y\_train.txt files in UCI HAR Dataset/test and UCI HAR Dataset/train and matched with their corrosponding values from activity\_labels.txt in the main UCI HAR Dataset folder. 
  
###Feature
  Class: Factor w/ 86 levels
  
  
  Values:
  
- tBodyAcc.mean.X
- tBodyAcc.mean.Y
- tBodyAcc.mean.Z 
- tGravityAcc.mean.X
- tGravityAcc.mean.Y
- tGravityAcc.mean.Z
- tBodyAccJerk.mean.X
- tBodyAccJerk.mean.Y
- tBodyAccJerk.mean.Z
- tBodyGyro.mean.X
- tBodyGyro.mean.Y
- tBodyGyro.mean.Z
- tBodyGyroJerk.mean.X
- tBodyGyroJerk.mean.Y
- tBodyGyroJerk.mean.Z
- tBodyAccMag.mean
- tGravityAccMag.mean
- tBodyAccJerkMag.mean
- tBodyGyroMag.mean
- tBodyGyroJerkMag.mean
- fBodyAcc.mean.X
- fBodyAcc.mean.Y
- fBodyAcc.mean.Z
- fBodyAcc.meanFreq.X
- fBodyAcc.meanFreq.Y
- fBodyAcc.meanFreq.Z
- fBodyAccJerk.mean.X
- fBodyAccJerk.mean.Y
- fBodyAccJerk.mean.Z
- fBodyAccJerk.meanFreq.X
- fBodyAccJerk.meanFreq.Y
- fBodyAccJerk.meanFreq.Z
- fBodyGyro.mean.X
- fBodyGyro.mean.Y
- fBodyGyro.mean.Z
- fBodyGyro.meanFreq.X
- fBodyGyro.meanFreq.Y
- fBodyGyro.meanFreq.Z
- fBodyAccMag.mean
- fBodyAccMag.meanFreq
- fBodyAccJerkMag.mean
- fBodyAccJerkMag.meanFreq
- fBodyGyroMag.mean
- fBodyGyroMag.meanFreq
- fBodyGyroJerkMag.mean
- fBodyGyroJerkMag.meanFreq
- angle.tBodyAccMean.gravity
- angle.tBodyAccJerkMean.gravityMean
- angle.tBodyGyroMean.gravityMean
- angle.tBodyGyroJerkMean.gravityMean
- angle.X.gravityMean
- angle.Y.gravityMean
- angle.Z.gravityMean
- tBodyAcc.std.X
- tBodyAcc.std.Y
- tBodyAcc.std.Z
- tGravityAcc.std.X
- tGravityAcc.std.Y
- tGravityAcc.std.Z
- tBodyAccJerk.std.X
- tBodyAccJerk.std.Y
- tBodyAccJerk.std.Z
- tBodyGyro.std.X
- tBodyGyro.std.Y
- tBodyGyro.std.Z
- tBodyGyroJerk.std.X
- tBodyGyroJerk.std.Y
- tBodyGyroJerk.std.Z
- tBodyAccMag.std
- tGravityAccMag.std
- tBodyAccJerkMag.std
- tBodyGyroMag.std
- tBodyGyroJerkMag.std
- fBodyAcc.std.X
- fBodyAcc.std.Y
- fBodyAcc.std.Z
- fBodyAccJerk.std.X
- fBodyAccJerk.std.Y
- fBodyAccJerk.std.Z
- fBodyGyro.std.X
- fBodyGyro.std.Y
- fBodyGyro.std.Z
- fBodyAccMag.std
- fBodyAccJerkMag.std
- fBodyGyroMag.std
- fBodyGyroJerkMag.std 
  
  
  Units: The units are on the Mean value in the row of the factor, and depend on the signal measurement. They were not well documented in the raw data so most of these are my best guesses.
  
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. There are three factors for each listed below ending in XYZ.

    - tBodyAcc-XYZ      - gravity or acceleration units g
    - tGravityAcc-XYZ   - g
    - tBodyAccJerk-XYZ  - m/s^3
    - tBodyGyro-XYZ     - radians/s
    - tBodyGyroJerk-XYZ - radians/s^2
    - tBodyAccMag       - m/s^2
    - tGravityAccMag    - m/s^2
    - tBodyAccJerkMag   - m/s^3
    - tBodyGyroMag      - radians/s
    - tBodyGyroJerkMag  - whatever the third derivative of radians/s is
    - fBodyAcc-XYZ      - g or m/s^2
    - fBodyAccJerk-XYZ  - m/s^3
    - fBodyGyro-XYZ     - radians/s
    - fBodyAccMag       - g or m/s^2
    - fBodyAccJerkMag   - the magnitude of the 3rd derivative of accelleration m/s^3?
    - fBodyGyroMag      - radians/s
    - fBodyGyroJerkMa   - whatever the third derivative of radians/s is
  
  
  Naming:
  
  A few rules were used in naming these factors. A prefix of "f" denotes a frequency domain signal and a prefix of "t" denotes a time domain signal. A suffix of "std" denotes a standard deviation, and a suffix of "mean" denotes a mean. Otherwise, I followed similar patterns to the original raw data and have included that information below. I also corrected a mistake that listed several signal measurements as "\*BodyBody\*" instead of with just one "Body".
  
The base features used were as follows:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ 
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag -note: some of these were incorrectly named "fBodyBody..", which I corrected.

Due to the unclear nature of the request, the following were kept in the datasets as they are technically means. 

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle variable:

- angle.gravityMean
- angle.tBodyAccMean
- angle.tBodyAccJerkMean
- angle.tBodyGyroMean
- angle.tBodyGyroJerkMean
  
###Mean
  Class: num
  
  Values: from roughly -1 to 1
  
  Unit: see Signal_Measurement 
  
  Naming: N/A

