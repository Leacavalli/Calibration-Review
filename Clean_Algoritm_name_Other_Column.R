# Clean environment
rm( list = ls() )

# load necessary libraries
library(tidyverse)

# Load data
setwd("~/GitHub/Calibration-Review")
raw_data <- read.csv("review_396964_20240608035120.csv")


# Recode 
ABC_SMC_names <- c("Approximate Bayesian Computation Sequential Monte Carlo scheme", 
                   "Approximate Bayesian computation with sequential Monte Carlo sampling", 
                   "Approximate Bayesian Computation with Sequential Monte Carlo Sampling", 
                   "Aproximate Bayesian Computation Sequential Monte Carlo (ABC-SMC) algorithm ")

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
              "Nelder-Mead algorithm ")

SIR_names <- c("sample-importance-resampling ", 
               "Sampling importance resampling ",
               "Sampling Importance Resampling",
               "Semi-Bayesian Sampling/Importance-Resampling algorithm")

SMC_PF_names <- c("sequential Monte Carlo method based on particle filtering", 
                  "sequential Monte Carlo method based on particle filtering",
                  "Sampling Importance Resampling",
                  "Sequential Monte Carlo method based on particle filtering known as\nMIF for Likelihood Maximization by Iterated Filtering")

PSPO_names <- c("parallel simultaneous perturbation \noptimisation (PSPO)",
                "parallel simultaneous perturbation optimization ")


raw_data_Calibration_Algorithm_other <- raw_data |>
  mutate(Other_V2= ifelse(X.Other..details..2 %in% ABC_SMC_names, "Aproximate Bayesian Computation Sequential Monte Carlo (ABC-SMC)", 
                          ifelse(X.Other..details..2 %in% HME_names, "History matching with emulation",
                                 ifelse(X.Other..details..2 %in% IMIS_names, "Incremental Mixture Importance Sampling (IMIS)", 
                                        ifelse(X.Other..details..2 %in% MCF_names, "Monte-Carlo filtering", 
                                               ifelse(X.Other..details..2 %in% SIR_names, "Sampling importance resampling", 
                                                      ifelse(X.Other..details..2 %in% SMC_PF_names, "Sequential Monte Carlo method based on particle filtering", 
                                                             ifelse(X.Other..details..2 %in% BM_names, "Bayesian melding", 
                                                                    ifelse(X.Other..details..2 %in% NM_names, "Nelder-Mead algorithm", 
                                                                           ifelse(X.Other..details..2 %in% PSPO_names, "Parallel Simultaneous perturbation Optimisation (PSPO)", X.Other..details..2)))))))))) |>
  rename("Other" = "X.Other..details..2")



raw_data_Calibration_Algorithm_other |>
  filter(Name.of.calibration.algorithm == "Other ") |>
  group_by(Other_V2) |>
  summarise(N=n())  |>
  filter(N>1)|>
  arrange(-N)

#
raw_data_Calibration_Algorithm_other |>
  filter(Name.of.calibration.algorithm != "Other ") |>
  filter(Other !="")|>
  select(Covidence.., Study.ID, Name.of.calibration.algorithm, Other)

raw_data_Calibration_Algorithm_other_subset <- raw_data_Calibration_Algorithm_other |>
  select(Covidence.., Study.ID, Name.of.calibration.algorithm, Other, Other_V2)



write.csv(raw_data_Calibration_Algorithm_other_subset, "Data_Calibration_Algorithm.csv", row.names = F)
