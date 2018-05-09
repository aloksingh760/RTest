
library(RMongo)
library(jsonlite)
library(httr)
library(lubridate)

connectMongoDb = function(db){
  
  
  mogoConn <- mongoDbConnect(db)
  query <- dbGetQuery(mogoConn, "sum", "{},{Id:1,ItemModList:1}", 0, 100)
  data1 <- query[c('Id','ItemModList')]
  request_body_json <- toJSON(list(documents = data1), auto_unbox = TRUE)
  print(request_body_json)
  output<-callApi(request_body_json)
  
  writeDataToDbDF=data.frame("SumOfItemModList"=output,"timestamp"=Sys.Date())
  writeDataToDbJson=toJSON(writeDataToDbDF, auto_unbox = TRUE)
  print(writeDataToDbJson)
  output1 <- dbInsertDocument(mogoConn, "sum_result", paste("{'SumOfItemModList':'",output,"','timestamp':'",Sys.time(),"'}",sep = "",collapse = ""))
  print(output1)
}

callApi = function(jsonBody){
  url  <- "http://localhost:8999"
  path <- "sum"
  post_result <- POST(url="http://localhost:8999/sum",body=jsonBody,add_headers(.headers = c("Content-Type"="application/json")))
  
  Output <- content(post_result)
  return(Output)
  
}


connectMongoDb('test')

