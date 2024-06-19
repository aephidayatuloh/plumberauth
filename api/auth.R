# auth.R
# library(digest)

# Function to check authentication
authenticate <- function(user, password, con) {
  query <- sprintf("SELECT * FROM creds WHERE userid = '%s'", user)
  result <- dbGetQuery(con, query)
  
  # if (nrow(result) == 1 & result$passwd == digest(password, algo = "sha256")) {
  if (nrow(result) == 1 && result$passwd == password) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
