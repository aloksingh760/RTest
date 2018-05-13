FROM rocker/r-base

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  default-jre \
  default-jdk

RUN git clone https://github.com/aloksingh760/RTest.git
RUN R -e 'install.packages(c("plumber","PKI","RMongo","jsonlite","httr"))'

EXPOSE 8999
CMD ["R" "-e" 'pr <- plumber::plumb("/RTest/test/TestSum.R");pr$registerHooks(sessionCookie("9999","coockieName")); pr$run(port=8999)']
CMD ["Rscript" "/RTest/test/ConnectMongoDb.R"]




