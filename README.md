#Getting and Cleaning Data
=========================
The run_analysis.R script takes data from the *Human Activity Recognition Using Smartphones* dataset.

###Downloading and Extracting the Data
Data for the project was downloaded from here.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data files are extracted into this folder structure:

UCI HAR Dataset
- test
- train

The working directory should be set to the *UCI HAR Dataset* folder.

###Data files
There is a training set and a test set of files. Each set contains:
* subject - which contains the identifier for each test subject;
* activity - which has the activity the subject was engaged in;
* measures - the average of the mean and stand deviation of the measures in the raw data.

For more details, please see the accompanying code book.

###Processing the Data
run_analysis.R follows this process:
1. Read in data files
2. Combine all data sets
3. Reshape Data
4. Write tidy data file
