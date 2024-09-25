setwd("~/GitHub/Calibration-Review/1.Data Cleaning")

clean_data <- read.csv("Clean_data.csv")

clean_data_Nicole <- clean_data |>
  select(Covidence.ID, Study.DOI, Year.published, Full.title, 
         Disease.type..choose.all.that.apply., Model.type, Stochasticity.in.model, 
         Is.calibration.implementation..code..available.in.an.open.access.repository.,
         What.programming.language.was.used.for.calibration.,
         Do.authors.list.any.programming.packages.used.for.calibration., 
         Name.of.calibration.algorithm, 
         Other_Name.of.calibration.algorithm) 


# Make vectors containing all versions of each algorithm's name
ABC_SMC_names <- c("Approximate Bayesian Computation Sequential Monte Carlo scheme", 
                   "Approximate Bayesian computation with sequential Monte Carlo sampling", 
                   "Approximate Bayesian Computation with Sequential Monte Carlo Sampling", 
                   "Aproximate Bayesian Computation Sequential Monte Carlo (ABC-SMC) algorithm ", 
                   "Approximate Bayesian Computation Sequential Monte Carlo (ABC SMC) method", 
                   "Approximate Bayesian Computation with Sequential Monte Carlo sampling (ABC-SMC) method")
HME_names <- c("History matching with emulation", 
               "history matching with model emulation", 
               "history matching with emulation", 
               " history matching with emulation")
IMIS_names <- c("incremental mixture importance sampling", 
                "Incremental mixture importance sampling", 
                "Incremental Mixture Importance Sampling", 
                " Incremental Mixture Importance Sampling", 
                "incremental mixture importance sampling (IMIS)", 
                "Incremental Mixture Importance Sampling (IMIS) ",
                "a Bayesian framework with incremental mixture importance sampling", 
                "Incremental Mixture Importance Sampling")
MCF_names <- c("Monte-Carlo filtering", 
               "Monte-Carlo filtering ", 
               "Monte Carlo filtering")
BM_names <- c("Bayesian melding",
              " Bayesian melding")
NM_names <- c("Iterative, directed-search Nelder-Mead (NM) method", 
              "Nelder-Mead algorithm ", 
              "Nelder-Mead")
SIR_names <- c("sample-importance-resampling ", 
               "Sampling importance resampling ",
               "Sampling Importance Resampling",
               "Semi-Bayesian Sampling/Importance-Resampling algorithm", 
               "Sampling-importance-resampling (SIR) approach")
SMC_PF_names <- c("sequential Monte Carlo method based on particle filtering", 
                  "sequential Monte Carlo method based on particle filtering",
                  "particle Markov\nchain Monte Carlo (PMCMC",
                  "Sequential Monte Carlo method based on particle filtering known as\nMIF for Likelihood Maximization by Iterated Filtering")
PSPO_names <- c("parallel simultaneous perturbation \noptimisation (PSPO)",
                "parallel simultaneous perturbation optimization ")

# Recode the Other algorithm names with standardized name 
clean_data_Nicole_v2 <- clean_data_Nicole |>
  mutate(Other_Name.of.calibration.algorithm_V2= ifelse(Other_Name.of.calibration.algorithm %in% ABC_SMC_names, "Aproximate Bayesian Computation Sequential Monte Carlo (ABC-SMC)", 
                                                        ifelse(Other_Name.of.calibration.algorithm %in% HME_names, "History matching with emulation",
                                                               ifelse(Other_Name.of.calibration.algorithm %in% IMIS_names, "Incremental Mixture Importance Sampling (IMIS)", 
                                                                      ifelse(Other_Name.of.calibration.algorithm %in% MCF_names, "Monte-Carlo filtering", 
                                                                             ifelse(Other_Name.of.calibration.algorithm %in% SIR_names, "Sampling importance resampling", 
                                                                                    ifelse(Other_Name.of.calibration.algorithm %in% SMC_PF_names, "Sequential Monte Carlo method based on particle filtering", 
                                                                                           ifelse(Other_Name.of.calibration.algorithm %in% BM_names, "Bayesian melding", 
                                                                                                  ifelse(Other_Name.of.calibration.algorithm %in% NM_names, "Nelder-Mead algorithm", 
                                                                                                         ifelse(Other_Name.of.calibration.algorithm %in% PSPO_names, "Parallel Simultaneous perturbation Optimisation (PSPO)", Other_Name.of.calibration.algorithm))))))))))


setwd("~/GitHub/Calibration-Review/Nicole")
write.csv(clean_data_Nicole_v2, "clean_data.csv", row.names = F)
