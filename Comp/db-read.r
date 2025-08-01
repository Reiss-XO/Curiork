## Initialization section

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
jdbcDriver <- JDBC("oracle.jdbc.OracleDriver", classPath="C:/Users/rsarvaiya/Downloads/R/ojdbc8-12.2.0.1.jar")

## Initialize variable '@varName'
#@varName <- @varValue

## Create a list of the fields in the producing data model '@inputAlias' 
## Also specify the type for each field 
temp_var_columnDataTypesFor_@inputAlias <- list()
temp_var_columnDataTypesFor_@inputAlias$@fieldName <- getDataTypeAsString("@fieldType")

## Populate data frame (representing producing data model '@inputAlias') by querying the database
jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@//localhost:1521/xe", "@dbSourceUser", "@dbSourcePassword")
@inputAlias <- dbGetQuery(jdbcConnection, "@selectStatement")
dbDisconnect(jdbcConnection)

## Create a list representing the columns in the resulting data source '@outputAlias' 
@outputAlias <- list()
@outputAlias$@fieldName <- getDataType("@fieldType")

## Create a temporary list representing 'asof_date' and 'Instance Keys' for the resulting data source '@outputAlias'. 
## If applicable (i.e for continuous data sources), add asof_date and instance key values. 
temp_var_asOfDateAndInstanceKeysFor_@outputAlias <- list()
temp_var_asOfDateAndInstanceKeysFor_@outputAlias$@ikName = rep(@ikValue, length(@outputAlias[[1]]))

## Create a resulting data frame, '@outputAlias', for the resulting data source '@outputAlias' 
## which will contain asof_date (if applicable), instance keys (if applicable) and the data source columns.  
@outputAlias <- as.data.frame(c(temp_var_asOfDateAndInstanceKeysFor_@outputAlias,  as.list(@outputAlias)))

## Create a handle to the output file 
file = file("@outputFileName", "wb")

## Write resulting data to the output file 
write.table(@outputAlias, file, quote = FALSE, row.names = FALSE, col.names=FALSE, sep = "\t", eol = "\n", na="")

## Finalization section
## For now, nothing to do in the finalization section. Keeping this section just to demonstrate the feature

