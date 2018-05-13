#TestSum.R
library(plumber)
library(stringi)
library(jsonlite)
library(httr)

# function will return response of sum
#' @post /sum
sumTest <- function(req,res) {
  #fetching header value
  val=''
  list(
    val<-req$HTTP_USERNAME
    
    
  )
  # parsing reqest body to dataframe 
  document<- fromJSON(req$postBody)
  asFrame <- as.data.frame(document)
  
  # validate header
  if(as.character(val)==as.character("12345")){
    outputFromSumMethod<-sumColumn(asFrame,"documents.ItemModList")
    outputToJson<- toJSON(outputFromSumMethod,auto_unbox = TRUE,pretty = TRUE)
    print(outputToJson)
    return(outputToJson)
  }else{
    res$status<- 400 #Bad Request
    return(list(error="Missing Required Parameters."))
  }
  
}



sumColumn <- function(df, Col_name) {
  
  
  
  result = tryCatch({
    
   #check if first input argument is not a data frame
  if(!is.data.frame(df))
    outputList<-list("output_code"="output_error_2","output_error"="Non dataframe supplied as df")
  
  #check if second input argument is not numeric
  if(!is.numeric(df[[Col_name]]))
    outputList<-list("output_code"="output_error_1","output_error"="Non numeric column supplied")
  
  #fetch all values from specified colum in second argument
  column_values= df[Col_name]
  outputList<-list("output_code"="output_success_0","total sum"=colSums(column_values))
  
  }, error = function(e) {
    outputList<-list("output_code"="output_error_3","output_error"="any other error")
  })
  return (result)
}


