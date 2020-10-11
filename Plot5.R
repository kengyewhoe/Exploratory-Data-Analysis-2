#How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City?
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
mobile <- grepl("mobile", SCC$EI.Sector, ignore.case=TRUE)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
mobileVehicles <- (mobile & vehicles)
vehiclesSCC <- SCC[mobileVehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
vehiclesNEI$year <- as.factor(vehiclesNEI$year)
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510",]
agg <- aggregate(Emissions~year, baltimoreVehiclesNEI, sum)
png("plot5.png", width=480, height=480)
ggplot(agg, aes(y=Emissions, x=year)) + 
  geom_bar(stat="identity",fill= "grey", width=0.75) + guides(fill = FALSE)+
  ggtitle("Total PM2.5 Emissions - Baltimore City, MD", 
          subtitle = "By Motor Vehicles") +
  labs(x = "Year", y = "PM2.5 Emissions (Tons)")
dev.off()
