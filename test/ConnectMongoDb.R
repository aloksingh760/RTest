
library(RMongo)
library(jsonlite)
library(httr)


# input output logging in to Mongo Db
connectMongoDb = function(db){
  
  # connect to mongo db
  mogoConn <- mongoDbConnect(db)
  
  # generate query
  query <- dbGetQuery(mogoConn, "sum", "{},{Id:1,ItemModList:1}", 0, 100)
  
  #filter data to get column
  data1 <- query[c('Id','ItemModList')]
  
  #parse data in to json
  request_body_json <- toJSON(list(documents = data1), auto_unbox = TRUE)
  print("Request body: ")
  print(request_body_json)
  
  # pass the json data to call post method api to calulate sum on column data and get output in return
  output<-callApi(request_body_json)
  
  # convert output of post method api time stamp column to data frame
  writeDataToDbDF=data.frame("SumOfItemModList"=output,"timestamp"=Sys.Date())
  
  # conver data frame to json
  writeDataToDbJson=toJSON(writeDataToDbDF, auto_unbox = TRUE)
  
  # write result in mongo db
  dataInsertionStatus <- dbInsertDocument(mogoConn, "sum_result", paste("{'SumOfItemModList':'",output,"','timestamp':'",Sys.time(),"'}",sep = "",collapse = ""))
  paste("Data insertion status in MongoDb",dataInsertionStatus)
}

# function to call post method and return the response 
callApi = function(jsonBody){

  post_result <- POST(url="http://localhost:8999/sum",body=jsonBody,add_headers(.headers = c("Content-Type"="application/json","username"="12345")))
  Output <- content(post_result, as="text", encoding="UTF-8")
  print("Cookie details:")
  print(post_result$cookies)
  data<-fromJSON(Output)
  return(data)
  
}


connectMongoDb('test')

