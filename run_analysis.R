

################################################################
## MERGE TRAIN/TEST DATA SETS INTO ONE SET, ADD VARIABLE NAMES
## AS COLNAMES, INTEGRATE SUBJECT DATA AND ACTIVITY DATA WITH
## DESCRIPTIVE LABELS. THEN, SUBSET TO OUTPUT A NEW DATA.FRAME 
## CONTAINING ONLY THE MEAN/STDDEV VARIABLES.
################################################################

  #load libraries
  library(dplyr)
  library(data.table)

  # load the sensor data (X_test, X_train) and merge into one data.frame
  test_sensor_data <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
  train_sensor_data <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
  merged_sensor_data <- rbind(test_sensor_data, train_sensor_data)
  
  # clean up the separate test/train sensor data from memory
  rm(test_sensor_data, train_sensor_data)

  # load the variable names ('features') for use as
  # column names in the merged_sensor_data
  variable_labels <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
  colnames(merged_sensor_data) <- make.names(variable_labels[[2]])
  
  # find & extract just the mean & std dev variables into a new data.frame
  goodcols <- grep("\\b[-()A-Za-z\\,]*([Mm]ean|std)[-A-Za-z()\\,]*", colnames(merged_sensor_data))
  sensor_data_subset <- subset(merged_sensor_data, select = goodcols)

  # load the subject data, create clean data.frame of all subjects
  test_subject_data <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
  train_subject_data <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
  merged_subject_data <- rbind(test_subject_data, train_subject_data)
  colnames(merged_subject_data) <- "subject"
  
  # clean up separate test/train subject data from memory
  rm(test_subject_data, train_subject_data)
  
  # load the activity data, create clean data.frame of all activities
  test_activity <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
  train_activity <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
  merged_activity <- rbind(test_activity, train_activity)
  
  # load the activity names
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
  
  # change the activity codes to human readable names
  my_labels <- sapply(merged_activity[[1]], function(n) activity_labels[[n,2]])
  activities <- data.frame("activity" = character(10299), stringsAsFactors = FALSE)
  for(i in 1:nrow(merged_activity)){
    activities[i, ] <- my_labels[[i]]
  }
  colnames(activities) <- "activity"
  
  # build master dataset
  master_data_subset <- cbind(merged_subject_data, activities, sensor_data_subset)

  # clean up memory - dump temp data
  rm(activity_labels, merged_activity, merged_subject_data, activities, test_activity, train_activity, 
     variable_labels, merged_sensor_data, i, my_labels, goodcols, sensor_data_subset)

  # create a new data set (data.frame) that shows the mean for each
  # subject & activity
  avg_data_subset <- master_data_subset %>% group_by(subject, activity) %>% summarise_each(funs(mean), 3:88)

  # write avg_data_subset to file
  write.table(avg_data_subset, file="HAR_dataset_averages_TIDY.txt", sep="\t", row.names = FALSE)
