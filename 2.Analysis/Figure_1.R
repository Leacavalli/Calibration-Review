# load libraries
library(xlsx)
library(khroma)
library(cowplot)

# load data
setwd("~/GitHub/Calibration-Review/3.Results/Tables")
Table3 <- read.xlsx("Sheet S3.xlsx", sheetName ="Table 3")

## Histogram 
Fig1 <- Table3 |>
  ggplot() +
  geom_bar(aes(x = as.numeric(Sum_Reporting_Score), fill = Reporting_comprehensiveness), stat = "count", color = "black") +
  xlab("Reporting Score") +
  ylab("Number of Models") +
  scale_fill_manual(name = "Reporting comprehensiveness", values = color("light")(4)) +  
  scale_x_continuous(breaks = c(0:15), limits = c(0, 16)) +
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
  ) +
  scale_y_continuous(breaks = seq(0, 100, by = 5))  # Add breaks at multiples of 5 for better control


Fig1


# Save 
setwd("~/GitHub/Calibration-Review/3.Results/Figures")
ggsave("Figure_1.tiff", units="in", width=10, height=6, dpi=300, compression = 'lzw')
Fig1
dev.off()
