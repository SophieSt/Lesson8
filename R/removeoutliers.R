# this function masks out outliers based on quartiles (< Q1; > Q4)
# mildness for outliers can be given in mildness argument
# higher mildness will result in less outliers masked out!
# default mildness is 1.5


removeoutliers <- function (df, mildness = 1.5) {
  datalist <- getValues(df)
  lowerq <- quantile(datalist)[2]  # lower quartile
  upperq <- quantile(datalist)[4]  # upper quartile
  iqr <- IQR(datalist)             # interquartile range
  thr_upper <- (iqr * mildness) + upperq     # upper threshold for outliers
  thr_lower <- lowerq - (iqr * mildness)     # lower threshold for outliers
  df[df > thr_upper | df < thr_lower] <- NA  # remove points outside the range
  return(df)
}
