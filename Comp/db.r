library(RJDBC)
library(DBI)
Sys.setenv(TZ = "UTC")

jdbcDriver <- JDBC("oracle.jdbc.OracleDriver", 
                   classPath = "./ojdbc17.jar")

jdbcConnection <- dbConnect(jdbcDriver, 
    "jdbc:oracle:thin:@//localhost:1521/xe",
    "system",        
    "oracle")  

print("Connected successfully!")

start_time <- Sys.time()
test_result <- dbGetQuery(jdbcConnection, "SELECT price FROM test WHERE ROWNUM < 5")
# Save to .data file
write.table(test_result, file = "test_output.data", row.names = FALSE, sep = "\t", quote = FALSE)

print("Data saved to test_output.data")
