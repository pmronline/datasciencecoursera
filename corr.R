corr <- function(directory, threshold = 0) {
  files <- list.files( path = directory )
  tcr <- c() 
  
  for(fnum in 1:length(files)){
    data <- read.csv( paste(directory, "/", files[fnum], sep="") )
    data <- data[complete.cases(data),]
    if ( nrow(data) > threshold ) {
      tcr <- c(tcr, cor(data$sulfate, data$nitrate) ) # append corralations
    }
  }  
  return(tcr)
}