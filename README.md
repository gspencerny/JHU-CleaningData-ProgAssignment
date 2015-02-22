### run_analysis.R
Version 1.0

--------------------------------------------

#### Summary
The `run_analysis.R` script performs an analysis on the Human Activity Recognition Using Smartphones Dataset[1], which should be extracted into your working directory. The results of the analysis are saved to a file called `HAR_dataset_averages_TIDY.txt` in the working directory.

The source data is comprised of two separate datasets (test & train), which include 561 variables from various accelerometer and gyroscope data, as well as a variable that identifies the test subject (1:30), and a variable that identifies the activity they performed (1:6) during the test.

`run_analysis.R` will:

* combine the `UCI HAR Dataset/test/X_test.txt` and `UCI HAR Dataset/train/X_train.txt` datasets into a single data.frame
* extract only the measurements on the mean and standard deviation for each measurement
* translate the `UCI HAR Dataset/test/y_test.txt` and `UCI HAR Dataset/train/y_train.txt` activity codes into descriptive labels using `UCI HAR Dataset/activity_labels.txt`
* use `features.txt`, which describes each measurement, to assign meaningful variable names
* combine `UCI HAR Dataset/test/subject_test.txt` and `UCI HAR Dataset/train/subject_train.txt` and add them to the main data.frame
* create a new, tidy dataset containing the average of each variable for each activity and each subject
* save the new dataset to a file called `HAR_dataset_averages_TIDY.txt` in the working directory

To read the output back into R for easy viewing, use the following code[2], which assumes `HAR_dataset_averages_TIDY.txt` is in your working directory:

```
data <- read.table("HAR_dataset_averages_TIDY.txt", header = TRUE)
View(data)
```

### References
1. The Human Activity Recognition Using Smartphones Dataset and complete descriptions are available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
2. [David Hood's thread on this project](https://class.coursera.org/getdata-011/forum/thread?thread_id=69) was invaluable in getting started, and it included the 'easy viewing' code, which I borrowed without remorse, but with great appreciation.
