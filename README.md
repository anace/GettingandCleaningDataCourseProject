Getting and Cleaning Data Course Project
========================================
The run_analysis.R file can be used to create two tidy datasets from a number of data files. We assume these data files are in the working directory (the same directory where run_analysis.R is) and that the working directory is the UCI HAR Dataset folder.

1. The first dataset is created by sourcing the file and running the first function. This can be done by running

    ```source("run_analysis.R")
    firstdataset <- firstTidyDataSet()
    ```	
This dataset contains 10299 rows and 68 columns, i.e. 33 means, 33 stds, a subject column and an activity column.

2. The second data set contains the means of the 33 means and the 33 stds by subject and activity and it is created by running

   ```source("run_analysis.R")
    tidyDataSet <- secondTidyDataSet()```
	
This dataset contains 180 rows and 66 columns.
	
The secondTidyDataSet() function also creates a text file with the data called "aTidyDataSet.txt". To read this file in R you can run
	
	newdataset<-read.table("aTidyDataSet.txt", colClasses="character", header=TRUE)