rankhospital <- function(state, outcome, num = "best") {
 
  # Check invalid outcome input
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop("invalid outcome")
  }
  
  indx <- ifelse(outcome == "heart attack", 11, ifelse(outcome == "heart failure", 17, 23))
  
  ## Read outcome data. Suppress warnings. Remove NA
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[, indx] <- suppressWarnings(as.numeric(data[, indx]))
  data <- na.omit(data)
  
  ## Check that state are valid
  states <- table(data$State)
  if (!state %in% names(states)){
    stop('invalid state')
  }
  
  ##Slice data by given state and sort it by outcome and hospital name
  slice <- subset(data, State == state)
  ## Order by rate
  slice <- slice[order(slice[, indx], slice[, 2], na.last = TRUE), 2]
  slice <- na.omit(slice)
  
  num <- ifelse(num == "best", 1, ifelse(num == "worst", length(slice), as.numeric(num)))
  
  ## Get hospital name for the given rank by its 30 day mortality rate
  slice[num]
}