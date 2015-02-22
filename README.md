### run_analysis.R
Version 1.0

--------------------------------------------

#### Summary
The `run_analysis.R` script performs an analysis on the Human Activity Recognition Using Smartphones Dataset[1], which should be extracted into your working directory. The results of the analysis are saved to a file called `HAR_dataset_averages_TIDY.txt` in the working directory.

The source data is comprised of two separate datasets (test & train), which include 561 variables from various accelerometer and gyroscope data, as well as a variable that identifies the test subject (1:30), and a variable that identifies the activity they performed (1:6) during the test.

`run_analysis.R` will:

*  combine the `UCI HAR Dataset/test/X_test.txt` and `UCI HAR Dataset/train/X_train.txt` datasets into a single data.frame
* extract only the measurements on the mean and standard deviation for each measurement
* translate the `UCI HAR Dataset/test/y_test.txt` and `UCI HAR Dataset/train/y_train.txt` activity codes into descriptive labels using `UCI HAR Dataset/activity_labels.txt`
* use `features.txt`, which describes each measurement, to assign meaningful variable names
 







### References
1. The Human Activity Recognition Using Smartphones Dataset and complete descriptions are available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones