#  Example solution of W09-1 from the BIS-Fogo school 2014
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
#  The script predicts the animal abundance for all field survey sites of the
#  2014 survey.
#
rm(list = ls(all = T))

#### Load required packages ####################################################

library(rgdal)
library(raster)

#### Define Working directory ##################################################

working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/procd/"
setwd(working_directory)

#### Read the shapefile ########################################################

spatial_data_2014 <- readOGR("data_2014_subset1.shp","data_2014_subset1")

#### Get information of the shapefile  

print (spatial_data_2014)

#### add a NDVI RasterLayer  ###################################################

#read data
ndvi <- raster("NDVI_fogo.tif")

#### add a DEM RasterLayer  ###################################################

#read data
dem <- raster("dem_fogo.tif")

#### Get information of the raster
print (ndvi)
print(dem)

#### Plot spatial data  ########################################################

plot(ndvi)
plot(spatial_data_2014,add =T)

#zoom do extent of the points
zoom(ndvi,ext=extent(spatial_data_2014))
plot(spatial_data_2014,add =T)

#### Plot data in google earth  ################################################

plotKML(spatial_data_2014["COVRG"])
plotKML(ndvi)
