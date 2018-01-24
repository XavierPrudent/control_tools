suppressMessages(library(lubridate))
suppressMessages(library(plyr))
suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
suppressMessages(library(stringr))
suppressMessages(library(RODBC))
suppressMessages(library(data.table))
suppressMessages(library(fasttime))
suppressMessages(library(RSQLite))
suppressMessages(library(R.utils))
setOption("dplyr.show_progress",FALSE)
source("connection2database.R")
##
## To connect to the database
driver.name <<-  "STSSQL"
user.name   <<-  "martin.choiniere"
user.pwd    <<-  "STSH2017"
##
## Connect to input database
con.in <- connect.db.in()
##
## Time loop
while( TRUE ){
  ##
  ## Current time
  time.now <- Sys.time()
  attr(time.now,"tzone") <- "EST"
  ##
  ## Database
  db.var <- query.db(con.in)
  ##
  ## Save trip id to file
  out.file <- "out/sts_trips_SAE.txt"
  if( !file.exists(out.file) ) write.table(x=db.var,file=out.file,sep=",",quote=F,row.names = F,col.names = T)
  else write.table(x=db.var,file=out.file,sep=",",quote=F,row.names = F,col.names = F,append = T)
  ##
  ## Wait for freq seconds
  Sys.sleep(5)
}
