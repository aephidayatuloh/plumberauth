library(plumber)

#* @apiTitle Simple Plumber API
#* 

#* @get /
function(){
  list(status = "ok", message = "API is running")
}

#* Return a greeting
#* @param name Your name
#* @get /hello
function(name = "world") {
  list(greeting = paste("Hello,", name, "!"))
}
