#Of the four types of sources indicated by the \color{red}{\verb|type|}type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources have seen 
#decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases 
#in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question
setwd('d:/Desk/exdata_data_NEI_data')
library(ggplot2)
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
BaltimoreData <- NEI[NEI$fips == '24510', ]
sumEmissions <- aggregate(Emissions~(year+type), BaltimoreData, sum)
png("plot3.png",480,480)
ggp <- ggplot(sumEmissions,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)
dev.off()
