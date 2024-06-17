# run_api.R
library(plumber)
pr <- plumber::plumb("api.R")
pr$run(host = "0.0.0.0", port = 8080)
