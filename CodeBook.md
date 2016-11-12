The codebook details the list of variables used and the process that was used to accomplish the analysis.

Details on Variables:
a) xTest, yTest, xTrain, yTrain, subjectTest, subjectTrain, features and activityLabels are the variables that contains the data from the source files.
b) testData - Column bind xTest, yTest and subjectTest
c) trainData - Column bind xTrain, yTrain and subjectTrain
d) completeExersiseData - Row bind the testData and trainData to form a single combined dataset.
e) subsetMeanAndStdData - Subset of columns with mean and standard deviation from the completeExersiseData.
f) meanAndStdWithActivtityNameData - Dataset that has the mean and standarad deviation data with the activity names.
g) finalData - Final dataset with the mean for each columns based on subject id and activity id.


Description of each stages/steps:
Summary: Get the mean for all the variables under each activity/subject combination.
Individual steps given below:

#Stage A: Merges the training and the test sets to create one data set.
#Step 1 Get the data from the cloud into the local system for performing data analysis. 
#Step 2: Decompress the file.
#Step 3: Bring the data into R environment:
#Step 4: Assign column names to the variables:
#Step 5: Merge the data into a single dataframe for processing:

#Stage B: Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 1: Create a subset with the mean and standard devation columns by first extract the required column names
#        from the header and subset the data.

#Stage C: Uses descriptive activity names to name the activities in the data set
#Step 1: Merge the activity names to this dataset by having the activityId as the key column for the merge.

#Stage D: Appropriately labels the data set with descriptive variable names.
#Step 1: Remove the special characters from the column names

#StageE: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
#Step 1: load the dplyr package and use the summarise_each function to calculate mean of each of the variables.

#step 2: Write the final data into the localdrive. Note that the data is pipe delimited i.e. "|" for use in other systems.

