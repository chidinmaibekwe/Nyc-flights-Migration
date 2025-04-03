library(nycflights23)
View(nycflights23)
data(package = "nycflights23")
str(flights)
str(airlines)
str(airports)
str(planes)
str(weather)

library(RPostgres)
library(nycflights23)
library(yaml)
# database Connection
db_connection <- function(config){
  # Load Yaml file 
  cnf <- yaml.load_file(config)
  print(cnf)
  pg_cnf <- cnf[['postgres']]
  # Establish Connection 
  conn <- dbConnect(
    Postgres(),
    dbname = pg_cnf[["flights"]], # Access database key
    host = pg_cnf[["host"]], # Access host key
    port = as.integer(pg_cnf[["port"]]), # Access port key
    user = pg_cnf[["user"]], # Access user key
    password = pg_cnf[["password"]], # Access password key
  )
  
  return(conn)  
  print("Connection Successful")
}

con <- db_connection("config.yaml")
#Populate the tables
dbWriteTable(con,
             "flight.airlines", airlines, row.names = FALSE)
dbWriteTable(con,
             "flight.airports", airports, row.names = FALSE)
dbWriteTable(con,
             "flight.flights", flights, row.names = FALSE)
dbWriteTable(con,
             "flight.planes", planes, row.names = FALSE)
dbWriteTable(con,
             "flight.weather", weather, row.names = FALSE)

#close connection
dbDisconnect(con) 



