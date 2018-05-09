# myfile.R

#* @get /mean
normalMean <- function(samples=10){
  data <- rnorm(samples)
  mean(data)
}

#* @post /sum
addTwo <- function(a, b){
  as.numeric(a) + as.numeric(b)
}

sumColumn <- function(df, Col_name) {
  #df=df
  #col_name<-as.name(Col_name)
  df=noquote(df)
  
  print(Col_name)
  print(df)
  result= df[Col_name]
  cat("!!!!!!!\n")
  
  cat("****************\n")
  print(result)
  cat("@@@@@@@@\n")
  print(colSums(result))
  
}
emp<-data.frame(id = c (1:10))
sumColumn("data.frame(id=c(1:10))","id")