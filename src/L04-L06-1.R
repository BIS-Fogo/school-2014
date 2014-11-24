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
library(sp)
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


#### Linear regression analysis ################################################
# Save scatter plot, compute a linear regression analysis and save combined
# plot
tiff(paste0(out_path, analysis_id, "prich_vs_elev.tiff"),
     compression = "lzw")
plot(data_2007$ALT_GPS_M, richness,
     xlab="Elevation in m", ylab="Plant richness", 
     main = "Plant richness vs. Elevation")
dev.off()

linear_model <- lm(richness ~ data_2007$ALT_GPS_M)
print(linear_model)
summary(linear_model)

#plot distribution of residuals as a QQ-Plot
tiff(paste0(out_path, analysis_id, "prich_vs_elev_lm_qq.tiff"),
     compression = "lzw")
qqPlot(linear_model)
dev.off()

tiff(paste0(out_path, analysis_id, "prich_vs_elev_lm.tiff"),
     compression = "lzw")
plot(data_2007$ALT_GPS_M, richness,
     xlab="Elevation in m", ylab="Plant richness", 
     main = "Plant richness vs. Elevation")
regLine(linear_model)
legend("topright",legend=paste0("y = ", round(linear_model$coefficients[2],3), 
                                " * x + ",
                                round(linear_model$coefficients[1],3)),bty="n")
dev.off()


#### Predict on artificially deselected points #################################
# This is just for illustration purposes as part of the lecture notes.
# The data set is split into training and test data using a 75% random pick
train_numbers <- sample(1:length(richness),length(richness)*0.75)

#predict on test data using the regression equation
linear_model <- lm(richness[train_numbers] ~ data_2007$ALT_GPS_M[train_numbers])
intercept <- linear_model$coefficients[1]
slope <- linear_model$coefficients[2]
animals_predicted <- slope*data_2007$ALT_GPS_M[-train_numbers] + intercept

#plot predicted richness of test data
tiff(paste0(out_path, analysis_id, "prich_vs_elev_lm_predict.tiff"),
     compression = "lzw")
plot(data_2007$ALT_GPS_M, richness,
     xlab="Elevation in m", ylab="Plant richness", 
     main = "Plant richness vs. Elevation")
regLine(linear_model)
legend("topright",legend=paste0("y = ", round(linear_model$coefficients[2],3), 
                                " * x + ",
                                round(linear_model$coefficients[1],3)),bty="n")
points(data_2007$ALT_GPS_M[-train_numbers],animals_predicted,col="blue")
dev.off()

#plot observed species richness of test data
tiff(paste0(out_path, analysis_id, "prich_vs_elev_lm_predict_vs_obs.tiff"),
     compression = "lzw")
plot(data_2007$ALT_GPS_M, richness,
     xlab="Elevation in m", ylab="Plant richness", 
     main = "Plant richness vs. Elevation")
regLine(linear_model)
legend("topright", bty = "n",
       legend=paste0("y = ", round(linear_model$coefficients[2],3), " * x + ",
                                round(linear_model$coefficients[1],3)))
points(data_2007$ALT_GPS_M[-train_numbers],animals_predicted,col="blue")
points(data_2007$ALT_GPS_M[-train_numbers],richness[-train_numbers],col="red")
legend("bottomleft", bty = "n", pch = 1, col = c("black", "blue", "red"), 
       legend = c("training pairs", "predicted values", "observed values"))
dev.off()

prediction_error <- richness[-train_numbers] - animals_predicted
mean(abs(prediction_error),na.rm=T)

linear_model <- lm(animals_predicted ~ richness[-train_numbers])
print(summary(linear_model))
plot(richness[-train_numbers], animals_predicted)
regLine(linear_model)


#### Local regression analysis #################################################

loess_model <- loess(richness ~ data_2007$ALT_GPS_M)
x<-data_2007$ALT_GPS_M
predict.x<-min(x):max(x)

tiff(paste0(out_path, analysis_id, "prich_vs_elev_loess.tiff"),
     compression = "lzw")
plot(data_2007$ALT_GPS_M, richness,
     xlab="Elevation in m", ylab="Plant richness", 
     main = "Plant richness vs. Elevation")
lines(predict.x,predict(loess_model,newdata=predict.x),lwd=2,col="red")
dev.off()
