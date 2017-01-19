### Team: Kraftfahrzeug-Haftpflichtversicherung
### Authors: Felten, Bettina; Stuhler, Sophie C.
### Date: 18-01-2017

# Import libraries
library(sp)
library(raster)
library(rgdal)
library(rgeos)
library(randomForest)

# Source functions
source('R/removeoutliers.R')
source('R/predictforestcover.R')

# load data
load('data/GewataB1.rda')
load('data/GewataB2.rda')
load('data/GewataB3.rda')
load('data/GewataB4.rda')
load('data/GewataB5.rda')
load('data/GewataB7.rda')
load('data/vcfGewata.rda')
load('data/trainingPoly.rda')

# call functions
predictforestcover(GewataB1, GewataB2, GewataB3, GewataB4, GewataB5, GewataB7, vcfGewata, trainingPoly)