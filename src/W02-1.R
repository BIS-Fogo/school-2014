#  Example solution of W02-1 from the BIS-Fogo school 2014
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
#  The script reads a CSV file and shows some data frame handling
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2014/procd/")
out_path <- paste0(working_directory,"analysis/")
setwd(working_directory)


#### Read a table ################################################################
data_2014 <- read.table(paste0(in_path, "fieldSurvey2014_Subset01.csv"), 
                        sep = ",", dec = ".", header = TRUE)


#### First look at the data ####################################################
head(data_2014) #first entries
str(data_2014) #structure of the data set
names(data_2014) #column names
summary(data_2014) # statistical summary


#### Access to values from the table ###########################################
### first row:
data_2014[1,]
### first column
data_2014[,1]
### first value of first column
data_2014 [1,1]
### first ten values of first column
data_2014[1:10,1]
### alternatively for accessing columns use the column name:
data_2014[,3]
# which is the same as:
data_2014$COVRG

