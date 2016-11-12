#Data analysis Log:
#Author         : Prashanth Thomas Jayaseelan
#Created Date   : Nov 12, 2016
#Summary        : Get the mean for all the variables under each activity/subject combination.

#Stage A: Merges the training and the test sets to create one data set.

#Step 1 Get the data from the cloud into the local system for performing data analysis. 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "Exersise.zip")

#Step 2: Decompress the file.
unzip("Exersise.zip")

#Step 3: Bring the data into R environment:
#Testing tables
xTest = read.table("./UCI HAR Dataset/test/X_test.txt")
yTest = read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest = read.table("./UCI HAR Dataset/test/subject_test.txt")
#Training tables
xTrain = read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain = read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain = read.table("./UCI HAR Dataset/train/subject_train.txt")
#Features:
features = read.table("./UCI HAR Dataset/features.txt")
#Activity labels:
activityLabels = read.table('.//UCI HAR Dataset/activity_labels.txt')

#Step 4: Assign column names to the variables:
names(xTest) = features[,2]
names(yTest) = "activityId"
names(subjectTest) = "subjectId"
names(xTrain) = features[,2]
names(yTrain) = "activityId"
names(subjectTrain) = "subjectId"
names(activityLabels) = c("activityId","activityName")

#Step 5: Merge the data into a single dataframe for processing:
testData = cbind(xTest,yTest,subjectTest)
trainData = cbind(xTrain,yTrain,subjectTrain)
completeExersiseData = rbind(testData,trainData)


#Stage B: Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 1: Create a subset with the mean and standard devation columns by first extract the required column names
#        from the header and subset the data.
columnNames = names(completeExersiseData)
colMeanAndStd = (grepl("activityId" , columnNames) | grepl("subjectId" , columnNames) | 
                     grepl("mean.." , columnNames) | grepl("std.." , columnNames) )

subsetMeanAndStdData = completeExersiseData[,colMeanAndStd == TRUE]


#Stage C: Uses descriptive activity names to name the activities in the data set
#Step 1: Merge the activity names to this dataset by having the activityId as the key column for the merge.
meanAndStdWithActivtityNameData = merge(subsetMeanAndStdData,activityLabels,all.x = TRUE)


#Stage D: Appropriately labels the data set with descriptive variable names.
#Step 1: Remove the special characters from the column names
names(meanAndStdWithActivtityNameData)= gsub("[,()-]","",names(meanAndStdWithActivtityNameData))


#StageE: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
#Step 1: load the dplyr package and use the summarise_each function to calculate mean of each of the variables.
library(dplyr)
finalData = as.data.frame(meanAndStdWithActivtityNameData %>% group_by(activityId,subjectId) %>% summarise_each(funs(mean(.,na.rm=TRUE)),-(subjectId+activityId)))

#step 2: Write the final data into the localdrive. 
write.table(finalData,"FinalExersiseData.txt",row.names = FALSE)
