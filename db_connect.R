# db_connect.R
# library(config)
library(RPostgres)
# get <- base::get
dw <- config::get(config = "production")

# Function to create a connection to the PostgreSQL database
db_connect <- function() {
  con <- dbConnect(
    Postgres(),

    dbname = dw$dbname,    # ganti dengan nama database Anda
    host = dw$host,          # ganti dengan host database Anda
    port = dw$port,                 # ganti dengan port database Anda
    user = dw$user,            # ganti dengan user database Anda
    password = dw$password    # ganti dengan password database Anda
  )
  return(con)
}
