### Study Design
The `run_analysis.R` script performs an analysis on the Human Activity Recognition Using Smartphones Dataset, the results of which are saved to a file called `HAR_dataset_averages_TIDY.txt` in the working directory.

The balance of this document assumes some familiarity with the source data, details of which can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### The Source Dataset
The source data consists of `test` and `train` datasets. Each dataset consists of a series of accelerometer and gyroscope measurements stored in `X_test.txt` and `X_train.txt`, the test subjects IDs that relate to each observation, stored in `subject_test.txt` and `subject_train.txt`, and the activity IDs that relate to the activity each subject performed during each observation, stored in `y_test.txt` and `y_train.txt`. 

Variable names for the measurements are stored separately in `features.txt`. Activity labels are stored in `activity_labels.txt` with corresponding IDs.

The source data was normalized and bounded within [-1,1]. Acclelerometer variable names include 'Acc' and are recorded in standard gravity units (g). Gyroscope variable names include 'Gyro' and the units are radians/second.

#### Preparing the Tidy Dataset
The analysis requires that the `test` and `train` datasets be combined. The `X_test.txt` and `X_train.txt` data was combined using `rbind()` and the `colnames()` were applied from `features.txt`.

The analysis is performed only on those source variables recording the mean and standard deviation for each measurement (detailed in the CodeBook, below). The relevant variables include 'mean' or 'std' in their name so I used `grep()` to identify the target variables, which were `subset()` into a new `data.frame`.

The `subject_test.txt` and `subject_train` data was combined using `rbind()` as before and given the column name, `subjects`. Similarly, the activity data from `y_test.txt` and `y_train.txt` was combined and given the column name `activity`.

`sapply()` was used to loop over the activity data and build a new data.frame that uses the human readable `activity_labels.txt` instead of the IDs.

The resulting datasets (`sensor_data_subset`, `merged_subject_data`, and `activities`) were combined using `cbind` into `master_data_subset` for analysis.

#### The Analysis
Our objective is to produce a new, tidy dataset that contains the average of each data variable for each subject and each activity. I used the `dplyr` package's `summarise_each()` function to handle the analysis, which is then saved to a file using `write.table()`. 

### CodeBook

Most of the variables here (3:88) have been converted to usable column names using `make.names()`. The variables follow the same convention as the source data. Relevant portions of the source data descriptions (from `features_info.txt`) are reproduced below:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> The set of variables that were estimated from these signals are: 

> mean(): Mean value

> std(): Standard deviation

**The tidy data output, saved as `HAR_dataset_averages_TIDY.txt` includes the following variables:**

```
 [1] subject              an ID (1:30) indicating the subject of the observation                             
 [2] activity             the activity the subject performed during the observation. One
                          of `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`,
                          `SITTING`, `STANDING`, or `LAYING`                       
 [3] tBodyAcc.mean...X                   
 [4] tBodyAcc.mean...Y                   
 [5] tBodyAcc.mean...Z                   
 [6] tBodyAcc.std...X                    
 [7] tBodyAcc.std...Y                    
 [8] tBodyAcc.std...Z                    
 [9] tGravityAcc.mean...X                
[10] tGravityAcc.mean...Y                
[11] tGravityAcc.mean...Z                
[12] tGravityAcc.std...X                 
[13] tGravityAcc.std...Y                 
[14] tGravityAcc.std...Z                 
[15] tBodyAccJerk.mean...X               
[16] tBodyAccJerk.mean...Y               
[17] tBodyAccJerk.mean...Z               
[18] tBodyAccJerk.std...X                
[19] tBodyAccJerk.std...Y                
[20] tBodyAccJerk.std...Z                
[21] tBodyGyro.mean...X                  
[22] tBodyGyro.mean...Y                  
[23] tBodyGyro.mean...Z                  
[24] tBodyGyro.std...X                   
[25] tBodyGyro.std...Y                   
[26] tBodyGyro.std...Z                   
[27] tBodyGyroJerk.mean...X              
[28] tBodyGyroJerk.mean...Y              
[29] tBodyGyroJerk.mean...Z              
[30] tBodyGyroJerk.std...X               
[31] tBodyGyroJerk.std...Y               
[32] tBodyGyroJerk.std...Z               
[33] tBodyAccMag.mean..                  
[34] tBodyAccMag.std..                   
[35] tGravityAccMag.mean..               
[36] tGravityAccMag.std..                
[37] tBodyAccJerkMag.mean..              
[38] tBodyAccJerkMag.std..               
[39] tBodyGyroMag.mean..                 
[40] tBodyGyroMag.std..                  
[41] tBodyGyroJerkMag.mean..             
[42] tBodyGyroJerkMag.std..              
[43] fBodyAcc.mean...X                   
[44] fBodyAcc.mean...Y                   
[45] fBodyAcc.mean...Z                   
[46] fBodyAcc.std...X                    
[47] fBodyAcc.std...Y                    
[48] fBodyAcc.std...Z                    
[49] fBodyAcc.meanFreq...X               
[50] fBodyAcc.meanFreq...Y               
[51] fBodyAcc.meanFreq...Z               
[52] fBodyAccJerk.mean...X               
[53] fBodyAccJerk.mean...Y               
[54] fBodyAccJerk.mean...Z               
[55] fBodyAccJerk.std...X                
[56] fBodyAccJerk.std...Y                
[57] fBodyAccJerk.std...Z                
[58] fBodyAccJerk.meanFreq...X           
[59] fBodyAccJerk.meanFreq...Y           
[60] fBodyAccJerk.meanFreq...Z           
[61] fBodyGyro.mean...X                  
[62] fBodyGyro.mean...Y                  
[63] fBodyGyro.mean...Z                  
[64] fBodyGyro.std...X                   
[65] fBodyGyro.std...Y                   
[66] fBodyGyro.std...Z                   
[67] fBodyGyro.meanFreq...X              
[68] fBodyGyro.meanFreq...Y              
[69] fBodyGyro.meanFreq...Z              
[70] fBodyAccMag.mean..                  
[71] fBodyAccMag.std..                   
[72] fBodyAccMag.meanFreq..              
[73] fBodyBodyAccJerkMag.mean..          
[74] fBodyBodyAccJerkMag.std..           
[75] fBodyBodyAccJerkMag.meanFreq..      
[76] fBodyBodyGyroMag.mean..             
[77] fBodyBodyGyroMag.std..              
[78] fBodyBodyGyroMag.meanFreq..         
[79] fBodyBodyGyroJerkMag.mean..         
[80] fBodyBodyGyroJerkMag.std..          
[81] fBodyBodyGyroJerkMag.meanFreq..     
[82] angle.tBodyAccMean.gravity.         
[83] angle.tBodyAccJerkMean..gravityMean.
[84] angle.tBodyGyroMean.gravityMean.    
[85] angle.tBodyGyroJerkMean.gravityMean.
[86] angle.X.gravityMean.                
[87] angle.Y.gravityMean.                
[88] angle.Z.gravityMean.
```
