# Getting and Cleaning Data Course Project Submission

David Mallard, April 2015

This repository contains the script, data file and documentation for my course project submission to the Coursera "Getting and Cleaning Data" course.

## Requirements

- Developed and tested using R 3.2.0 with RStudio 0.99 preview.
- The `reshape2` and `dplyr` packages must be installed.

## About the project

`run_analysis.R` performs all of the tasks required for completion of the project. The script will download and unzip the source data, then it reads in the required data files and manipulates them before generating the `tidy_data_final.txt` file that has the final summary data set.

See `CodeBook.md` for information about the dataset, the variables and the transformations involved.