#  Example solution of W10-1 from the BIS-Fogo school 2014
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
#  The script reads and plots spatial vector and raster data.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2014/procd/")
raster_path <- paste0(working_directory,"data/remote-sensing/procd/")
out_path <- paste0(working_directory,"analysis/")
setwd(working_directory)


#### Load required packages ####################################################
library(rgdal)
library(raster)
library(plotKML)


#### Read the shapefile ########################################################
spatial_data_2014 <- readOGR(paste0(in_path,
                                    "data_2014_subset1.shp"),"data_2014_subset1")


#### Get information of the shapefile  
print (spatial_data_2014)


#### add a NDVI RasterLayer  ###################################################
#read data
ndvi <- raster(paste0(raster_path, "NDVI_fogo_landsat.tif"))


#### add a DEM RasterLayer  ###################################################
#read data
dem <- raster(paste0(raster_path, "dem_fogo.tif"))


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
setwd(out_path)
plotKML(spatial_data_2014["COVRG"])
plotKML(ndvi)

