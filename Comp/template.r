## Returns a vector of int or float
getDataType <- function(axiomType) {
  if (axiomType == "INTEGER" | axiomType == "FLOAT") {
    return(numeric())
  } else {
    return(character())
  }
}

## Function to return R data type as string
getDataTypeAsString <- function(axiomType) {
  if (axiomType == "INTEGER" | axiomType == "FLOAT") {
    return("numeric")
  } else {
    return("character")
  }
}

## Define column data types for 'test_data' --> a map DS
# notes type of field u wanna play with
temp_var_columnDataTypesFor_test_data <- list()
temp_var_columnDataTypesFor_test_data$price <- getDataTypeAsString("FLOAT")

start_time <- Sys.time()
## Read input data ie price
test_data <- read.table(
  "./one_mill_recs.data",
  header = TRUE,
  sep = "\t",
  quote = "",
  na.strings = character(),
  comment.char = "",
  colClasses = c(temp_var_columnDataTypesFor_test_data)
)
end_time <- Sys.time()


## Create result structure

#[ summ-[], mini-[], ... std_dev-[] ]

DSResult <- list()
DSResult$summ <- getDataType("FLOAT")
DSResult$mini <- getDataType("FLOAT")
DSResult$maxi <- getDataType("FLOAT")
DSResult$median <- getDataType("FLOAT")
DSResult$std_dev <- getDataType("FLOAT")

## Compute statistics

for(i in 1:300){
  DSResult$summ <- append(DSResult$summ, sum(test_data$price))
  DSResult$mini <- append(DSResult$mini, min(test_data$price))
  DSResult$maxi <- append(DSResult$maxi, max(test_data$price))
  DSResult$median <- append(DSResult$median, median(test_data$price))
  DSResult$std_dev <- append(DSResult$std_dev, sd(test_data$price))
}


## Add asof_date and instance keys
temp_var_asOfDateAndInstanceKeysFor_DSResult <- list()
temp_var_asOfDateAndInstanceKeysFor_DSResult$asof_date <- rep("2025-07-17 00:00:00", length(DSResult[[1]]))

## Create final data frame
DSResult <- as.data.frame(c(temp_var_asOfDateAndInstanceKeysFor_DSResult, as.list(DSResult)))

## Write to output file
file <- file("res.data", "wb")
write.table(DSResult, file, quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t", eol = "\n", na = "")



time_taken =  end_time - start_time
print(time_taken)