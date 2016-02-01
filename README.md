# Project_CD
Project Cleaning Data

1. Describing run_analysis.R script

First, the script starts getting data necessary for the project by using download.file() function and naming it 'Base.zip'.

Then, code reads the files 'activity_labels.txt' and 'features.txt' and assigns variables to the information contained in this files.
Next, reads the information contained in files 'y_train.txt','X_train.txt' and 'subject_train.txt' and again, assigns it variables to the information charged.

Then the code inserts names to the variables of the base 'X_train.txt' using the labels of 'feature.txt'

Then, merges the activities indexes with their respective labels.

Next, constructs one data frame with the information the files mentioned before to resume all the information of the train data set.

Analogous for the test data set, a data frame is created following the same steps.

Then, proceeds to create one data frame with both bases (train and test) by using cbind function.

Next step is to take only columns with mean and standard deviation measures. For this task, only original measures (tBodyAcc, tGravityAcc and tBodyGyro, XYZ for each measure) were considered and name it 'baseUmedesv'.

Then, it filters the variables names by putting off all the extra characters (dashes "-",periods ".", spaces "")

Next, to create the final data set, first take the first two columns to create factors and then it uses group_by and summarize functions of dplyr package to take the means of all variables contained in the filtered data set 'baseUmedesv'.

Finally, final base is exported to a '.txt' file using write.table function
