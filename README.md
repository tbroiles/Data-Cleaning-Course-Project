
# Getting and Cleaning Data Course Project

## Reading in the data

* The variable list is read in from '~UCI HAR Dataset/features.txt' as 'variable_list'.
* The activity labels are read in from '~UCI HAR Dataset/activity_labels.txt' as 'activity_list'.
* The raw accelerometer data is read in from '~UCI HAR Dataset/test/X_test.txt' and '~UCI HAR Dataset/train/X_train.txt' as 'raw_data1' and 'raw_data2', respectively.
* The activity data of each measurement is read from '~UCI HAR Dataset/test/Y_test.txt' and '~UCI HAR Dataset/train/Y_train.txt' as 'activity_data1' and 'activity_data2', respectively.

## Indexing the correct variables

* The grep command is used to search for variables including the text 'mean()' and stored in 'mean_index'.
* The grep command is used to search for variables including the text 'std()' and stored in 'std_index'.
* 'mean_index' and 'std_index' are merged and sorted to form 'combined_index'.

## Merging datasets

* 'raw_data1' and 'raw_data2' are merged using the rbind command to form 'raw_data'.
* 'activity_data1' and 'activity_data2' are merged using the rbind command to form 'activity_data'.
* 'activity_data' is converted into a factor with the names listed in 'activity_list'.

## Reducing the data to the final product

* 'raw_data' is assigned the column names from 'variable_list'.
* 'raw_data' is reduced to the columns in the 'combined_index'.
* 'raw_data' is aggregated based on the factor 'activity_data' and the mean is returned for each value and stored in 'tidy'.
* 'tidy' is saved with the write.table command as '~UCI HAR Dataset/tidy_dataset.txt'.
* 'tidy' is returned from the function.