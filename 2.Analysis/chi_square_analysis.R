#### Load relevant packages #####

library(readxl) # Reading Excel graphs 
library(ggstatsplot) # Plotting results 
library(ggpubr) # Combining plots

#### Load data and format #####
# Clean environment
rm( list = ls() )
# load necessary libraries
library(tidyverse)
# Load data
setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
clean_data <- read.csv("Clean_data.csv")
# tb1
tb1 <-
  clean_data |> 
  separate_rows(Calibration.algorithm.Family, sep = "; ")|>
  select(Covidence.ID, Full.title, Calibration.algorithm.Family, Model.type, Stochasticity.in.model)


### General data wrangling ####
# Import
# tb1 <- read_excel("data/Objective2_Table1a.xlsx")
head(tb1)  

# Subset to include only top calibration methods with at least 20 models in each 
tb11 <- tb1[tb1$Calibration.algorithm.Family%in%
      c("Approximate Bayesian Computation (ABC)",
        "Markov Chain Monte Carlo",
        "Least squares estimation",
        "Maximum likelihood estimation") & tb1$Model.type %in% c("Compartmental", "Individual-based"), ]
tb11

# Change relevant columns to factors 

## Calibration algorithm, factor
tb11$Calibration.algorithm.Family <- as.factor(tb11$Calibration.algorithm.Family)
levels(tb11$Calibration.algorithm.Family)

## Model structure 
tb11$Model.type <- as.factor(tb11$Model.type)
levels(tb11$Model.type)

## Model stochasticity
tb11$Stochasticity.in.model <- as.factor(tb11$Stochasticity.in.model)
levels(tb11$Stochasticity.in.model)


# View contingency table 
table(tb11$Calibration.algorithm.Family, tb11$Model.type)

# Run Chi-sq test (ref: https://statsandr.com/blog/chi-square-test-of-independence-in-r/)
# table(tb1$Calibration.algorithm.Family, tb1$Model.type)
# test <- chisq.test(table(tb1$Calibration.algorithm.Family, tb1$Model.type))
# test$expected
# With Chi-sq, expected values are below 5 hence approximation may be inaccurate. Use Fisher's exact test

#### Model structure #####

# Run Fisher's test (because expected values are less than 5)
dat1 <- table(tb11$Calibration.algorithm.Family, tb11$Model.type)
test1 <- fisher.test(dat1)
test1$data.name


# Fisher's exact test plot
# create dataframe from contingency table
x <- c()
for (row in rownames(dat1)) {
  for (col in colnames(dat1)) {
    x <- rbind(x, matrix(rep(c(row, col), dat1[row, col]), ncol = 2, byrow = TRUE))
  }
}
df <- as.data.frame(x)
colnames(df) <- c("Calibration method", "Model structure")
df

# Combine plot and statistical test with ggbarstats
png("figs/calibration-method-with-model-structure-3.png", res = 300, height = 5.79, width = 8.69, units = "in")
ggbarstats(
  df, `Calibration method`, `Model structure`,
  results.subtitle = FALSE,
  ylab = "Percentage of models",
  package = "colorBlindness",
  palette = "paletteMartin"
) +
  theme( 
    axis.title = element_text(size = 16),  # Axis titles 
    axis.text = element_text(size = 14),   # Axis tick labels 
    legend.title = element_text(size = 14), # Legend title 
    legend.text = element_text(size = 12) )  # Legend text)
dev.off()





#### Model stochasticity ####


# Subset to include only top calibration methods with at least 20 models in each 
tb12 <- tb1[tb1$Calibration.algorithm.Family%in%
              c("Approximate Bayesian Computation (ABC)",
                "Markov Chain Monte Carlo",
                "Least squares estimation",
                "Maximum likelihood estimation") & tb1$Stochasticity.in.model %in% c("Deterministic model", "Stochastic model"), ]
tb12

# Run Fisher's test 
dat2 <- table(tb12$Calibration.algorithm.Family, tb12$Stochasticity.in.model)
dat2
test2 <- chisq.test(dat2)
test2$expected
sum(dat2)


# Plot
# create dataframe from contingency table
x <- c()
for (row in rownames(dat2)) {
  for (col in colnames(dat2)) {
    x <- rbind(x, matrix(rep(c(row, col), dat2[row, col]), ncol = 2, byrow = TRUE))
  }
}
df2 <- as.data.frame(x)
colnames(df2) <- c("Calibration method", "Model stochasticity")
df2

# Combine plot and statistical test with ggbarstats

png("figs/calibration-method-with-model-stochasticity-3.png", res = 300, height = 5.79, width = 8.69, units = "in")
 ggbarstats(
  df2, `Calibration method`, `Model stochasticity`,
  results.subtitle = FALSE,
  ylab = "Percentage of models",
  package = "colorBlindness",
  palette = "paletteMartin"
)+
  theme( 
    axis.title = element_text(size = 16),  # Axis titles 
    axis.text = element_text(size = 14),   # Axis tick labels 
    legend.title = element_text(size = 14), # Legend title 
    legend.text = element_text(size = 12) )  # Legend text)
dev.off()

