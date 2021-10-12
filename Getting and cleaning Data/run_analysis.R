# Run_Analysis Script

library(stringr)
library(dplyr)
library(plyr)
library(knitr)

#Download the data
if (!(file.exists("data")))
{ dir.create("data")}
if (!(file.exists("data/Dataset.zip")))
{ download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile ="data/Dataset.zip", method="curl")}
if (!(file.exists("data/UCI HAR Dataset")))
{unzip("data/Dataset.zip",exdir="data")}

#1 Merges the training and the test sets to create one data set.
#Read the Subject files
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")
sub_bind <- rbind(subject_train, subject_test)

#Read the Activity files
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
y_bind <- rbind(y_train, y_test)

#Read Features files
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
X_bind <- rbind(X_train, X_test)

features <- read.table("data/UCI HAR Dataset/features.txt",header = FALSE, sep = "")

names(sub_bind) <- c("subject")
names(y_bind) <- c("activity")
names(X_bind) <- features$V2
dataset <- cbind(sub_bind, X_bind, y_bind)

#2 Extracts only the measurements on the mean and standard deviation for each measurement.
tidy_data <- dataset[, grep(pattern = "-mean\\(\\)|-std\\(\\)", colnames(dataset))]
new_data <- cbind(sub_bind, y_bind, tidy_data)

#3 Uses descriptive activity names to name the activities in the data set
new_data$activity[new_data$activity == "1"] <- "WALKING"
new_data$activity[new_data$activity == "2"] <- "WALKING_UPSTAIRS"
new_data$activity[new_data$activity == "3"] <- "WALKING_DOWNSTAIRS"
new_data$activity[new_data$activity == "4"] <- "SITTING"
new_data$activity[new_data$activity == "5"] <- "STANDING"
new_data$activity[new_data$activity == "6"] <- "LAYING"

#4 Appropriately labels the data set with descriptive variable names.
names(new_data) <- str_replace_all(names(new_data), c("^t"="time", "^f"="frequency", "Acc"="Accelerometer", "Gyro"="Gyroscope", "Mag"="Magnitude", "BodyBody"="Body"))

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
data_group <- new_data %>% group_by(subject, activity) %>% dplyr::summarise(across(everything(), list(mean)))
data_group <- data_group[order(data_group$subject, data_group$activity),]
write.table(data_group, file = "tidydata.txt", row.names = FALSE)

#6 Produce a codebook
knit2html("./run_analysis.Rmd");
