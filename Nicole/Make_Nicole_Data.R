setwd("~/GitHub/Calibration-Review")

clean_data <- read.csv("Clean_data.csv")

clean_data_Nicole <- clean_data |>
  select(Covidence.ID, Study.DOI, Year.published, Full.title, 
         Disease.type..choose.all.that.apply., Model.type, Stochasticity.in.model, 
         Is.calibration.implementation..code..available.in.an.open.access.repository.,
         What.programming.language.was.used.for.calibration.,
         Do.authors.list.any.programming.packages.used.for.calibration.) 
setwd("~/GitHub/Calibration-Review/Nicole")
write.csv(clean_data_Nicole, "clean_data.csv", row.names = F, quote = F)
