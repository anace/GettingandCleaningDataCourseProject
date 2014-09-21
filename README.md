Getting and Cleaning Data Course Project
========================================
In this project we create two tidy datasets from a number of data files. We assume these data files are in the working directory and that the working directory is the UCI HAR Dataset folder. The ```run_analysis.R``` file is also in the same directory. 

1. The first dataset is created by sourcing the file and running the ```firstTidyDataSet()``` function like in the following code

    ```
    source("run_analysis.R")
    firstdataset <- firstTidyDataSet()
    ```	
This dataset contains 10299 rows and 68 columns, i.e. 33 columns with mean values, 33 columns with standard deviation values, a column with the subjects identification number and a column with the name of the activity performed.

	The ```firstTidyDataSet()``` function reads the original datasets using the ```read.table()``` function, merges the training and the test sets to create one dataset using the ```rbind()``` function, assigns descriptive activity names to the activities performed and descriptive variable names to the variables using the ```names()``` function, extracts only the measurements on the mean and standard deviation for each measurement using the ```select()``` function of the dplyr package, and finally creates the dataset that will be used in the last step of the assignment.

2. The second dataset contains the averages of the 33 mean values and the 33 standard deviation values by subject and activity and it is created by running

   ```
    source("run_analysis.R")
    tidyDataSet <- secondTidyDataSet()
    ```
	
	This dataset contains 180 rows and 68 columns.

	The ```secondTidyDataSet()``` function starts with ```data ```, a dataset created by the ```firstTidyDataSet()``` function, splits the data by subject and activity using the ```split()``` function and calculates the averages of all the variables for each subject/activity group by means of the ```sapply()``` loop function.

	The ```secondTidyDataSet()``` function also creates a text file with the data called ```aTidyDataSet.txt``` using the ```write.table()``` function. The text file will be saved in the working directory. To read this file in R you can run
	
	```newdataset<-read.table("aTidyDataSet.txt", colClasses="character", header=TRUE)```
	
More information is available in the CodeBook and in the comments of ```run_analysis.R```