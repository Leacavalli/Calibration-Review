# Clean environment
rm( list = ls() )

# load necessary libraries
library(tidyverse)
library(dplyr)
library(khroma)
library(colorBlindness)

# Load data
setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
clean_data <- read.csv("Clean_data.csv")

# Prepare data 
# Categorise algorithm output size
Calibration_size_df <- clean_data |>
  separate_rows(What.is.the.size.of.the.calibration.output., Name.of.calibration.algorithm,Calibration.algorithm.Family, sep = "; ")|> 
  mutate(size.of.the.calibration.output.reported = ifelse(What.is.the.size.of.the.calibration.output. == "Not reported", "Not reported", "[Number provided]"))|>
  filter(size.of.the.calibration.output.reported != "Not reported") |> 
  mutate(What.is.the.size.of.the.calibration.output.V2= as.numeric(What.is.the.size.of.the.calibration.output.))|> 
  filter( ! is.na(What.is.the.size.of.the.calibration.output.V2))|>
  mutate(size.of.the.calibration.output.CAT = ifelse(What.is.the.size.of.the.calibration.output.V2 ==1, "1", 
                                                     ifelse(What.is.the.size.of.the.calibration.output.V2 <=1000, "2-1000", 
                                                            ifelse(What.is.the.size.of.the.calibration.output.V2 <=2000, "1001-2000", 
                                                                   ifelse(What.is.the.size.of.the.calibration.output.V2 <=3000, "2001-3000", 
                                                                          ifelse(What.is.the.size.of.the.calibration.output.V2 <=4000, "4001-5000", ">5000"))))))|>
  mutate(size.of.the.calibration.output.CAT = factor(size.of.the.calibration.output.CAT, levels=c("1","2-1000","1001-2000","2001-3000","4001-5000", ">5000")))

# Subset data
keep <- (clean_data |> 
           separate_rows(Calibration.algorithm.Family, sep = "; ")|>
           filter(! Calibration.algorithm.Family %in% c("Other ", "Not reported"))|>
           group_by(Calibration.algorithm.Family)|>
           summarise(N=n())|>
           filter(N>=10)|>
           pull(Calibration.algorithm.Family))

# Make figure
FigS5 <- Calibration_size_df |> 
  filter(Calibration.algorithm.Family %in% keep)|>
  group_by(Calibration.algorithm.Family, size.of.the.calibration.output.CAT) |>
  summarise(Count = n(), .groups = 'drop') |>
  filter(size.of.the.calibration.output.CAT != "1")|>
  ggplot(aes(x=size.of.the.calibration.output.CAT, y = Count, fill = Calibration.algorithm.Family)) +
  geom_bar(stat = "identity", color="black") +
  xlab("Size of Calibration Output") +
  ylab("Number of Models") +
  labs(fill ="Calibration Method" ) +
  scale_fill_manual(values = color("muted")(7)) +
  theme_minimal() +  # Using theme_minimal as the base
  theme(
    axis.title = element_text(size = 10, face = "bold"),      # Bold axis titles
    legend.title = element_text(size = 10, face = "bold"),    # Bold legend title
    axis.ticks = element_line(color = "black"),               # Show axis ticks in black
    axis.ticks.length = unit(0.2, "cm"),                      # Length of the ticks
    axis.text = element_text(size = 10),                      # Size of the tick labels
    
    # Customizing horizontal grid lines
    panel.grid.major.y = element_line(color = "grey", size = 0.5),       # Major horizontal lines (multiples of 10) thicker
    panel.grid.minor.y = element_line(color = "grey", size = 0.25),      # Minor horizontal lines (multiples of 5) thinner
    
    # Remove vertical grid lines
    panel.grid.major.x = element_blank(),                      # Remove major vertical grid lines
    panel.grid.minor.x = element_blank()                       # Remove minor vertical grid lines
  )+
  scale_y_continuous(breaks = seq(0, 210, by = 10))  # Add breaks at multiples of 5 for better control
FigS5


# Save
setwd("~/GitHub/Calibration-Review/3.Results/Figures")
ggsave("Figure_S5.tiff", units="in", width=8, height=6, dpi=300, compression = 'lzw')
FigS5
dev.off()
