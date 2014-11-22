library(sp)
library(rgdal)
library(car)

setwd("/home/hanna/Documents/Projects/KapVerde/data/")
data_2007 <- readOGR("IE_2007_pontos_esp.shp", "IE_2007_pontos_esp")
ndvi <- raster("NDVI_fogo_landsat.tif")
dem <- raster("dem_fogo.tif")

#### Process data set ##########################################################
#bring dem to same resolution:
dem <- resample(dem,ndvi)

#convert from factor to numeric
data_2007$CYD_OBL <- as.numeric (data_2007$CYD_OBL)

# calculate richness
richness <- rowSums(data_2007@data[,14:89])

#### Extract raster values at points  ##########################################
ndvi_at_points <- extract(ndvi,data_2007)
dem_at_points <- extract(dem,data_2007)

####Plot relation NDVI ~ Richness  ##########################################
plot(ndvi_at_points,richness)
####Plot relation DEM ~ Richness  ##########################################
plot(dem_at_points,richness)

#### Do regression RICHNESS ~ dem+ndvi  ##########################################
linear_model <- lm(richness ~ ndvi_at_points + dem_at_points)
summary(linear_model)

slope_ndvi=linear_model$coefficients[2]
slope_dem=linear_model$coefficients[3]
intercept=linear_model$coefficients[1]

#### Predict on whole Raster  ##################################################
predicted_richness <- slope_ndvi*ndvi+slope_dem*dem+intercept
plot(predicted_richness)
