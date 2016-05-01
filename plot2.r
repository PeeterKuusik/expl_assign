"Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510)
from 1999 to 2008?
Use the base plotting system to make a plot answering this question."

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
#look data structure
str(nei)
# make spare (just in case)
x=nei
x= subset(x,x[,1] =="24510")
#make year a factor
x[,6]=as.factor(x[,6])
x=data.frame(tapply(x$Emissions, x$year, sum), unique(x$year))
names(x)= c("emission.total","year")
x[,2]=as.Date(x[,2],"%Y")
#make plot
plot(x[,2],x[,1],xlab= "Year", ylab = "PM2.5 emission", main = "Total PM2.5 emission for Baltimore in years 1999-2008")
lines(x$year, x$emission.total, col = "red")
dev.copy(png, "plot2.png")
dev.off()