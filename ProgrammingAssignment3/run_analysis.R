# Course Project script

# Download the dataset, if you don't have it already.
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, "getdata_projectfiles_FUCI HAR Dataset.zip", "curl")
# Then unzip it in the same directory, resulting in a UCI HAR Dataset subdirectory.


## Merge the training and test sets to create one data set.
# Load training data
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
testData  <- read.table("UCI HAR Dataset/test/X_test.txt")
# Add the test data to the training data
DS <- rbind(trainData, testData)
# Save memory space by removing partial sets
remove(trainData)
remove(testData)


## Extract only the mean and standard deviation for each measurement.
# The features.txt file holds the 561 labels for the columns in X_test/train.txt
#   avoiding having them turn into factors.
featureNames <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
# Pick out the variables with "mean()" in their names
meanCols <- grep("mean\\(\\)", featureNames[[2]])
# Pick out the variables with "std()" in their names
stdCols  <- grep("std\\(\\)", featureNames[[2]])
# Combine to get the list of fields to extract
allCols <- c(meanCols, stdCols)
# Grab all the desired columns
result <- DS[,allCols]
# Alternative method:
#result <- DS[, grepl("(mean\\(\\))|std\\(\\)", featureNames[[2]])]


## Appropriately label the data set with descriptive variable names.
colnames(result) <- featureNames[allCols, 2]
# Note: this step is earlier than specified in the project description
#   because putting the labels on now allows the next step
#   to assign its label correctly.


## Name the activities using descriptive activity names.
# Read the activity types for the training set.
# y_test/train.txt holds the 2947/7352 row labels, as interpreted according to activity_labels.txt
lines <- readLines("UCI HAR Dataset/train/y_train.txt")
# Read the activity names, avoiding having them turn into factors.
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", as.is = TRUE)
# Set up a character array to hold the names.
activities <- c()
for (i in seq_len(length(lines))) {
    # Dereference the activity code to get the name, and add to the list.
    activities <- append(activities, activityNames[lines[i], 2])
}
# Repeat for test set
lines <- readLines("UCI HAR Dataset/test/y_test.txt")
for (i in seq_len(length(lines))) {
    activities <- append(activities, activityNames[lines[i], 2])
}
# Can't use these as row names due to duplicates, so just add as another column.
result <- cbind(activities, result)


## Create a second, independent tidy data set
##   with the average of each variable for each activity and each subject.

# Add the subjects as another column.
# subject_test/train.txt holds the identity of the person under test for the 2947/7352 rows.
trainSubj <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSubj  <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Add the sets together in the same way as for the main data.
subject <- rbind(trainSubj, testSubj)[[1]]
result <- cbind(subject, result)

# Now we have the full data set with attached activity names and subject.
# Group by activity and subject and get the average for each of the other vars.
library(reshape2)
meltResult <- melt(result, id.vars = c("activities", "subject"))
output <- dcast(meltResult, activities + subject ~ variable, mean)
# output has 180 observations (30 subjects x 6 activities)
#   and 68 variables (activity, subject, 33 mean, 33 std)

# Write out to a file, so it can be uploaded.
write.table(output, file="project-tidy-output.txt", row.names = FALSE)
