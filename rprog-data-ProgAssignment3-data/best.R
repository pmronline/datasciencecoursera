## Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
## outcome name. The function reads the outcome-of-care-measures.csv ﬁle and returns a character vector
## with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the speciﬁed outcome
## in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
## be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
## outcome should be excluded from the set of hospitals when deciding the rankings.

best <- function(state, outcome) {
  
  ## Invalid outcome input
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop("invalid outcome")
  }
  
  ## Get index for the outcome string
  indx <- ifelse(outcome == "heart attack", 11, ifelse(outcome == "heart failure", 17, 23)) 
  
  ## Read and Coerce the dataset. Suppress warnings. Remove NA
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data[, indx] <- suppressWarnings(as.numeric(data[, indx]))
  data <- na.omit(data)
  
  ## Invalid State Input
  states <- table(data$State)
  if (!state %in% names(states)){
    stop("invalid state")
  }
  
  ## Slice the data by given state and sort by outcome and hospital name
  slice <- subset(data, State == state)
  slice <- slice[order(slice[, indx], na.last = TRUE), 2]
  slice <- na.omit(slice)
  
  ## Get hospital name with lowest 30 day mortality rate
  slice[1]
  
}