#Compare emissions from motor vehicle sources in Baltimore 
#City with emissions from motor vehicle sources in 
#Los Angeles County, California 
#(\color{red}{\verb|fips == "06037"|}fips == "06037"). 
#Which city has seen greater changes over time in motor
#vehicle emissions?
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
mobile <- grepl("mobile", SCC$EI.Sector, ignore.case=TRUE)
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
mobileVehicles <- (mobile & vehicles)
vehiclesSCC <- SCC[mobileVehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
vehiclesNEI$year <- as.factor(vehiclesNEI$year)
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510",]
baltimoreVehiclesNEI$city <- "Baltimore City"

LAVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "06037",]
LAVehiclesNEI$city <- "Los Angeles County"

bothCities <- rbind(baltimoreVehiclesNEI, LAVehiclesNEI)

png("plot6.png",480,480)
ggp <- ggplot(bothCities, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
print(ggp)
dev.off()
