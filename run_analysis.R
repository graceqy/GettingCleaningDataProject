# Getting and Cleaning data 
# Project

# Download data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Unzip and save the files in the directory "../Project/UCI_HAR_Dataset"

# !! I didn't follow the sequence of step 1-5. 
# !! I merged the whole data set together (Step 1) and then followed the Steps of 4-2-5-3.

# set the working directory:
setwd("../Project/")

library("reshape2")

# Step1: merge training and test data sets to create one data set:

# import train and test data:
x_test <- read.table("/UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("/UCI_HAR_Dataset/test/y_test.txt")
subject_test <- read.table("/UCI_HAR_Dataset/test/subject_test.txt")
x_train <- read.table("/UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("/UCI_HAR_Dataset/train/y_train.txt")
subject_train <- read.table("/UCI_HAR_Dataset/train/subject_train.txt")
# dim(x_test)
# dim(y_test)
# dim(x_train)
# dim(y_train)  
# x_test and y_test have the same number of rows: 2947
# x_train and y_train have the same number of rows: 7352

# merge test and train data sets: 
test.xys <- cbind(x_test,subject_test,y_test)  # merge test files by column
train.xys <- cbind(x_train,subject_train,y_train)  # merge train files by column
# dim(test.xys)    # 2947 rows by 563 column
# dim(train.xys )  # 7352 rows by 563 column
merge <- rbind(test.xys,train.xys)   # merge test and train files by rows
# dim(merge)   # the merged file have 10299 rows and 563 columns

# Step 4: Label the data:
# import feasure file:
feature <- read.table("/UCI_HAR_Dataset/features.txt",row.names=1)

# transform to matrix:
feature.mx <- as.matrix(feature)

# add the name of the last 2 columns (the column from y_ files and from the subject files)
header <- c(feature.mx,"Subject","Activity")

# add the generated file as header of the merged file:
names(merge) <- header

# Step 2: extract measurements on means and sds:

#select only mean and std headers
mean_sd_column <- grep("mean\\(\\)|std\\(\\)", header)
# mean_sd_column <- grep("mean|std", header)  # this includes *meanFreq() variables. 
# add the last two columns of subject and activity:
mean_sd_column <- c(mean_sd_column,562,563)

# Extract the columns:
clean.col <- merge[,mean_sd_column]
dim(clean.col)

# Step 5:tidy data set with the average of each variable for each activity and each subject:

#aggregate by subjectid and activity
agg <- aggregate(. ~ Subject + Activity, data=clean.col, FUN = mean,fixed=TRUE)
dim(agg)

# Step 3: change the Activity variable to be more readable:
activity_lab <- read.table("/UCI_HAR_Dataset/activity_labels.txt")
agg$Activity[agg$Activity == 1] <- as.matrix(activity_lab[1,2])
agg$Activity[agg$Activity == 2] <- as.matrix(activity_lab[2,2])
agg$Activity[agg$Activity == 3] <- as.matrix(activity_lab[3,2])
agg$Activity[agg$Activity == 4] <- as.matrix(activity_lab[4,2])
agg$Activity[agg$Activity == 5] <- as.matrix(activity_lab[5,2])
agg$Activity[agg$Activity == 6] <- as.matrix(activity_lab[6,2])

# after aggregation, the subject and activity columns shifted to the front.
# put them back:
Subject <- agg$Subject    # save Subject variable to Subject vector
Activity <- agg$Activity  # save Activity variable to Activity vector
agg$Activity <- NULL      # delete the Activity column that was in the front
agg$Subject <- NULL       # delete the Subject column that was in the front
agg1 <- cbind(agg,Subject,Activity)   # append the two saved vector to the end of the data set

# export the tidy data set "agg1":
write.table(agg1,"/UCI_HAR_Dataset/HAR_tidy_data_set.txt",sep="\t",quote=F,row.names=F)

