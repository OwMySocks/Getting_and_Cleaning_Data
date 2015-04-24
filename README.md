---
title: "README - Getting and Cleaning Data Course Project"
author: "Rebecca Everett"
date: "4/23/2015"
class: "Getting and Cleaning Data"
---


## What is in this repository

- run\_analysis.R - R script for running the analysis and creating the tidy data
- Codebook.md - codebook for all variables and explanation of the anaysis
- This README
- tidy\_data.txt - the resulting tidy data set
- UCI HAR Dataset - raw dataset this analysis is dependent on

## Instructions

While the dataset is included in this repository, only run\_analysis.R is needed to run the analysis, as it will download the data if nessicary. Run the script at an R prompt, either in RStudio or R in a terminal or the windows application.

### Required packages
The script will load a few packages, but will not install them. Make sure to install plyr, dplyr, and reshape2 using install.packages() before running the script.

## Basic Functionality

The steps taken to create the tidy data are as follows:

- The raw data from UCI HAR Dataset were read into R
- Names of the columns in X\_train.txt and X\_test.txt were changed to match features.txt 
- subject\_test, X\_test, and y\_test were collated together to form a large table, the first two columns were changed to descriptive titles, and the same was done for the anagolous train files
- The train and test files from the last step were merged 
- The feature columns that were not means or standard deviations were removed. I retained all features that had the word "mean" in them, as the wording of the project prompt was vague enough to create doubt, and in general practice I would rather err on having too much data when the request is unclear.
- The activity labels were brought in and replaced the numeric activity ID
- The remaining signal measurement (feature) names were replaced by slightly more readable names- the system I used is explained below in the "Signal Measurement" variable description 
- The averages of each signal measurement for each activity and subject were found 
- The resulting wide form 180x88 data table was melted into a narrow form of the same information by creating a column for "Signal_Measurement" that uses the signal measurement names as a factor with a seperate column for the value of each averaged signal measurement/activity/subject. This was done to cut down on the number of columns in the final dataset, but is equivelent to the 180x88 form and both are considered tidy.

More information on the variables and some details are found in Codebook.md.
