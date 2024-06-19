library(plumber)

#* @apiTitle Simple Plumber API
#* Return a greeting
#* @param name Your name
#* @get /hello
function(name = "world") {
  list(greeting = paste("Hello,", name, "!"))
}
