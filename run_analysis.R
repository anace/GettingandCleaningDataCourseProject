## The tasks of the assignment are:
## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## (This step will be done in two sub steps, a. and b., see below).
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each
##    variable for each activity and each subject.
## The steps will be done in this order: 1a, 4, 2, 3, 1b and finally 5. It seems more logical first to
## give the variables descriptive names and then select the variables we need using these descriptive
## variable names.

firstTidyDataSet <- function(){
	library(dplyr)
	library(tidyr)
	# We need to read the following datasets. We assume they are in the working directory and that the
	# working directory is the UCI HAR Dataset folder. The train datasets have 7352 observations while the
	# test datasets have 2497 observations. We find descriptive variable names in the features.txt file
	# and descriptive activity names in the activity_labels.txt file.
	# The following file has the 561 variable names.
	features <- read.table("features.txt")
	# We prepare the features dataframe in order to be able to use the variable names for naming the
	# variables in X_data. We only need the column with the variable names and we need to transpose it,
	# so this column with 561 rows containing the variable names becomes a row with 561 columns.
	features <-	select(features, V2)
	names(features) <- "variable_name"
	features <- t(features)
	# The following file has the activity names.
	activity_labels <- read.table("activity_labels.txt")
	# We clean the activity_labels dataframe selecting only the column with the activity names and giving
	# it a descriptive name.
	activity_labels <- select(activity_labels, V2)
	names(activity_labels) <- "activity"
	# The following two files have the observed values for the 561 variables.
	X_train <- read.table("./train/X_train.txt") 
	X_test <- read.table("./test/X_test.txt")
	# The following two files have the id of the subject (person) of each observation. 
	subject_train <- read.table("./train/subject_train.txt") 
	subject_test <- read.table("./test/subject_test.txt")
	# The following two files have the activity code of each observation.
	y_train <- read.table("./train/y_train.txt")
	y_test <- read.table("./test/y_test.txt")
	# 1a. We put the datasets together. We get 3 dataframes with 10299 observations and 561, 1 and 1
	#     columns, respectively.
	X_data <- rbind(X_train, X_test)
	subject_data <-rbind(subject_train, subject_test)
	y_data <- rbind(y_train, y_test)
	# 4. We give the variables in X_data the descriptive variable names we found in features.txt.
	#    We also give descriptive names to subject_data and y_data.
	names(X_data) <- features
	names(subject_data) <- "subject_id"
	names(y_data) <- "activity"
	# 2. We extract the measurements on the mean and standard deviation for each measurement. We get
	#    66 variables.
	X_data <- select(X_data, contains("mean()"), contains("std()"), -contains("meanFreq()"), -contains("angle"))
	# 3. We use the descriptive activity names we found in activity_labels.txt to name the activities
	#    in the data set.
	y_data <- mutate(y_data, activity = factor(y_data$activity, labels = activity_labels$activity))
	# 1b. We put the three datasets together to get our final tidy dataset.
	tidydata<- data.frame(subject_data, y_data, X_data)
	return(tidydata)	
}

secondTidyDataSet <- function(){
	# We create a new dataset using the firstTidyDataSet() function that is above.
	data <- firstTidyDataSet()
	# We split the data by subject and activity and we get 180 groups (30 subjects x 6 activities).
	s <- split(data, list(data$subject, data$activity))
	# We calculate the 66 means for the 180 groups and obtain a 66 x 180 matrix.
	means <- sapply(s, function(x) colMeans(x[, 3:68]))
	# We transpose the matrix and converts it to a dataframe.
	means <- data.frame(t(means))
	# We add two new columns: subject_id and activity using the row.names attribute.
	means <- data.frame(subject_activity = attr(means, "row.names"), means)
	means <- separate(means, subject_activity, c("subject_id", "activity"), sep = "[.]")
	# We arrange by subject_id.
	class(means$subject_id) <- "integer"
	tidydata2 <- arrange(means, subject_id)
	# We export the data to a file called "aTidyDataSet.txt" that will be created in the working directory.
	write.table(tidydata2, file = "aTidyDataSet.txt", row.names = FALSE)
	return(tidydata2)
}


