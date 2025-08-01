library(RJDBC)
library(DBI)
Sys.setenv(TZ = "UTC")


jdbcDriver <- JDBC("oracle.jdbc.OracleDriver", 
                   classPath="./ojdbc17.jar")

jdbcConnection <- dbConnect(jdbcDriver, 
    "jdbc:oracle:thin:@//localhost:1521/xe",
    "system",        # Your username
    "oracle")  

print("Connected successfully!")
start_time <- Sys.time()
test_result <- dbGetQuery(jdbcConnection, "SELECT * FROM test WHERE ROWNUM<5")
end_time <- Sys.time()
print(end_time - start_time)
print(test_result)