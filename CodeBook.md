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

Besides, the database has 1 file with the 6 performed activities' names and 1 file with all the 561 variables names.

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
The code for this part is also in the file ```run_analysis.R``` and the function's name is ```secondTidyDataSet()```
After getting our data using the ```firstTidyDataSet()``` function we have to get the average of each variable for each activity and each subject, put the data together in a tidy dataset and export the results to a text file. This is done in the following steps
* We use the ```split()``` function on two levels to separate by subject and activity. As we had 30 subjects and 6 activities we obtain 180 groups.
* We calculate the means using the ```sapply()``` loop function with a ```colMeans()``` function inside.
* The results are not in the format we want but we 


