GettingandCleaningDataCourseProject
===================================
The run_analysis.R file can be used to create two tidy datasets:

1. The first dataset is created by sourcing the file and running the first function.
	source("run_analysis.R")
	firstdataset <- firstTidyDataSet()
	
	This dataset contains 10299 rows and 68 columns. 

2. The second data set contains the means of 66 variables by subject and activity and it is created running
	source("run_analysis.R")
	tidyDataset <- secondTidyDataSet()
	
	This dataset contains 180 rows and 66 columns.