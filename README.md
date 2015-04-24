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
