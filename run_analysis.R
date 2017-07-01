# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if(!file.exists("./data")){dir.create("./data")}
urll<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#destination zip

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/dataweek4.zip",method="curl")

#unzip file
unzip("./data/dataweek4.zip",list = FALSE, exdir = "./data")

library(dplyr)

data_path = "./data/UCI HAR Dataset"

# file paths
        train_data_file = "/train/X_train.txt"
        test_data_file = "/test/X_test.txt"
        train_label_file = "/train/y_train.txt"
        test_label_file = "/test/y_test.txt"
        features_file = "/features.txt"
        activilty_label_file = "/activity_labels.txt"
        train_subject_file = "/train/subject_train.txt"
        test_subject_file = "/test/subject_test.txt"


# This script depends on utility script which has all the helper functions
source("./run_analysis_functions.R")


# load data data from the files
        # features data
        total_data = join_data_files(data_path, train_data_file,test_data_file)
        #labels data
        total_labels = join_data_files(data_path, train_label_file,test_label_file)
        #subjects data
        total_subjects = join_data_files(data_path,train_subject_file,test_subject_file)
        #activity text labels
        activity_labels = get_activity_names(data_path,activilty_label_file)


# Get the means and sdt columns only
cols = get_feature_cols_means_std(data_path,features_file)
cols_to_keep= cols[[1]]
total_data = total_data %>% select(cols_to_keep)

# name the labels with names
total_labels = activity_labels[match(total_labels[,1],activity_labels[,1]),2]

# Combine observations and labels
total_set = cbind(total_data,total_labels,total_subjects)

# Give descriptive names to variables
cols_names = cols[[2]]
names(total_set) =c(cols_names,"activitylabel","subject")

averages = total_set %>% group_by(activitylabel,subject) %>% summarize_all(funs(mean))

# write.table(averages,"averages.txt", row.name=FALSE)
