#  Example solution of W12-1 from the BIS-Fogo school 2014
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
#  The script shows how to subset data frames.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################

working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/"
in_path <- paste0(working_directory,"data/procd/")
out_path <- paste0(working_directory,"analysis/")
script_path <- "D:/bis-fogo/school2014/scripts/"
setwd(working_directory)

#### Read table ################################################################
data_2014 <- read.table(paste0(inpath, "fieldSurvey2014_Subset01.csv"), 
                        sep = ",", dec = ".", header = TRUE)


#### SRows with a coverage more than 50 % ####################################
data_2014[data_2014$COVRG>50,]

#### Rows with more natural species than agrar species ##############
data_2014[data_2014$NAT>data_2014$AGR,]

#### Rows with COVRG smaller than 5 and Elevation under 1800m##############
data_2014[data_2014$NAT>data_2014$AGR & data_2014$ELEV<1800,]

#### Subsetting Rows where animals have been recorded ##########################
data_2014[!is.na(data_2014$ANIMALS),]
