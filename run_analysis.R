## import necessary libraries 
library(dplyr)
library(tidyr)
## Read training and test data sets 
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
## Combine the data sets into one
dat <- rbind(train, test)
## Read the subjects and combine into one
train_subjects <- read.table("train/subject_train.txt")
test_subjects <- read.table("test/subject_test.txt")
subjects <- rbind(train_subjects, test_subjects)
names(subjects) <- "subject"
## Read the features text file and name the columns
features <- read.table("features.txt", stringsAsFactors = FALSE)
names(features) <- c("colNumber", "feature")
## define a helper function to retrieve string from right side
substrRight <- function(x, n){
    substr(x, nchar(x)-n+1, nchar(x))
}
## filter the data set to keep only mean and standard deviation 
## for each measurement
cols <- filter(features, substrRight(feature, 7) == "-mean()" 
                       | substrRight(feature, 6) == "-std()")
dat <- dat[cols$colNumber]
## name the dataset using the info provided by feature.txt
names(dat) <- substr(cols$feature, 1, nchar(cols$feature) -2)
## read the labels for train and test data sets, and combine them with dat
train_labels <- read.table("train/y_train.txt")
test_labels <- read.table("test/y_test.txt")
labels <- rbind(train_labels, test_labels)
names(labels) <- "label"
## Convert the labels to meaningful activities
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("label", "activity")
## define a helper function to map labels to activities
map_activity <- function(l) {
    return(activity_labels[l,][2])
}
## map activities to labels and combine with dat 
labels$activity = map_activity(labels$label)
dat <- cbind(dat, labels$activity, subjects)
## Create the final tidy data set
finaldat <- dat %>% 
            group_by(activity, subject) %>%
            summarise_each(funs(mean))
write.table(finaldat, file = "final.txt", row.names = FALSE)