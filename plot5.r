"How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?"
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
xx=nei
xx= subset(xx,xx[,1] =="24510")
# display groups 
table(scc[,4])
# 4 groups are corresponding to coal combustion
x= subset(scc,scc[,4]==" Mobile - On-Road Diesel Heavy Duty Vehicles")
y= subset(scc,scc[,4]=="Mobile - On-Road Diesel Light Duty Vehicles")
z= subset(scc,scc[,4]=="Mobile - On-Road Gasoline Heavy Duty Vehicles")
w= subset(scc,scc[,4]=="Mobile - On-Road Gasoline Light Duty Vehicles")
# make a df with corresponding scc
x= rbind(x,y,z,w)
# make a search vector and select all corresponding rows from nei
v= as.vector(x$SCC)
xx= xx[xx$SCC %in% v, ]
#collapse factors
aggdata= aggregate(xx$Emissions, by=list(xx$year),FUN=sum)
#add names
names(aggdata)=c("year","total")
#plot
qplot(year, total, data = aggdata, geom = c("point","line"), ylab = "Emission from Vechiles")
dev.copy(png, "plot5.png")
dev.off()
