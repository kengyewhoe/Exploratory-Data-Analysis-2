
#Q1 Have total emissions from PM2.5 decreased 
#in the United States from 1999 to 2008? Using the base 
#plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 
#2002, 2005, and 2008
setwd('d:/Desk/exdata_data_NEI_data')
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
Totals <- aggregate(Emissions ~ year,NEI,sum)
png("plot1.png", 480, 480)
barplot(Totals$Emissions/10^6, names.arg= Totals$year,
        xlab= "Year", ylab = "PM2.5 Emissions (10^6 tons)", 
        main = "Total PM2.5 Emissions - All United States",
        ylim = c(0,8))
dev.off()
