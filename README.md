# Github Repository Description
This Github contains the data and code used in the study "<Enter name>", available online [here](<Enter link).

The repository is boken down as such:
## 0. Raw data
This folder contains:
- "Covidence_Raw_data.csv": the raw data directly downloaded from covidence following extraction
- "Multiple_Calibration_data.csv": A manually-curated spreadsheet containing all relevant extraction information for studies that had multiple calibration procedures.
## 1.Data Cleaning
The folder contains:
- "Clean_Data.R": the R code used to clean the raw covidence dataset, and join it with the multiple calibration data.
- "Clean_Data.csv": the resulting cleaned calibration dataset
## 2.Analysis
The folder contains:
- "Data_extraction_sheet.xlsx": An excel document containg the "Summaries" and "Reporting" sheets.
- "Objective 1 - Summaries.R": the R code used to generate the sheet "Summaries", within the "Data_extraction_sheet.xlsx" document.
- "Objective 3 - Reporting.R": the R code used to generate the sheet "Reporting", within the "Data_extraction_sheet.xlsx" document.
- "Objective 1 - Figures.R": the R code used to generate the figures _______.
- "Calibration_size_Range_plot.png": A density plot showing the range  of calibration size per calibration algorithm.
- "Disease_algorithm_ChordDiagram.png": A barplot/chord diagram showing the distribution of calibration algorithms per Disease (HIV, TB or Malaria).
