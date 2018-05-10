#TestSum.R
library(plumber)
library(stringi)
library(jsonlite)
library(httr)

#* Return the value of a custom header
#' @post /sum
sumTest <- function(req,res) {

  val=''
    list(
     val<-req$HTTP_USERNAME
     #coockie<-req$cookies

  )
 

  document<- fromJSON(req$postBody)
  asFrame <- as.data.frame(document)
  #print(asFrame)
  
  count <- 0
  if (!is.null(req$session$counter)){
    count <- as.numeric(req$session$counter)
  }
  req$session$counter <- count + 1
  print("# of visits")
  print(count) 
  if(as.character(val)==as.character("12345")){
    return(sumColumn(asFrame,"documents.ItemModList"))
   }else{
      res$status<- 400 #Bad Request
      return(list(error="Missing Required Parameters."))
    }
  
}



sumColumn <- function(df, Col_name) {

  # check if first input argument is not a data frame
  if(!is.data.frame(df))
    stop ('output_error2: Non dataframe supplied as df')

  # check if second input argument is not numeric
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


