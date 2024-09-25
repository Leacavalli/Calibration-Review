
library(tidyverse)

setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
cleandata <- read.csv("Clean_data.csv")

Pre_defined <- cleandata |> 
  filter(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm != "Other ")|> 
  filter(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm != "Not clear")|> 
  group_by(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm) |> 
  summarise(N=n())|>
  mutate(Category = "Pre-defined")


AIC <- c(" Akaike information criterion (AIC) value", 
  "Akaike Information Criterion ")

X2 <- c(" Chi-square test", 
  "Chi-square test")

Geweke <- c("Geweke value", 
  "Geweke’s method")

Other <- cleandata|> 
  filter(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm == "Other ")|>
  mutate(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm= 
           ifelse(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm %in% AIC, "Akaike information criterion (AIC)", 
                  ifelse(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm %in% X2, "Chi-square test", 
                         ifelse(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm %in% Geweke, "Geweke’s method", 
                                Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm))))|>
  group_by(Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm)|> 
  summarise(N=n())|>
  mutate(Category = "Other")|>
  rename("Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm"="Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm")



Not_Clear <- cleandata|> 
  filter(Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm == "Not clear")|>
  group_by(Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm)|> 
  summarise(N=n())|>
  mutate(Category = "Not Clear")|>
  rename("Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm"="Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm")


GoF_summary_df <- rbind(Pre_defined, Other, Not_Clear)|>
  arrange(-N)
setwd("~/GitHub/Calibration-Review/1.Data Cleaning/Temp")
write.csv(GoF_summary_df, "Counts_GoF.csv", row.names = F)


Data_GoF_df <- cleandata|>
  select(Covidence.ID, Study.DOI, Name.of.calibration.algorithm, Other_Name.of.calibration.algorithm, Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, Other_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, Not_Clear_Goodness.of.fit..GOF..measure.employed.within.calibration.algorithm, Nature.of.calibration.results, Other_Nature.of.calibration.results)
setwd("~/GitHub/Calibration-Review/1.Data Cleaning/Temp")
write.csv(Data_GoF_df, "Data_GoF_df.csv", row.names = F)

