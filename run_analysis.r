#Import Activity labels
ActLabel <- read.table("UCI HAR Dataset/activity_labels.txt")

#Import features and keep mean and std
feat <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
features<- grep("mean|std",feat[,2])
features.names <- feat[features,2]

#Import Train data 
trainAct <- read.table("UCI HAR Dataset/train/X_train.txt") [features]
trainVal <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Import Test data
testAct <- read.table("UCI HAR Dataset/test/X_test.txt")[features]
testVal <- read.table("UCI HAR Dataset/test/y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Merge train data and test data 
train <- cbind(trainAct, trainVal, trainSub)
test <- cbind(testAct, testVal, testSub)
Combined <- rbind(train, test)
colnames(Combined) <- c("subject", "activity", features.names)

#Activities to factors
Combined$activity<- factor(Combined$activity, levels= ActLabel[,1], labels= ActLabel[, 2])
cname<- colnames(Combined)

#rename certain columns to increase clarity
cname <- gsub("Mean()", "Mean", cname)
cname <- gsub("Std()", "Std", cname)
cname <- gsub("BodyBody", "Body", cname)
colnames(Combined) <-cname

install.packages("reshape2")
libary(reshape2)

# Melt the data to have unique rows for subject and activity id.
Combined.melted <- melt(Combined, id = c('subject', 'activity'))

# Get mean of melted data
Combined.mean <- dcast(Combined.melted, subject + activity ~ variable, mean)

# write table
write.table(Combined.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)