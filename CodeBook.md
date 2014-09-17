Code Book
==========

This code book explains the process to obtain the file aTidyDataSet.txt and describes the variables included in that file. The file contains 66 variables with 180 observacions each. Every observation is the mean of all the observations on a certain subject performing a certain activity for certain variables.
## The original source
The original data comes from a study which can be found at this page http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The  study's experiment was carried out on 30 subjects performing 6 different activities: walking, walking upstairs, walking downstairs, sitting, standing and laying while they were carrying a smartphone with accelerometer and gyroscope.

The accelerometer and gyroscope signals obtained were pre-processed by applying different filters, resulting in 10 time domain series (5 three-dimensional and 5 one-dimensional) and 7 frequency domain series (3 three-dimensional and 4 one-dimensional).
 
For each obtained series the researchers calculated a vector of statistical features such as the mean
value, the standard deviation, the maximum and minimum values, measures of entropy, energy, skewness,
kurtosis, etc, depending on wether the series was time-domain or frequency-domain. More details about the
experiment can be found in the original database in a file called features_info.txt and a list with the names of the resulting 561 variables in a file called features.txt.
## Our project
### The first tidy data set
To get the tidy dataset that is in aTidyDataSet.txt we first need to put together another tidy dataset, as the information we need to produce our final tidy dataset can be found in 8 different files. The original study separated the observations in two groups, a "train" group of 21 persons with 7352 observations and a "test" group of 9 persons with 2947 observations. Therefore in the original database there are 2 folders, one for the train group and another for the test group. In each folder there are 3 files, a file with the values of the 561 variables of the experiment, a file with the subjects' identification number and a file with the activity codes. Besides, there is 1 file with the 6 performed activities' names and 1 file with all the 561 variables names.
##### List of files
1. X_train.txt - 7352 rows and 561 columns
2. X_test.txt - 2947 rows and 561 columns
3. subject_train.txt - 7352 rows and 1 column
4. subject_test.txt - 2947 rows and 1 column
5. y_train.txt - 7352 rows and 1 column
6. y_test.txt - 2947 rows and 1 column
7. activity_labels.txt - 6 rows and 1 column
8. features.txt - 561 rows and 1 column

 For the purposes of this project we need to merge the two groups together obtaining a dataset with 561 variables and 10299 observations. Furthermore, we need to name the variables and replace the activity codes with the activity names.. As said before, the original database contains 561 variables, but for the purposes of this project we selected only 66 of them, those with the mean and the standard deviation values.  


