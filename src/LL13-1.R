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
library(vegan)
library(raster)
library(rgdal)


#### Pre-process data set ######################################################
data_2007_spatial <- readOGR(paste0(in_path, "IE_2007_pontos_esp.shp"),
                     "IE_2007_pontos_esp")

#only data with correct height information
data_2007_spatial <- data_2007_spatial[data_2007_spatial$ALT_GPS_M>0,]

#convert from factor to numeric
data_2007_spatial$CYD_OBL <- as.numeric(data_2007_spatial$CYD_OBL)

# calculate richness
# data_2007_spatial <- data_2007_spatial[-57,] 
data_2007_spatial_species <- data_2007_spatial[,14:89]

# Load NDVI and DEM and resample DEM to NDVI resolution
ndvi <- raster(paste0(raster_path, "NDVI_fogo_landsat.tif"))

data_2007_spatial$NDVI <- extract(ndvi, data_2007_spatial)

data_2007_df <- data.frame(data_2007_spatial)
data_2007_species_df <- data.frame(data_2007_spatial_species)

#### Compute and visualize ordination ##########################################
ordination<-cca(data_2007_species_df ~ 
                  NDVI + ALT_ALT_M + DECL_GR + EXP_GR + MAT_ORG, 
                data = data_2007_df, na.action = na.omit)

plot(ordination)

tiff(paste0(out_path, analysis_id, "ordination.tiff"),
     compression = "lzw")
plot(ordination, type="n")
points(ordination, pch=21, col="red", bg="yellow", cex=0.8)
text(ordination, "species", col="blue", cex=0.5)
text(ordination, dis="cn", cex = 0.8)
dev.off()
anova(ordination,by="terms",permu=999)
summary(ordination)

# Default plot of the previous using identify to label selected points
## Not run: 
ordiplot(ordination)
identify(fig, "spec")


