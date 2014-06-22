fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "amcomm.csv", method="curl")
home <- read.table("amcomm.csv", header=TRUE, sep=",")
summary(as.factor(home$VAL))