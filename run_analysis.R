library(plyr)

#Step 1
train.x <- read.table("train/X_train.txt")
test.x <- read.table("test/X_test.txt")
data.x <- rbind(train.x, test.x)

train.y <- read.table("train/y_train.txt")
test.y <- read.table("test/y_test.txt")
data.y <- rbind(train.y, test.y)

train.subject <- read.table("train/subject_train.txt")
test.subject <- read.table("test/subject_test.txt")
subject.data <- rbind(train.subject, test.subject)


#Step 2
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
mean.std.data.x <- data.x[, mean_and_std_features]
names(mean.std.data.x) <- features[mean_and_std_features, 2]


#Step 3
activities.labels <- read.table("activity_labels.txt")
data.y[, 1] <- activities.labels[data.y[, 1], 2]
names(data.y) <- "activity"

#Step 4
names(subject.data) <- "subject"
alldata <- cbind(data.x, data.y, subject.data)

#Step 5
average.data <- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(average.data, "average_data.txt", row.name=FALSE)

