library("reshape2")
library("dplyr")

# 0. Preliminary steps: Get and read the data.

dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
lclZip <- file.path("data", "UCI-HAR-dataset.zip")
dataDir <- file.path("data", "UCI HAR Dataset")
# Create a data directory if it doesn't exist
if(!file.exists("data")) {
  dir.create("data")
}
# Download the zip file if it isn't in the data directory
if(!file.exists(lclZip)) {
  download.file(dataUrl, lclZip, method = "curl")
}
# Unzip the data files
unzip(lclZip, exdir = "data")
# Read the training and testing data files.
x_train <- read.table(file.path(dataDir, "train", "X_train.txt"))
y_train <- read.table(file.path(dataDir, "train", "y_train.txt"))
subject_train <- read.table(file.path(dataDir, "train", "subject_train.txt"))
x_test <- read.table(file.path(dataDir, "test", "X_test.txt"))
y_test <- read.table(file.path(dataDir, "test", "y_test.txt"))
subject_test <- read.table(file.path(dataDir, "test", "subject_test.txt"))

# 1. Merge the training and the test sets to create one data set.
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
tidy_data_full <- rbind(train_data, test_data)

# 2. Extract only the measurements on the mean and standard deviation for each 
# measurement.
features <- read.table(file.path(dataDir, "features.txt"))
# Search feature labels for mean and std; shift column value by 2 because 
# features start in column 3.
feature_cols <- grep(".*mean|std.*", features$V2) + 2
# Subset the data to keep subject, activity and the required features.
tidy_data_full <- tidy_data_full[, c(1, 2, feature_cols)]

# 3. Use descriptive activity names to name the activities in the data set.
activity_labels <- read.table(file.path(dataDir, "activity_labels.txt"))
# Convert activity codes to a factor.
tidy_data_full$V1.1 <- as.factor(tidy_data_full$V1.1)
# Assign activity labels to name the factor levels
levels(tidy_data_full$V1.1) <- activity_labels$V2

# 4. Appropriately label the data set with descriptive variable names.
# Get the feature names for all mean and std variables in the dataset.
feature_names <- grep(".*mean|std.*", features$V2, value = TRUE)
# Set the variable names.
names(tidy_data_full) <- c("Subject", "Activity", feature_names)
# Reshape to a long, tidy dataset.
tidy_data_long <- melt(tidy_data_full, 
                       id = c("Subject", "Activity"), 
                       measure.vars = feature_names)

# 5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
tidy_data_summary <- tidy_data_long %>% 
  group_by(Subject, Activity, variable) %>% 
  summarise(mean(value))
# Write the final dataset to a file.
write.table(tidy_data_summary, "tidy_data_final.txt", row.names = FALSE)
