library(shiny)
library(ggplot2)
library(reshape2)
library(dplyr)
library(plyr)

# Please note: The raw data sets below and some, but not all, of the pre-processing steps
# were taken from Brian Connelly and his blog at:
# http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/)

raw <- read.csv("raw.csv")
# Create long-form data frame
melted <- melt(raw, id=c("Time", "Temperature"), variable.name="Well",
               value.name="OD600")

# Read in platemap file
platemap <- read.csv("platemap.csv")

# Combine datasets by the "Well" column
annotated <- merge(melted, platemap, by = "Well")

# Group the Strain, Environment and Time variables and summarize data
grouped2 <- ddply(annotated, c("Strain","Environment", "Time") , summarise, N=length(OD600), Average=mean(OD600), StDev=sd(OD600))

# Filter out NAs
statsFinal <- grouped2[(!is.na(grouped2$Strain)),]

# Time is in minutes, let's change to hours 
statsFinal$Time <- statsFinal$Time/3600

# Changing the name of column 5 to absorbance will make it easier to graph
colnames(statsFinal)[5] <- "Absorbance"


