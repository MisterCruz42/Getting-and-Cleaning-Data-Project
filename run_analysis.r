#Import Activity labels
ActLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
ActLabel[,2]<- as.character(ActLabel[,2])
colnames(ActLabel) <- c("Level", "Label")

#Import features and keep mean and std
feat <- read.table("UCI HAR Dataset/features.txt")
feat[,2] <- as.character(feat[,2])
features<- grep("mean|std",feat[,2])
features.names <- feat[features,2]

#Import Train data 
trainVal <- read.table("UCI HAR Dataset/train/X_train.txt") 
trainAct <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Import Test data
testVal <- read.table("UCI HAR Dataset/test/X_test.txt")
testAct <- read.table("UCI HAR Dataset/test/y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Merge train data and test data 
train <- cbind(trainSub, trainAct, trainVal)
test <- cbind(testSub, testAct, testVal)
Combined <- rbind(train, test)
colnames(Combined) <- c("subject", "activity", features.names)

#Activities to factors
Combined$activity<- factor(Combined$activity, levels= ActLabel[,1], labels= ActLabel[,2])
Combined$subject <- as.factor(Combined$subject)
cname<- colnames(Combined)

#rename certain columns to increase clarity
cname <- gsub("Mean()", "Mean", cname)
cname <- gsub("Std()", "Std", cname)
cname <- gsub("BodyBody", "Body", cname)
colnames(Combined) <-cname


library(reshape2)

# Melt the data to have unique rows for subject and activity id.
Combined.melted <- melt(Combined, id = c('subject', 'activity'))

# Get mean of melted data
Combined.mean <- dcast(Combined.melted, subject + activity ~ variable, mean)

# write table
write.table(Combined.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)