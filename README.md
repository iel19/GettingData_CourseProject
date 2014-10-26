Run_analysis.R is a function analyze_wearable_data that does the following:

With the UCI Har Dataset in the working directory (no args needed)

1) Imports both the generic data (activity_label & features)
   and the test/ training data

2) Merges the test training data

3) Sets the column names (correspondingly does this for activities, so we can
   easily merge the names in later)

4) Using aggregate function, gets the mean/ std of the combined data

5) Merge in activity names as final_data, which is exports