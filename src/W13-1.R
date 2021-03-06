#  Example solution of W13-1 from the BIS-Fogo school 2014
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
#  The script does a ordination analysis for plant and animal species.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################

working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2014/procd/")
out_path <- paste0(working_directory,"analysis/")
script_path <- paste0(working_directory, "scripts/school-2014/src")
setwd(working_directory)


#### Load required packages ####################################################
library(vegan)
library(raster)
library(rgdal)

#### Read table ################################################################
animal_species <- read.table(paste0(in_path, "animal_species2014.csv"), 
                        sep = ",", dec = ".", header = TRUE)

plant_species <- read.table(paste0(in_path, "plant_species2014.csv"), 
                                 sep = ",", dec = ".", header = TRUE)

spatial_data_2014 <- readOGR(paste0(in_path,
                                    "data_2014_subset1.shp"),"data_2014_subset1")

#### Do a subsetof the plant species ###########################################

substring_plants <- substr(names(plant_species),nchar(names(plant_species))-2,nchar(names(plant_species)))

plant_species_nat <- plant_species[,substring_plants=="NAT"]
plant_species_agr <- plant_species[,substring_plants=="AGR"]

#### include ndvi as predictor variable ########################################

ndvi <- raster(paste0(in_path,"NDVI_fogo_landsat.tif"))
spatial_data_2014$ndvi <- extract(ndvi,spatial_data_2014)


#### convert it to a data.frame ################################################
#Ordination doesn't support shapefile data. 
data_2014=data.frame(spatial_data_2014)

### Do the ordination ##########################################################

#for all plant species
ordination <- cca(plant_species~ELEV+COVRG+ndvi,data=data_2014,na.action=na.omit)
plot(ordination)
anova(ordination,by="terms",permu=999)

#for nat species
ordination <- cca(plant_species_nat~ELEV+COVRG+ndvi,data=data_2014,
                  na.action=na.omit,
                  subset=which(rowSums(plant_species_nat)>0))
plot(ordination)
anova(ordination,by="terms",permu=999)

#for agr species
ordination <- cca(plant_species_agr~ELEV+COVRG+ndvi,data=data_2014,
                  na.action=na.omit,
                  subset=which(rowSums(plant_species_agr)>0))
plot(ordination)
anova(ordination,by="terms",permu=999)


#for all animals
ordination <- cca(animal_species~ELEV+COVRG+ndvi+NAT+AGR,data=data_2014,
                  na.action=na.omit,
                  subset=which(rowSums(animal_species)>0))
plot(ordination)
anova(ordination,by="terms",permu=999)

