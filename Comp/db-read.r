## Initialization section
print("DB-READ.TEMPLATE")
Sys.setenv(TZ = "UTC")

start_time <- Sys.time()

## Function getDataType(...) which accepts axiom data type as a parameter
## and returns its equivalent R data type
getDataType <- function(axiomType) {
  if (axiomType == "INTEGER" | axiomType == "FLOAT") {
    return(numeric())
  } else {
    return(character())
  }
}

## Function getDataTypeAsString(...) which accepts axiom data type as a parameter
## and returns its equivalent R data type as string
getDataTypeAsString <- function(axiomType) {
  if (axiomType == "INTEGER" | axiomType == "FLOAT") {
    return("numeric")
  } else {
    return("character")
  }
}

library(RJDBC)
jdbcDriver <- JDBC("oracle.jdbc.OracleDriver", 
                   classPath = "./ojdbc17.jar")
## Initialize variable '@varName'
#@varName <- @varValue

## Create a list of the fields in the producing data model '@inputAlias' 
## Also specify the type for each field 
# temp_var_columnDataTypesFor_test_data <- list()
# temp_var_columnDataTypesFor_test_data$price <- getDataTypeAsString("FLOAT")

## Populate data frame (representing producing data model '@inputAlias') by querying the database
jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@//localhost:1521/xe", "system", "oracle")
print("Connect to Oracle DB")
test_data <- dbGetQuery(jdbcConnection, "SELECT price from test")
print("Retrieved Data from DB")

test_data$PRICE <- as.numeric(test_data$PRICE)


dbDisconnect(jdbcConnection)

## Create a list representing the columns in the resulting data source '@outputAlias' 
DSResult <- list()
DSResult$summ <- getDataType("FLOAT")
DSResult$mini <- getDataType("FLOAT")
DSResult$maxi <- getDataType("FLOAT")
DSResult$median <- getDataType("FLOAT")
DSResult$std_dev <- getDataType("FLOAT")

## Compute statistics

for(i in 1:300){
  DSResult$summ <- append(DSResult$summ, sum(test_data$PRICE))
  DSResult$mini <- append(DSResult$mini, min(test_data$PRICE))
  DSResult$maxi <- append(DSResult$maxi, max(test_data$PRICE))
  DSResult$median <- append(DSResult$median, median(test_data$PRICE))
  DSResult$std_dev <- append(DSResult$std_dev, sd(test_data$PRICE))
}
print("Completed Computation Script")


## Create a temporary list representing 'asof_date' and 'Instance Keys' for the resulting data source '@outputAlias'. 
## If applicable (i.e for continuous data sources), add asof_date and instance key values. 
## Add asof_date and instance keys
temp_var_asOfDateAndInstanceKeysFor_DSResult <- list()
temp_var_asOfDateAndInstanceKeysFor_DSResult$asof_date <- rep("2025-07-17 00:00:00", length(DSResult[[1]]))

## Create a resulting data frame, '@outputAlias', for the resulting data source '@outputAlias' 
## which will contain asof_date (if applicable), instance keys (if applicable) and the data source columns.  
DSResult <- as.data.frame(c(temp_var_asOfDateAndInstanceKeysFor_DSResult, as.list(DSResult)))

## Write to output file
file <- file("res-db.data", "wb")
write.table(DSResult, file, quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t", eol = "\n", na = "")
print("Flushed results to Output File")
## Finalization section
## For now, nothing to do in the finalization section. Keeping this section just to demonstrate the feature
end_time <- Sys.time()
time_taken =  end_time - start_time
print(time_taken)
