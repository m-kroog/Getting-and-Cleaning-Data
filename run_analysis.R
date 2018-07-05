library(reshape2)
library(dplyr)

## read all data
x_test <- read.table("~/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("~/UCI HAR Dataset/train/X_train.txt")
features <- read.table("~/UCI HAR Dataset/features.txt")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt")
act_label <- read.table("~/UCI HAR Dataset/activity_labels.txt")

## tidy feature names
features_2 <- make.names(as.vector(unlist(features[[2]])), unique = TRUE)
features_2 <- gsub("\\.", "", features_2)
features_2 <- gsub("mean", "Mean", features_2)
features_2 <- gsub("std", "Std", features_2)

## combine data sets
subject <- rbind(subject_test, subject_train)
colnames(subject) <- c("subjectId")   
x_test_train <- rbind(x_test, x_train)
colnames(x_test_train) <- features_2

## subset only Mean and Std data
x_test_train_select <- select(x_test_train, matches("Mean|Std"))

## change y data into a vector
y_test_train <- as.vector(unlist(rbind(y_test, y_train)))

## assign activity levels and labels to y data and combine with x data
activityType <- factor(y_test_train, levels = act_label[,1], labels = act_label[,2])
xy_test_train <- cbind(subject, activityType, x_test_train_select)

## change data frame format and calculate mean
xy_test_train <- melt(xy_test_train, id = c("subjectId", "activityType"))
tidydf <- dcast(xy_test_train, subjectId + activityType ~ variable, mean)

## write tidy data frame to a txt file
write.table(tidydf, "C:/Users/miguelito/Documents/week4assign.txt", row.names = FALSE)
