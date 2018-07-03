setwd('/Users/fsmoura/Documents/protasio_alves/')
list.files()
prot_alv =  read.csv("acidentes-2016.csv", sep = ";", header = TRUE)
prot_alv$ID = NULL; prot_alv$QUEDA_ARR = NULL
dim(prot_alv)

prot_alv = subset(prot_alv, LOG1=="AV PROTASIO ALVES")
dim(prot_alv)
prot_alv_corred = subset(prot_alv, prot_alv$CORREDOR==1)
dim(prot_alv_corred)
prot_alv_coletivo = subset(prot_alv, prot_alv$CONSORCIO!="")
dim(prot_alv_coletivo)
names(prot_alv)
head(prot_alv)

library(ggplot2)
library(ggthemes)
library(viridis) # devtools::install_github("sjmgarnier/viridis)
library(ggmap)
library(scales)
library(grid)
library(dplyr)
library(gridExtra)
library(leaflet.extras)
mh_map_set_dois = get_googlemap(center = c(-51.155421939611394, -30.06753685571282), zoom = 12, source="osm",
                                color = "color",
                                source = "google",
                                maptype = "roadmap")
mapPoints <- ggmap(mh_map_set_dois)
mapPoints
##Mapa de pontos
mapPoints <- ggmap(mh_map_set_dois) + 
  geom_point(data = prot_alv, aes(x = LONGITUDE, y = LATITUDE), 
             fill = "red", alpha =0.2, size = 0.5, shape = 21,stroke = 0) + 
  scale_fill_gradient(low = "yellow", high = "red") + 
  ggtitle("Acidentes Av. Protasio Alves 2016")
mapPoints

leaflet(prot_alv) %>%
  addTiles(group="OSM") %>%
  addCircles(prot_alv$LONGITUDE, prot_alv$LATITUDE, popup=prot_alv$TIPO_ACID,  weight = 0.1, radius=4, color="red", stroke = TRUE, fillOpacity = 0.8) %>% 
  addLegend("bottomright", colors= "#ffa500", labels="Av. Protasio Alves", title="Acidentes:")

origAddress <- prot_alv
origAddress$addresses <- paste(prot_alv$LOG1, prot_alv$PREDIAL1, sep = "; ")
head(origAddress)

