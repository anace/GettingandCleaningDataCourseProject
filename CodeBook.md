Code Book
==========

This code book explains the process to obtain the file ```aTidyDataSet.txt``` and describes the variables included in that file. The file contains 66 variables and 180 observacions. Every observation is the mean of all the observations on a certain subject performing a certain activity for certain variables.
## The original source
The original data comes from a study which can be found at this page http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The  study's experiment was carried out on 30 subjects performing 6 different activities: walking, walking upstairs, walking downstairs, sitting, standing and laying while they were carrying a smartphone with accelerometer and gyroscope.

The accelerometer and gyroscope signals obtained were pre-processed by applying different filters, resulting in 10 time domain series (5 three-dimensional and 5 one-dimensional) and 7 frequency domain series (3 three-dimensional and 4 one-dimensional).

For each obtained series the researchers calculated a vector of statistical features such as the mean
value, the standard deviation, the maximum and minimum values, measures of entropy, energy, skewness,
kurtosis, etc, depending on wether the series was time-domain or frequency-domain. More details about the
experiment can be found in the original database in a file called ```features_info.txt```. A list of the names of the resulting 561 variables is in a file called ```features.txt```.

## Our project
### The first tidy dataset
To get the tidy dataset that is in ```aTidyDataSet.txt``` we first need to put together another tidy dataset, as the information we need to produce our final tidy dataset is in 8 different files.

The original study separated the observations in two groups, a "train" group of 21 persons with 7352 observations and a "test" group of 9 persons with 2947 observations. Therefore in the original database there are 2 folders, one for the train group and another for the test group. In each folder there are 3 files, a file with the values of the 561 variables of the experiment (the ```X_xxxx.txt``` file), a file with the subjects' identification number (the ```subject_xxxx.txt``` file) and a file with the activity codes (the ```y_xxxx.txt``` file).

In each folder there is also a folder called InertialSignals. We don't need them for the purposes of this assignment.

Besides, the database has 1 file with the 6 performed activities' names, ```activity_labels.txt```, and 1 file with all the 561 variables names, ```features.txt```.

#### List of files
1. ```X_train.txt``` - 7352 rows and 561 columns
2. ```X_test.txt``` - 2947 rows and 561 columns
3. ```subject_train.txt``` - 7352 rows and 1 column
4. ```subject_test.txt``` - 2947 rows and 1 column
5. ```y_train.txt``` - 7352 rows and 1 column
6. ```y_test.txt``` - 2947 rows and 1 column
7. ```activity_labels.txt``` - 6 rows and 1 column
8. ```features.txt``` - 561 rows and 1 column

#### The procedure
The analysis will be performed in R. The code is in the file ```run_analysis.R``` and the function's name is ```firstTidyDataSet()```
After reading all the files with ```read.table()```, we merge the two "X" datasets obtaining a dataset with 561 variables and 10299 observations using the ```rbind()``` function. We also merge the two "subject" datasets obtaining a dataset with one column and 10299 rows and the two "y" datasets with the same result.
For the moment, we keep them separated, as we need to name the variables, select only a subset of them and replace the activity codes with the activity names, and that will be done easier this way.
* For naming the variables, we use the names we found in features.txt and the ```names()``` function.
* Following the assignment, we have to select only the variables with the mean and standard deviation values. There are 66 variables that satisfy this condition.
This is done using the dplyr package and the ```select()``` function with ```contains()```.
* The replacement of the activity codes by the activity names is done using the ```mutate()``` function of the dplyr package and the ```factor()``` function.
* Finally, we put the subject dataset, the y dataset and the X dataset together using ```data.frame()```. We obtain a dataset with one column containing the subjects' identification number, one column containing the activity names, 33 columns with mean values and 33 columns with standard deviation values, that is, a dataset with 68 variables and 10299 observations.

### The second and final tidy dataset
The code for this part is also in the file ```run_analysis.R``` and the function's name is ```secondTidyDataSet()```.
After getting our data using the ```firstTidyDataSet()``` function we have to get the average of each variable for each activity and each subject, put the data together in a tidy dataset and export the results to a text file. This is done in the following steps:
* We use the ```split()``` function on two levels to separate by subject and activity. As we had 30 subjects and 6 activities we obtain 180 groups.
* We calculate the averages using the ```sapply()``` loop function with a ```colMeans()``` function inside.
* The results are not in the format we want. We get a matrix with 66 rows and 180 columns and we would like to have a dataframe with 180 rows and 68 columns, including one with the subject identification number and one with the activity name. We do this in two steps.
  1. We transpose the matrix with the ```t()``` function and convert it to a dataframe with ```data.frame()```.
  2. We create two new columns (subject_id and activity) using the row names, the ```attr()``` function and the ```separate()``` function from the tidyr package.
* We would also like to have the results arranged by subject_id. We do this using the ```arrange()``` function from the tidyr package.
* Finally, we export the data to a text file with the ```write.table()``` function.

In the final dataset we have a row for each unique combination of a subject and an activity. In the columns we have the averages for the following variables:

(We show the number of the variable in the original dataset and in the new dataset).

original variable number|new variable number|variable name|original variable number|new variable number|variable name
:----:|:----:|:----:|:----:|:----:|:----:
-|1| ```subject_id```|-|2| ```activity```
1|3| ```tBodyAcc-mean()-X```|4|36| ```tBodyAcc-std()-X```
2|4| ```tBodyAcc-mean()-Y```|5|37| ```tBodyAcc-std()-Y```
3|5| ```tBodyAcc-mean()-Z```|6|38|```tBodyAcc-std()-Z```
41|6| ```tGravityAcc-mean()-X```|44|39| ```tGravityAcc-std()-X```
42|7| ```tGravityAcc-mean()-Y```|45|40| ```tGravityAcc-std()-Y```
43|8| ```tGravityAcc-mean()-Z```|46|41| ```tGravityAcc-std()-Z```
81|9| ```tBodyAccJerk-mean()-X```|84|42| ```tBodyAccJerk-std()-X```
82|10| ```tBodyAccJerk-mean()-Y```|85|43| ```tBodyAccJerk-std()-Y```
83|11| ```tBodyAccJerk-mean()-Z```|86|44| ```tBodyAccJerk-std()-Z```
121|12| ```tBodyGyro-mean()-X```|124|45| ```tBodyGyro-std()-X```
122|13| ```tBodyGyro-mean()-Y```|125|46| ```tBodyGyro-std()-Y```
123|14| ```tBodyGyro-mean()-Z```|126|47| ```tBodyGyro-std()-Z```
161|15| ```tBodyGyroJerk-mean()-X```|164|48| ```tBodyGyroJerk-std()-X```
162|16| ```tBodyGyroJerk-mean()-Y```|165|49| ```tBodyGyroJerk-std()-Y```
163|17| ```tBodyGyroJerk-mean()-Z```|166|50| ```tBodyGyroJerk-std()-Z```
201|18| ```tBodyAccMag-mean()```|202|51| ```tBodyAccMag-std()```
214|19| ```tGravityAccMag-mean()```|215|52| ```tGravityAccMag-std()```
227|20| ```tBodyAccJerkMag-mean()```|228|53| ```tBodyAccJerkMag-std()```
240|21| ```tBodyGyroMag-mean()```|241|54| ```tBodyGyroMag-std()```
253|22| ```tBodyGyroJerkMag-mean()```|254|55| ```tBodyGyroJerkMag-std()```
266|23| ```fBodyAcc-mean()-X```|269|56| ```fBodyAcc-std()-X```
267|24| ```fBodyAcc-mean()-Y```|270|57| ```fBodyAcc-std()-Y```
268|25| ```fBodyAcc-mean()-Z```|271|58| ```fBodyAcc-std()-Z```
345|26| ```fBodyAccJerk-mean()-X```|348|59| ```fBodyAccJerk-std()-X```
346|27| ```fBodyAccJerk-mean()-Y```|349|60| ```fBodyAccJerk-std()-Y```
347|28| ```fBodyAccJerk-mean()-Z```|350|61| ```fBodyAccJerk-std()-Z```
424|29| ```fBodyGyro-mean()-X```|427|62| ```fBodyGyro-std()-X```
425|30| ```fBodyGyro-mean()-Y```|428|63| ```fBodyGyro-std()-Y```
426|31| ```fBodyGyro-mean()-Z```|429|64| ```fBodyGyro-std()-Z```
503|32| ```fBodyAccMag-mean()```|504|65| ```fBodyAccMag-std()```
516|33| ```fBodyBodyAccJerkMag-mean()```|517|66| ```fBodyBodyAccJerkMag-std()```
529|34| ```fBodyBodyGyroMag-mean()```|530|67| ```fBodyBodyGyroMag-std()```
542|35| ```fBodyBodyGyroJerkMag-mean()```|543|68| ```fBodyBodyGyroJerkMag-std()```



