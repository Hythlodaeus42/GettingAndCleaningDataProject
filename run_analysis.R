#================================================
#-- Read in data files --------------------------
#================================================
#it is assumed the data has already been downloaded
#and extracted, and that the working directory has
#been set to root folder from the extract.

#get features
print("reading features...")
features  <- read.table("features.txt", stringsAsFactors=FALSE)

#get activity labels
print("reading labels...")
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)

#get training set
print("reading training set...")
x_train <- read.table("train/X_train.txt", stringsAsFactors=FALSE, col.names = features$V2, check.names = FALSE)
y_train <- read.table("train/y_train.txt", stringsAsFactors=FALSE)
subject_train <- read.table("train/subject_train.txt", stringsAsFactors=FALSE, col.names = "subject")

#get test set
print("reading test set...")
x_test <- read.table("test/x_test.txt", stringsAsFactors=FALSE, col.names = features$V2, check.names = FALSE)
y_test <- read.table("test/y_test.txt", stringsAsFactors=FALSE)
subject_test <- read.table("test/subject_test.txt", stringsAsFactors=FALSE, col.names = "subject")

#================================================
#-- Combine all data sets -----------------------
#================================================
#merge the label set (y) with the label descriptions
print("merging with label descriptions...")
y_train <- merge(y_train, labels, by.x = "V1", by.y = "V1", all = FALSE, sort = FALSE)
y_test <- merge(y_test, labels, by.x = "V1", by.y = "V1", all = FALSE, sort = FALSE)

#rename the columns for Y
labelColumns = c("label", "activity")
names(y_train) <- labelColumns
names(y_test) <- labelColumns

#get only mean and std column names
mean_std <- features$V2[grep("(mean\\(|std\\()", features$V2)]

#combine X & Y
#column bind the subject, activity labels and features for both the training and test datasets
#training and test datasets, only using the mean and std features.
#then row bind the training and test datasets
print("combining training and test, features and labels...")
data <- rbind(cbind(subject_train, y_train, x_train[mean_std]), cbind(subject_test, y_test, x_test[mean_std]))

#================================================
#-- Reshape Data --------------------------------
#================================================
#melt data
#specify id columns, all others will be measures by default
print("melting data...")
meltData <- melt(data, id = c("subject", "label", "activity"))

#cast tidy data set
#grouping by subject and activity, taking the mean of the measures
print("casting tidy data...")
tidy <- dcast(meltData, subject  + activity ~ variable, mean)


#================================================
#-- Write out tidy data -------------------------
#================================================
#write out to file
print("writing to tidy.txt...")
write.table(tidy, file = "tidy.txt", row.names = FALSE)

print("Done.")
