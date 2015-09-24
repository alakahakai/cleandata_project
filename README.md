
# README for Course Project
# Author: Ray Qiu
# Date: Sept 23rd, 2015

The training and test data sets have the same 561 features, which are listed in features.txt.
A simple rbind combines the two data sets into one (dataset X). Same goes for the label datasets.

Filtering by the names can retrieve the column numbers for mean and std, then use the column numbers,
we can subset the data set to only mean and std.

The activity_labels has the following data:
  label           activity
1     1            WALKING
2     2   WALKING_UPSTAIRS
3     3 WALKING_DOWNSTAIRS
4     4            SITTING
5     5           STANDING
6     6             LAYING

Using this data, we can map the labels in the label dataset to activities.

Now we combine the label dataframe with the combined dataset X, as well as the subject dataframe.  
Then we perform a group_by to break the dataset into groups where activity and subject.  By using
the summarise_each function in dplyr, we can get the final dataset.

The final data set has the following columns:
 [1] "activity"                  "subject"                   "tBodyAccMag.mean"         
 [4] "tBodyAccMag.std"           "tGravityAccMag.mean"       "tGravityAccMag.std"       
 [7] "tBodyAccJerkMag.mean"      "tBodyAccJerkMag.std"       "tBodyGyroMag.mean"        
[10] "tBodyGyroMag.std"          "tBodyGyroJerkMag.mean"     "tBodyGyroJerkMag.std"     
[13] "fBodyAccMag.mean"          "fBodyAccMag.std"           "fBodyBodyAccJerkMag.mean"
[16] "fBodyBodyAccJerkMag.std"   "fBodyBodyGyroMag.mean"     "fBodyBodyGyroMag.std"     
[19] "fBodyBodyGyroJerkMag.mean" "fBodyBodyGyroJerkMag.std"

We then write the final dataset to file. Done!
