predictforestcover <- function(band1, band2, band3, band4, band5, band7, vcf, training, mildness = 1.5) {
  b1 <- removeoutliers(band1, mildness)  # remove outliers, crucial in linear regression
  b2 <- removeoutliers(band2, mildness)
  b3 <- removeoutliers(band3, mildness)
  b4 <- removeoutliers(band4, mildness)
  b5 <- removeoutliers(band5, mildness)
  b7 <- removeoutliers(band7, mildness)
  vcf[vcf > 100] <- NA
  
  alldata <- brick(b1, b2, b3, b4, b5, b7, vcf)
  names(alldata) <- c('band1', 'band2', 'band3', 'band4', 'band5', 'band7', 'VCF')
  df <- as.data.frame(getValues(alldata))
  model <- lm(VCF ~ band1 + band2 + band3 + band4 + band5 + band7, data = df)  # create linear regression model
  predicted <- predict(alldata, model, na.rm = T)
  par(mfrow = c(1, 3))
  plot(predicted, main = 'Predicted Tree Cover', zlim = c(0, 100))
  plot(vcf, main = 'VCF Tree Cover', zlim = c(0, 100))
  plot(vcf-predicted, main = 'Difference (VCF - Predicted)')
  mtext(side = 1, 'Longitude', line = 2.5, cex = 1.1)
  mtext(side = 2, 'Latitude', line = 2.5, cex = 1.1)
  
  rmse <- sqrt(mean((predicted@data@values-vcfGewata@data@values)^2, na.rm = T))   # calculate the overall RMSE
  print(rmse)
  
  rmsepix <- sqrt(mean((predicted-vcfGewata)^2, na.rm = T))     # calculate RMSE for each pixel
  classes <- rasterize(training, rmsepix, field = 'Class')      # rasterize the classes
  zonalstats <- zonal(rmsepix, classes, fun = mean, na.rm = T)  # give the mean rmse per class
  rmseclasses <- as.data.frame(zonalstats)
  print(rmseclasses)
}
