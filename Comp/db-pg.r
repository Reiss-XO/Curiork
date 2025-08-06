library(RJDBC)
library(DBI)
Sys.setenv(TZ = "UTC")

# Load PostgreSQL JDBC driver
jdbcDriver <- JDBC("org.postgresql.Driver", 
                   classPath = "./postgresql-42.7.7.jar")

# Connect to PostgreSQL
jdbcConnection <- dbConnect(jdbcDriver, 
    "jdbc:postgresql://localhost:5432/postgres",
    "system",        
    "postgres")  

print("Connected successfully!")

start_time <- Sys.time()

# Run query (PostgreSQL uses LIMIT instead of ROWNUM)
test_result <- dbGetQuery(jdbcConnection, "SELECT 192168;")
test_result
# Save to .data file
# write.table(test_result, file = "test_output.data", row.names = FALSE, sep = "\t", quote = FALSE)

print("Data saved to test_output.data")

