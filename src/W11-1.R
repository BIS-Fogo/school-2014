#  Example solution of W11-1 from the BIS-Fogo school 2014
#
#  Copyright (C) 2014 Hanna Meyer, Alice Ziegler, Vanessa Wilzek, Thomas Nauss
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  Please send any comments, suggestions, criticism, or (for our sake) bug
#  reports to admin@environmentalinformatics-marburg.de
# 
#  Details:
#  The script predicts the area-wide animal abundance.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/"
in_path <- paste0(working_directory,"data/procd/")
out_path <- paste0(working_directory,"analysis/")
setwd(working_directory)


#### Load required packages ####################################################
library(rgdal)
library(plotKML)
library(raster)


#### Read spatial data ########################################################
spatial_data_2014 <- readOGR(paste0(inpath,
                                    "data_2014_subset1.shp","data_2014_subset1"))
ndvi <- raster(paste0(inpath,"NDVI_fogo_landsat.tif"))
dem <- raster(paste0(inpath,"dem_fogo.tif"))


#### Extract raster values at points  ##########################################
ndvi_at_points <- extract(ndvi,spatial_data_2014)
dem_at_points <- extract(dem,spatial_data_2014)


#### Plot relation NDVI~ ANIMALS  ##########################################
plot(spatial_data_2014$ANIMALS ~ ndvi_at_points)


#### Do regression ANIMALS~NDVI+DEM  ##########################################
linear_model <- lm(spatial_data_2014$ANIMALS ~ ndvi_at_points+ dem_at_points)
summary(linear_model)

slope_ndvi=linear_model$coefficients[2]
slope_dem=linear_model$coefficients[3]
intercept=linear_model$coefficients[1]


#### Predict on whole Raster  ##################################################
#first:resample dem to same resolution as ndvi:
dem <- resample(dem,ndvi)
# then predict:
predicted_animals <- slope_ndvi*ndvi+slope_dem*dem+intercept
#plot results:
plot(predicted_animals)