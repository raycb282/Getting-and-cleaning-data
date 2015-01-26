setwd("~/Project/UCI HAR Dataset")

## Step 1.
## Read and merge the training and test datasets into one file. Along with column names.

## read the column heading file

heading1 <- read.table("features.txt")
heading <- (heading1[,2])

## Read in the train data

train1 <- read.table("train/X_train.txt")
train2 <- read.table("train/y_train.txt")
train3 <- read.table("train/subject_train.txt")

## Merge the train data by column

train <- cbind(train1, train2, train3)

## Read in the test data

test1 <- read.table("test/X_test.txt")
test2 <- read.table("test/y_test.txt")
test3 <- read.table("test/subject_test.txt")

## Merge the test data by column

test <- cbind(test1, test2, test3)

## Merge the train and test data by row

allData <- rbind(train, test)

## Step 4.
## Add column names

colnames(allData) <- heading

## Step 3.
## Assign meaningful descriptions to activity variable.

activity <- read.table("activity_labels.txt")
currentActivity = 1
for (currentActivityLabel in activity$V2) {
        allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
        currentActivity <- currentActivity + 1
}


## Step 2.
## Keep only the columns with "mean" or "std"

matches <- grep("(mean|std)\\(\\)", names(allData))
limited <- allData[, matches]


## Step 5.
## create a seperate tidy data set with the average of each variable for each activity and each subject.

tidy = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)

write.table(tidy, "tidy.txt", row.names = FALSE)

## THE END.





              

