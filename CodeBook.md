---
title: "CodeBook.md"
output: html_document
---
Codebook explaining the different variables used and any transformations applied in scripts for data cleaning project.

# run_analysis.R

## variables

total_data      - contains joined train and test features
total_labels    - contains joined train and test labels
total_subjects  - contains joined list of subjects from train and test observations
activity_labels - contains activity code and text label map

cols            - contains "mean" and "std" column filter map
cols_to_keep    - stores columns numbers index containing only columns with "mean" and "std"
cols_names      - contains the feature name
total_set       - contains total set of observations combined with activity labels and subject numbers
averages        - contins average value of all features for each activity and subject group.
