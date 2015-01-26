library(dplyr)

rawDataDir <- 'UCI HAR Dataset'


# Merge the training and the test sets into one data frame.
allData <- read.table(file.path(rawDataDir, 'test', 'X_test.txt'))
rbind(allData, read.table(file.path(rawDataDir, 'train', 'X_train.txt')))

# Appropriately label the data with descriptive variable names.
features <- read.table(file.path(rawDataDir, 'features.txt'), row.names=1, col.names=c("id", "feature"))
names <- make.names(as.character(features[,1]), unique=TRUE)
colnames(allData) <- names

# Extract the mean and standard deviation for each measurement.
meanAndStdData <- select(allData, c(contains('mean'), contains('std'))) 

# Create tidy data set with the average of each variable for each activity and each subject
tidyAvgData <- colMeans(meanAndStdData)

# Create tidy data file
write.table(tidyAvgData, file='tidyAverges.txt', row.names=FALSE)

