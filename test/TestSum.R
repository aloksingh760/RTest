#TestSum.R
library(plumber)
library(stringi)

#* Return the value of a custom header
#* @post /sum 
sumTest <- function(documents) {

  val=documents$new()
  val$setHeader("username":"12345")
  print(val)
  if(val=='1234')
  print("in post method \n")
  sumColumn(documents,"ItemModList")

  
  
}



sumColumn <- function(df, Col_name) {
  
  # check if first input argument is data frame
 
  if(!is.data.frame(df)) 
    stop ('output_error2: Non dataframe supplied as df')
  
  # check if second input argument should numeric only
  #Col_name=as.name(Col_name)
  if(!is.numeric(df[[Col_name]]))
    stop('output_error1: Non numeric column supplied')
  
  #fetch all values from specified colum in second argument
  column_values= df[Col_name]
  result = tryCatch({
    colSums(column_values)
  }, error = function(e) {
    stop("output_error3: any other error")
  })
  return (result)
}

# df<-data.frame(id = c (1,10,11),name=c (1,16,20))
# sumColumn(df,"id")






# result1 = tryCatch({
#   
#   df<-data.frame(id = c (1,10,"five"))
#   Col_name <- 'id'
#   # check if first input argument is data frame
#   if(!is.data.frame(df)) 
#     stop ('output_error2: Non dataframe supplied as df')
#   
#   # check if second input argument should numeric only
#   if(!is.numeric(df[[Col_name]]))
#     stop('output_error1: Non numeric column supplied')
#   
#   sumColumn(emp,"id")
# }, error = function(e) {
#   stop("output_error3: any other error")
# })

