#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.
setwd('d:/Desk/exdata_data_NEI_data')
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
BaltimoreData <- NEI[NEI$fips == '24510', ]
sumEmissions <- aggregate(Emissions~year, BaltimoreData, sum)
png("plot2.png",480,480)
barplot(sumEmissions$Emissions,
        names.arg = sumEmissions$year,
        xlab = "Year", ylab = "PM2.5 Emissions (Tons)",
        main = "Total PM2.5 Emissions - Baltimore City, MD",
        ylim = c(0,4000))
dev.off()
