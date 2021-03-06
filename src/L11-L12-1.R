#  Anaysis of biodiversity data from fogo natural park as part of BIS-Fogo
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
#  The script analysis a 2002 field survey data set from Fogo's natural park
#  following the syllabus of the 2014 post-graduate school on ecological
#  analysis using R.
#
rm(list = ls(all = T))


#### Define Working directory ##################################################
working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2002/procd/")
raster_path <- paste0(working_directory,"data/remote-sensing/procd/")
out_path <- paste0(working_directory,"analysis/")
analysis_id <- "fc2002"


#### Set working direcory and load required libraries ##########################
setwd(working_directory)
analysis_id <- paste0(analysis_id, "_")
library(car)
library(sp)
library(raster)
library(rgdal)
library(car)


#### Pre-process data set ######################################################
data_2007 <- readOGR(paste0(in_path, "IE_2007_pontos_esp.shp"),
                     "IE_2007_pontos_esp")

#only data with correct height information
data_2007 <- data_2007[data_2007$ALT_GPS_M>0,]

#convert from factor to numeric
data_2007$CYD_OBL <- as.numeric (data_2007$CYD_OBL)

# calculate richness
richness <- rowSums(data_2007@data[,14:89])

# Load NDVI and DEM and resample DEM to NDVI resolution
ndvi <- raster(paste0(raster_path, "NDVI_fogo_landsat.tif"))
dem <- raster(paste0(raster_path, "dem_fogo.tif"))
dem <- resample(dem,ndvi)

tiff(paste0(out_path, analysis_id, "DEM_and_survey_plots.tiff"),
     compression = "lzw")
plot(dem, main = "DEM with locations of survey plots")
plot(data_2007,add =T)
dev.off()

tiff(paste0(out_path, analysis_id, "DEM_and_survey_plots_zoom.tiff"),
     compression = "lzw")
# e <- extent(data_2007)
e <- extent(120000, 121000, 27300, 28000)
zoom(dem,ext=e, main = "Zoom into DEM with locations of survey plots")
plot(data_2007,add =T)
dev.off()


#### Extract raster values at points  ##########################################
ndvi_at_points <- extract(ndvi,data_2007)
dem_at_points <- extract(dem,data_2007)


####Plot relationships  ########################################################
linear_model <- lm(richness ~ ndvi_at_points)
tiff(paste0(out_path, analysis_id, "prich_vs_NDVI.tiff"),
     compression = "lzw")
plot(ndvi_at_points, richness,
     xlab="NDVI", ylab="Plant richness", 
     main = "Plant richness vs. NDVI")
regLine(linear_model)
dev.off()


linear_model <- lm(richness ~ dem_at_points)
tiff(paste0(out_path, analysis_id, "prich_vs_DEM.tiff"),
     compression = "lzw")
plot(dem_at_points, richness,
     xlab="Elevation from DEM in m", ylab="Plant richness", 
     main = "Plant richness vs. DEM elevation")
regLine(linear_model)
dev.off()


#### Do regression RICHNESS ~ dem+ndvi  ########################################
linear_model <- lm(richness ~ ndvi_at_points + dem_at_points)
summary(linear_model)

intercept=linear_model$coefficients[1]
slope_ndvi=linear_model$coefficients[2]
slope_dem=linear_model$coefficients[3]


#### Predict on whole Raster  ##################################################
tiff(paste0(out_path, analysis_id, "prich_predict_lm_NDVI_DEM.tiff"),
     compression = "lzw")
predicted_richness <- slope_ndvi*ndvi+slope_dem*dem+intercept
plot(predicted_richness, 
     main = "Prediction of plant species richness",
     sub = "Basis: Multiple regression model using NDVI and DEM values")
dev.off()
