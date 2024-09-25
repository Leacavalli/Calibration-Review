setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
clean_date <- read.csv( "Clean_data.csv")

clean_date_Model.type <- clean_date |> select(Model.type, Other_Model.type) |> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_What.justification.was.provided.for.choice.of.parameters.to.calibrate. <- clean_date |> select(What.justification.was.provided.for.choice.of.parameters.to.calibrate., Other_What.justification.was.provided.for.choice.of.parameters.to.calibrate.)|> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_Type.of.data.used.for.defining.calibration.targets..select.all.that.apply. <- clean_date |> select(Type.of.data.used.for.defining.calibration.targets..select.all.that.apply., Other_Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.)|> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_Name.of.calibration.algorithm <- clean_date |> select(Name.of.calibration.algorithm, Other_Name.of.calibration.algorithm)|> filter(if_any(contains("Other_"), ~ !is.na(.)))|> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm <- clean_date %>%
  select(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, 
         Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, 
         Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm) %>%
  filter(if_any(matches("Other_|Not_Clear_"), ~ !is.na(.) & . != "")) %>%
  mutate(Other_or_Notclear = coalesce(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm)) %>%
  select(-Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, -Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm)
clean_date_Nature.of.calibration.results <- clean_date |> select(Nature.of.calibration.results, Other_Nature.of.calibration.results)|> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_How.are.calibration.results.reported. <- clean_date |> select(How.are.calibration.results.reported., Other_How.are.calibration.results.reported.)|> filter(if_any(contains("Other_"), ~ !is.na(.)))
clean_date_How.is.uncertainty.in.calibration.outputs.reported. <- clean_date |> select(How.is.uncertainty.in.calibration.outputs.reported., Other_How.is.uncertainty.in.calibration.outputs.reported.)|> filter(if_any(contains("Other_"), ~ !is.na(.)))



# Write a file 
library(xlsx)
setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
write.xlsx(as.data.frame(clean_date_Model.type), file="Other_columns_check.xlsx", sheetName = "Model.type", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_What.justification.was.provided.for.choice.of.parameters.to.calibrate.), file="Other_columns_check.xlsx", sheetName = "What.justification.was.provided.for.choice.of.parameters.to.calibrate.", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.), file="Other_columns_check.xlsx", sheetName = "Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_Name.of.calibration.algorithm), file="Other_columns_check.xlsx", sheetName = "Name.of.calibration.algorithm", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm), file="Other_columns_check.xlsx", sheetName = "Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_Nature.of.calibration.results), file="Other_columns_check.xlsx", sheetName = "Nature.of.calibration.results", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_How.are.calibration.results.reported.), file="Other_columns_check.xlsx", sheetName = "How.are.calibration.results.reported.", append=TRUE , row.names = F, col.names = T)
write.xlsx(as.data.frame(clean_date_How.is.uncertainty.in.calibration.outputs.reported.), file="Other_columns_check.xlsx", sheetName = "How.is.uncertainty.in.calibration.outputs.reported.", append=TRUE , row.names = F, col.names = T)