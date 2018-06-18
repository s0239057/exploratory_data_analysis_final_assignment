# PLOT_6 - Compare motor emissions between Baltimore and LA

library(ggplot2)

NEI <- readRDS("./assignment/summarySCC_PM25.rds")
SCC <- readRDS("./assignment/Source_Classification_Code.rds")

SCCMotVeh <- SCC[(grepl("Motor|Vehicle", SCC$Short.Name, ignore.case=TRUE)),]
NEI_MotVeh = merge(NEI, SCCMotVeh, by = "SCC")

NEI_MotVeh_Baltmore <- subset(NEI_MotVeh, fips=="24510" & type=="ON-ROAD")  # Baltimore
NEI_MotVeh_LA <- subset(NEI_MotVeh, fips=="06037" & type=="ON-ROAD")  # LA

sumEmissionsMV_BA <- as.numeric(with(NEI_MotVeh_Baltmore, tapply(Emissions, year, sum, simplify = FALSE)))
sumEmissionsMV_LA <- as.numeric(with(NEI_MotVeh_LA, tapply(Emissions, year, sum, simplify = FALSE)))

sumEmissionsMV_BA.df <- data.frame(Emissions = sumEmissionsMV_BA, Year = unique(NEI$year))
sumEmissionsMV_LA.df  <- data.frame(Emissions = sumEmissionsMV_LA, Year = unique(NEI$year))

# paste and rbind

sumEmissionsMV_BA.df$city <- rep("Baltimore", nrow(sumEmissionsMV_BA.df))
sumEmissionsMV_LA.df$city <- rep("Los Angeles", nrow(sumEmissionsMV_LA.df))

TotsumEmissionsMV <- rbind(sumEmissionsMV_BA.df, sumEmissionsMV_LA.df)

png('plot6.png')
ggplot(TotsumEmissionsMV, aes(Year, Emissions, color = city)) + geom_point()
dev.off()