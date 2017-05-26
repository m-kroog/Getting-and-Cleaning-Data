library(dplyr)
library(tidyr)

x_test <- read.table("c:/coursera/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("c:/coursera/UCI HAR Dataset/train/X_train.txt")
features <- read.table("c:/coursera/UCI HAR Dataset/features.txt")
subject_test <- read.table("c:/coursera/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("c:/coursera/UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("c:/coursera/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("c:/coursera/UCI HAR Dataset/train/y_train.txt")

subject <- rbind(subject_test, subject_train)
colnames(subject) <- c("subjectId")       
 
features_2 <- make.names(as.vector(unlist(features[[2]])), unique = TRUE)
features_2 <- gsub("\\.", "", features_2)

x_test_train <- rbind(x_test, x_train)
colnames(x_test_train) <- features_2

x_test_train_select <- select(x_test_train, matches("[Mm]ean|[Ss]td"))

y_test_train <- as.vector(unlist(rbind(y_test, y_train)))

activityType <- gsub(1, "WALKING", y_test_train)
activityType <- gsub(2, "WALKING_UPSTAIRS", activityType)
activityType <- gsub(3, "WALKING_DOWNSTAIRS", activityType)
activityType <- gsub(4, "SITTING", activityType)
activityType <- gsub(5, "STANDING", activityType)
activityType <- gsub(6, "LAYING", activityType)

xy_test_train <- cbind(x_test_train_select, activityType, subject)

walking <- filter(xy_test_train, activityType == "WALKING") %>% select(-activityType)
walking_up <- filter(xy_test_train, activityType == "WALKING_UPSTAIRS") %>% select(-activityType)
walking_down <- filter(xy_test_train, activityType == "WALKING_DOWNSTAIRS") %>% select(-activityType)
sitting <- filter(xy_test_train, activityType == "SITTING") %>% select(-activityType)
standing <- filter(xy_test_train, activityType == "STANDING") %>% select(-activityType)
laying <- filter(xy_test_train, activityType == "LAYING") %>% select(-activityType)

walkingMeans <- walking %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans
walkingUpMeans <- walking_up %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans
walkingDownMeans <- walking_down %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans
sittingMeans <- sitting %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans
standingMeans <- standing %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans
layingMeans <- laying %>% group_by(subjectId) %>% summarize_each(funs(mean)) %>% select(-subjectId) %>% rowMeans

tidydf <- data.frame(walkingMeans, walkingUpMeans, walkingDownMeans, sittingMeans, standingMeans, layingMeans)
colnames(tidydf) <- c("WALKING", "WALKINGUP", "WALKINGDOWN", "SITTING", "STANDING", "LAYING")

tidydf_gathered <- gather(tidydf)

subject_id_rep <- rep(seq.int(1:30), times = 6)
tidydf_all <- cbind(subject_id_rep, tidydf_gathered)
colnames(tidydf_all) <- c("subjectId", "activityType", "mean")
