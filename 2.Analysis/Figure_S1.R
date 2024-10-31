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

# Make figure
set.seed(1234)
col_1d <- sample(color("discrete rainbow")(15))
FigS1 <- clean_data |> 
  separate_rows(Type.of.data.used.for.defining.calibration.targets..select.all.that.apply., sep = "; ")|> 
  mutate(Type.of.data.used.for.defining.calibration.targets..select.all.that.apply. = ifelse(grepl("Contact/exposure", Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.), "Contact/exposure", 
                                                                                             ifelse(grepl("Treatment and treatment outcomes", Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.), "Treatment and outcomes", 
                                                                                                    ifelse(grepl("Demographic", Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.), "Demographic", 
                                                                                                           ifelse(grepl("Climate", Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.), "Climate", Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.)))))|>
  mutate( Type.of.data.used.for.defining.calibration.targets..select.all.that.apply. = fct_infreq(Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.),  
          Type.of.data.used.for.defining.calibration.targets..select.all.that.apply. = fct_relevel(Type.of.data.used.for.defining.calibration.targets..select.all.that.apply., after = Inf)) |>
  ggplot(aes(x=Type.of.data.used.for.defining.calibration.targets..select.all.that.apply., fill = Type.of.data.used.for.defining.calibration.targets..select.all.that.apply.))+
  geom_bar(color="black") +
  xlab("Type of data") +
  ylab("Number of Models") +
  scale_fill_manual(values = col_1d) +
  theme_minimal() +  # Using theme_minimal as the base
  theme(
    axis.title = element_text(size = 10, face = "bold"),      # Bold axis titles
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
  theme(legend.position = "none")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_y_continuous(breaks = seq(0, 210, by = 10))  # Add breaks at multiples of 5 for better control
FigS1


# Save
setwd("~/GitHub/Calibration-Review/3.Results/Figures")
ggsave("Figure_S1.tiff", units="in", width=8, height=6, dpi=300, compression = 'lzw')
FigS1
dev.off()
