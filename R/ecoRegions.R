# shapefiles found at: https://www.arcgis.com/home/item.html?id=be0f9e21de7a4a61856dad78d1c79eae
library(rgdal)
library(rgeos)
library(raster)

ecoreg <- readOGR(dsn='data', layer='wwf_terr_ecos')
bound <- gUnionCascaded(ecoreg)

names(ecoreg@data)
dim(ecoreg@data)
id_des <- grepl(ecoreg@data$ECO_NAME, pattern='desert')
id_tou <- grepl(ecoreg@data$ECO_NAME, pattern='tundra')
id_rai <- grepl(ecoreg@data$ECO_NAME, pattern='rain forests')
id_moi <- grepl(ecoreg@data$ECO_NAME, pattern='moist forests')
id_for <- grepl(ecoreg@data$ECO_NAME, pattern='forests')

ecoreg@data$ECO_NAME[grepl(ecoreg@data$ECO_NAME, pattern='desert')]

sum(id_tou)
coordinates(ecoreg) %>% head

palette(c( "#3fb3b2", "#ffdd55", "#c7254e", "#1b95e0", "#8555b4", "#8ddd75"))


png(file = 'img/ecoreg.png', width=8, height=5, units='in', res=300)
par(bg=NA, mar=rep(.5, 4))
##
plot0(range(coordinates(ecoreg)[,1L]), range(coordinates(ecoreg)[,2L])+c(10000000,0))
plot(bound, lwd=.4, border='white', add=T)
plot(ecoreg[id_des,], border=NA, add=T, col=2)
plot(ecoreg[id_tou,], border=NA, add=T, col=4)
# plot(ecoreg[id_rai,], border=NA, add=T, col=6)
# plot(ecoreg[id_moi,], border=NA, add=T, col=6)
plot(ecoreg[id_for,], border=NA, add=T, col=6)
dev.off()
##
