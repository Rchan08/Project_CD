Describe all the variables in the data set

All the features contained in the data set come from the orginal data provided for this project. Only three measures were considered: tBodyGyro, tBodyAcc, tGravityAcc with their respective axial measures (XYZ). Also, for each variable, mean and standard deviation are considered. 

Since the original base has more then one record for each subject and each activity, the new data set reports the mean value of all the 
repeated records for each subject and activity. 

sujeto - Represents the subject who carried out the experiment.
range: integers 1:30 
Actividad - Represents the activity developed by the subject.
Characters: "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS","SITTING", "STANDING", "LAYING"
The next variables are numeric, standardize and bounded within [-1,1]
tBodyAcc-XYZ - Body acceleration estimated 
tBodyGyro-XYZ - Angular velocity from the body
tGravityAcc-XYZ - Gravity acceleration estimated

and the respective variables estimated:

mean(): mean value
std(): standard deviation value
