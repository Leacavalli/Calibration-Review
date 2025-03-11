# load libraries
library(xlsx)
library(khroma)
library(cowplot)
library(tidyverse)

# load data
setwd("~/GitHub/Calibration-Review/3.Results/Tables")
Table3 <- read.xlsx("Sheet S3.xlsx", sheetName ="Table 3") |> 
  

## Histogram 
Fig1 <- Table3 |>
  mutate(Reporting_comprehensiveness= factor(Reporting_comprehensiveness, levels=c("Excellent", "High", "Fair", "Low"))) |>
  ggplot() +
  geom_bar(aes(x = as.numeric(Sum_Reporting_Score), fill = Reporting_comprehensiveness), stat = "count", color = "black") +
  xlab("Reporting Score") +
  ylab("Number of Models") +
  scale_fill_manual(name = "Reporting comprehensiveness", values = color("light")(4)) +  
  scale_x_continuous(breaks = c(0:15), limits = c(0, 16)) +
  theme_minimal() +  # Using theme_minimal as the base
  theme(
    axis.title = element_text(size = 15, face = "bold"),      # Bold axis titles
    legend.title = element_text(size = 15, face = "bold"),      # Bold axis titles
    legend.text  = element_text(size = 15),    # Bold legend title
    axis.ticks = element_line(color = "black"),               # Show axis ticks in black
    axis.ticks.length = unit(0.2, "cm"),                      # Length of the ticks
    axis.text = element_text(size = 15),                      # Size of the tick labels
    
    # Customizing horizontal grid lines
    panel.grid.major.y = element_line(color = "grey", size = 0.5),       # Major horizontal lines (multiples of 10) thicker
    panel.grid.minor.y = element_line(color = "grey", size = 0.25),      # Minor horizontal lines (multiples of 5) thinner
    
    # Remove vertical grid lines
    panel.grid.major.x = element_blank(),                      # Remove major vertical grid lines
    panel.grid.minor.x = element_blank()                       # Remove minor vertical grid lines
  ) +
  scale_y_continuous(breaks = seq(0, 100, by = 5))  # Add breaks at multiples of 5 for better control


Fig1


# Save 
setwd("~/GitHub/Calibration-Review/3.Results/Figures")
ggsave("Figure_1.tiff", units="in", width=10, height=6, dpi=300, compression = 'lzw')
Fig1
dev.off()



# Load data
setwd("~/GitHub/Calibration-Review/1.Data Cleaning")
clean_data <- read.csv("Clean_data.csv")

# join data
joined_data <- left_join(Table3 |>
                           filter(Reporting_comprehensiveness!="")|>  
                           select(Study.Title, Reporting_comprehensiveness)|>
                           mutate(Reporting_comprehensiveness = factor(Reporting_comprehensiveness, 
                                                                       levels = c("Excellent", "High", "Fair", "Low"))), 
                         clean_data |> 
                           select(Full.title,Year.published) |> 
                           rename("Study.Title"="Full.title"))

# Calculate proportions for Reporting_comprehensiveness per year
proportion_data <- joined_data |>
  group_by(Year.published, Reporting_comprehensiveness) |>
  summarize(Count = n(), .groups = "drop") |>
  group_by(Year.published) |>
  mutate(Proportion = Count / sum(Count))

# Calculate total counts per year
total_counts <- proportion_data |>
  group_by(Year.published) |>
  summarize(Total = sum(Count), .groups = "drop")

# Generate a vector of all years in the dataset
all_years <- sort(unique(proportion_data$Year.published))

# Plot
Sup_Fig <- ggplot(proportion_data, aes(x = Year.published, y = Proportion, fill = Reporting_comprehensiveness)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5), size = 3) +
  geom_text(data = total_counts, aes(x = Year.published, y = -0.05, label = paste0("n=", Total)), inherit.aes = FALSE, size = 3.5) +
  xlab("Year Published") +
  ylab("Proportion of Studies") +
  scale_x_continuous(breaks = all_years) +
  scale_fill_manual(name = "Reporting comprehensiveness", values = color("light")(4)) +
  scale_y_continuous(expand = c(0, 0), limits = c(-0.1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Using theme_minimal as the base
  theme(
    axis.title = element_text(size = 15, face = "bold"),      # Bold axis titles
    legend.title = element_text(size = 15, face = "bold"),      # Bold axis titles
    legend.text  = element_text(size = 15),    # Bold legend title
    axis.ticks = element_line(color = "black"),               # Show axis ticks in black
    axis.ticks.length = unit(0.2, "cm"),                      # Length of the ticks
    axis.text = element_text(size = 15),                      # Size of the tick labels
    
    # Customizing horizontal grid lines
    panel.grid.major.y = element_line(color = "grey", size = 0.5),       # Major horizontal lines (multiples of 10) thicker
    panel.grid.minor.y = element_line(color = "grey", size = 0.25),      # Minor horizontal lines (multiples of 5) thinner
    
    # Remove vertical grid lines
    panel.grid.major.x = element_blank(),                      # Remove major vertical grid lines
    panel.grid.minor.x = element_blank()                       # Remove minor vertical grid lines
  )



# Save 
setwd("~/GitHub/Calibration-Review/3.Results/Figures")
ggsave("Figure_SX.tiff", units="in", width=10, height=6, dpi=300, compression = 'lzw')
Sup_Fig
dev.off()

