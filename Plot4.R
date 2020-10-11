#Across the United States, how have emissions from coal
#combustion-related sources changed from 1999-2008?
library(dplyr)
library(base)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]
png("plot4.png",width=480,height=480)
ggp <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
print(ggp)
dev.off()