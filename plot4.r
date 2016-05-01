"Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?"
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
# display groups 
table(scc[,4])
# 3 groups are corresponding to coal combustion
x= subset(scc,scc[,4]=="Fuel Comb - Electric Generation - Coal")
y= subset(scc,scc[,4]=="Fuel Comb - Industrial Boilers, ICEs - Coal")
z= subset(scc,scc[,4]=="Fuel Comb - Comm/Institutional - Coal")
# make a df with corresponding scc
x= rbind(x,y,z)
# make a search vector and select all corresponding rows from nei
v= as.vector(x$SCC)
xx= nei[nei$SCC %in% v, ]
#collapse factors
aggdata= aggregate(xx$Emissions, by=list(xx$year),FUN=sum)
#add names
names(aggdata)=c("year","total")
#plot
qplot(year, total, data = aggdata, geom = c("point","line"), ylab = "Emission from coal")
dev.copy(png, "plot4.png")
dev.off()

