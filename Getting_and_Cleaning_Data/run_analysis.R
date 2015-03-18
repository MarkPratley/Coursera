# Coursera getdata-012
#   Mark Pratley
#     Assignment
#       run_analysis.R
#        17-Mar-2015

# You should create one R script called run_analysis.R that
# does the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard
#    deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities
#    in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each
#    activity and each subject.

# I am Assuming data is downloaded & unzipped to "./UCI HAR Dataset"

# 1. Merges the training and the test sets to create one data set.
# Read in test data
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt" )
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read in train data
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt" )
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Combine data
subject      <- rbind(subtest, subtrain)
activity     <- rbind(ytest, ytrain)
measurements <- rbind(xtest, xtrain)

# Load in variables
vars <- read.table("./UCI HAR Dataset/features.txt")

# filter to only include mean & std
mean_std <- filter(vars, grepl("mean",V2) | grepl("std",V2))

# filter values for mean & std
measurements <- measurements[,mean_std$V1]

# Load Activity labels
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# 3. Uses descriptive activity names to name the activities
#     in the data set
activity <- inner_join(activity, act_labels, by = "V1")$V2

# 4. Appropriately labels the data set with descriptive variable names.
mean_std$V2 <- gsub("\\(\\)", "", mean_std$V2 )
names(measurements) <- mean_std$V2

# Create 1 unified data structure
tidy_data_mean_std <- cbind(subject, activity, measurements)

# With nicer names
names(tidy_data_mean_std)[1:2] <- c("Subject", "Activity")

# 5. From the data set in step 4, creates a second, independent
#    tidy data set with the average of each variable for each
#    activity and each subject.

Avgs_by_subject_activity <- tidy_data_mean_std %>% 
                            group_by(Subject, Activity) %>%
                            summarise_each(funs(mean))

# Write to file
write.table(Avgs_by_subject_activity, "Avgs_by_subject_activity.txt", row.name=FALSE)
