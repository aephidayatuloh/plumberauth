# api.R
library(plumber)
library(RPostgres)
source("db_connect.R")
source("auth.R")

#* @apiTitle Example API
#* @apiDescription This is an example API with authentication using PostgreSQL.

#* Ping endpoint
#* @get /ping
function() {
  list(status = "ok", message = "API is running")
}

#* Get data from table
#* @param table The name of the table to query
#* @param user The username for authentication
#* @param password The password for authentication
#* @get /data
function(table, user, password, res) {
  con <- db_connect()
  on.exit(dbDisconnect(con))
  auth <- authenticate(user, password, con)
  message(auth)
  if (auth) {
    query <- paste0("SELECT * FROM ", table)
    data <- dbGetQuery(con, query)
    # message(data$userid)
    return(data)
  } else {
    res$status <- 401
    return(list(error = "Unauthorized"))
  }
}

#* Add data to table
#* @param table The name of the table to insert data
#* @param user The username for authentication
#* @param password The password for authentication
#* @param data The data to be inserted (as JSON)
#* @post /data
function(table, user, password, data, res) {
  con <- db_connect()
  on.exit(dbDisconnect(con))
  
  if (authenticate(user, password, con)) {
    data <- jsonlite::fromJSON(data)
    dbWriteTable(con, table, data, append = TRUE, row.names = FALSE)
    return(list(status = "success"))
  } else {
    res$status <- 401
    return(list(error = "Unauthorized"))
  }
}
