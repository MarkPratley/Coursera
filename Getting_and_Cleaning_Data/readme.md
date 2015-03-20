# Getting and Cleaning Data


## TOC

* [Description](#Description)
* [Files](#Files)
* [Requirements](#Requirements)
* [Execution](#Execution)
* [Project Specifications](#Project-Specifications)

<a id="Description"></a>
## Description

This is my project for the [Getting and Cleaning Data](https://www.coursera.org/course/getdata) Coursera module.

This project uses [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from the field of [wearable computing](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) and processes it into a unified, readable and [tidy format](http://vita.had.co.nz/papers/tidy-data.pdf) before outputting a file containing the average measurements of the data.

<a id="Files"></a>
## Files

* [readme.md](readme.md) - This file
* [run_analysis.R](run_analysis.R) - The R file to transform the data
* [codebook.md](codebook.md) - A description of the variables, data, and transformations.

<a id="Requirements"></a>
## Requirements

* [Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) downloaded and unzipped into ./UCI HAR Dataset/
* R Package dplyr installed

<a id="Execution"></a>
## Execution

To run the project open R and change to the relevant working directory (the one with run_analysis.R and UCI HAR Dataset/)
and type:

source("run_analysis.R")

<a id="Project-Specifications"></a>
## Project Specifications

These instructions are taken from [here](https://class.coursera.org/getdata-012/human_grading/view/courses/973499/assessments/3/submissions) 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.