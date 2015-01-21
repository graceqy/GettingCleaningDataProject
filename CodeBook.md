# Code book for data information and transformation process

## Original data information

The files imported to merge and tidy data from the original download are:

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

'subject_test.txt' : the subjects in numbers for the test data sets (1-30)

'subject_train.txt': the subjects in numbers for the train data sets (1-30)


## Data transformation steps
-- I did slight different from the given order:
1. Merge the whole data sets
2. Label the variables (columns) properly.  (given step 4)
3. Extract measurements on means and sds. (given step 2)
4. Tidy (aggregate) data by acticity and subject (given step 5)
5. Give Activity variable discriptive names
6. Get all the columns in the right order and export.

## Discription of the data and values created during transformation
x_test: imported "X_test.txt" file.
y_test: imported "y_test.txt" file
subject_test: imported "subject_test.txt" file
x_train: imported "X_train.txt" file 
y_train: "y_train.txt" file 
subject_train: imported "subject_train.txt" file 

x_test and y_test have the same number of rows: 2947
x_train and y_train have the same number of rows: 7352

test.xys: merged test files by column, 2947 rows by 563 column
train.xys: merged train files by column, 7352 rows by 563 column
merge: merge test and train files by rows: 10299 rows and 563 columns

feature: import of "features.txt"

feature.mx: matrix of feature

header: variable names/column names.

mean_sd_column <- c(mean_sd_column,562,563): the number of columns with mean() or sd() and the last two columns (subject and activity).

clean.col <- merge[,mean_sd_column]: all the variables of columns with mean() or sd() and the last two columns (subject and activity), 10299 rows, 68 columns.

agg: aggregated data by Activity and Subject, 180 rows and 68 columns.
agg1: aggregated data by Activity and Subject, columns in the right order, 180 rows and 68 columns.

The final output is the tidy data set: HAR_data_set.txt in the /Project/UCI_HAR_Dataset directory.


