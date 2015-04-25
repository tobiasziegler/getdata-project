# Code Book

## Data source and transformation

The source data for this project is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was collected from accelerometers in the Samsung Galaxy S smartphone. Information about the dataset is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For additional detail about the source data files, see the README and other text files that are part of the Zip package and which will be unzipped when the `run_analysis.R` script is processed.

## Data processing and transformation

The `run_analysis.R` script downloads and reads the source data files, merges the training and test data files into a single dataset, selects a subset of the original measures, transforms the data into a tidy format and calculates a set of summary statistics.

## Code book for the final processed data

`tidy_data_final.txt` is a delimited text file containing the final, processed data that indicates the mean of the observed measurements for the corresponding subject, type of activity being undertaken and the nature of the measurement.

The data is in a "long" tidy format in which there is one variable per column and one observation (in this case, one summary statistics) per row. It has the following variables:

- **Subject**: The ID number identifying the subject who performed the activity being measured in this observation. Ranges from 1 to 30.
- **Activity**: A factor variable identifying which of the six categories of activity by the subject are being measured in this observation. Factor levels correspond to the six activity labels in the source data, i.e., `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` or `LAYING`.
- **variable**: Indicates which type of accelerometer/gyroscope feature is being measured in this observation. For instance, `tBodyAcc-mean()-X` indicates the mean body acceleration signal observed in the x-axis direction. For a full description of the values of this variable see the explanatory files accompanying the source data, `features.txt` and `features_info.txt`. Note that only variables that indicated a mean or standard deviation in the source data were retained in this dataset.
- **mean(value)**: Summarises the mean of all of the original observed values in the source dataset corresponding to this combination of subject, activity and measurement feature/variable.