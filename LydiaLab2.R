### Lydia's work for lab 2 ## 
library(tidyverse)
library(sf)
library(maptools)

# practice script

p <- ggplot() +
  geom_sf(data = read_sf("data/ME-GIS/Coastline2.shp"), 
          colour="grey10", fill="grey90") +
  geom_sf(data = read_sf("data/ME-GIS/Rivers19.shp"), 
          colour="steelblue", size=0.3) +
  geom_sf(data = read_sf("data/ME-GIS/PrimaryRoads.shp"), 
          size = 0.7, colour="grey30") +
  geom_sf(data = read_sf("data/ME-GIS/Cities.shp")) +
  theme_bw()
p

ozbig <- read_sf("data/gadm36_AUS_shp/gadm36_AUS_1.shp")
oz_st <- maptools::thinnedSpatialPoly(
  as(ozbig, "Spatial"), tolerance = 0.1, 
  minarea = 0.001, topologyPreserve = TRUE)
oz <- st_as_sf(oz_st)
oz
str(oz$geometry)
head(oz$geometry)[[1]]
head(oz$geometry)[[1]][[7]] # second part goes from 1 - 7
head(oz$geometry[[1]][[3]][[1]])


test <- oz$geometry %>%
  map_depth(3, data.frame) %>%
  flatten()

# this works for one polygon - need to map across all polygons
oz$geometry[[1]] %>%
  map_depth(2, data.frame) %>%
  flatten()%>%
  bind_rows(.id = "id")

data <- oz$geometry %>%
  map_depth(3, data.frame) %>%
  flatten()%>%
  flatten()%>%
  bind_rows(.id = "id")



# 11 polygons - each polygon is a series of lists  
str(oz$geometry[[2]])

ozplus %>% ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()