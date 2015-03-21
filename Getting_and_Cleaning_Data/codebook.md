# Codebook


## TOC

* [Description](#Description)
* [Data](#Data)
* [Files](#Files)
* [Variables](#Variables)
* [Transformations](#Transformations)


<a id="Description"></a>
## Description

This code book describes the data, variables and the transformations which were used to clean the data before creating the final data output

<a id="Data"></a>
## Data

The data was obtained from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) taken from the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).

The zip file for the data is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

Data description taken from the dataset readme file:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

<a id="Files"></a>
## Files
This analysis uses 8 files from the dataset:

UCI HAR Dataset/

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity

* 'test/subject_train.txt': Each row identifies the subject who performed the activity

<a id="Variables"></a>
## Variables

xtest -  data.frame of data from "./UCI HAR Dataset/test/X_test.txt" - the test measurements

ytest -  data.frame of data from "./UCI HAR Dataset/test/y_test.txt" - the test activity

subtest -  data.frame of data from "./UCI HAR Dataset/test/subject_test.txt" - the test subject 

xtrain -  data.frame of data from "./UCI HAR Dataset/train/X_train.txt" - the training measurements

ytrain -  data.frame of data from "./UCI HAR Dataset/train/y_train.txt" - the training activity

subtrain -  data.frame of data from "./UCI HAR Dataset/train/subject_train.txt" - the training subject

subject- data.frame combining the test and training subjects (subtest & subtrain)

activity - data.frame combining the test and training activity (ytest & ytrain)

measurements - data.frame combining the test and training measurements (xtest, xtrain)

vars - data.frame of data from "./UCI HAR Dataset/features.txt" - the measurements labels

mean_std - data.frame - vars filtered to only contain labels for measurements for means and stds

act\_labels - data.frame of data from "./UCI HAR Dataset/activity_labels.txt" - the activity labels

tidy\_data\_mean_std - data.frame containing the unified data for the mean and std measurements

Avgs\_by\_subject_activity - a 'grouped data.frame' containing the means of the unified data grouped by subject and activity

<a id="Transformations"></a>
## Transformations

### 1

subtest & subtrain were combined row-wise to get full list of subjects

ytest & ytrain were combined row-wise to get full list of activities

xtest & xtrain were combined row-wise to get full list of measurements

subject, activity & measurements were combined column-wise to get a unified data set (tidy\_data\_mean\_std)

###2

A filter (from dplyr) was applied to vars which now contains only labels which included mean or std (to create mean_std)

Some columns were removed from measurements (using mean_std) to only show data for mean and std measurements

###3

An inner\_join (from dplyr) was applied to activity and act_labels by their common column to create a dataset with descriptive activity names

###4

The brackets were removed from the measurement lables to tidy the text

The measurement labels from mean_std were applied to measurements to apply appropriate descriptive variable names

###5

Data was grouped by subject and activity, and the mean of the data was taken for each group

###6

The final data product is outputted as a file to "Avgs_by_subject_activity.txt"

This product has 180 rows with 81 variables.

180 rows for 30 subjects and 6 activities

81 variables comprised of subject, activity and 79 average measurements which contain the text mean or std