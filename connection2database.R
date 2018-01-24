#############################
## Input database
connect.db.in <- function(){
  ##
  ## Connect to the MS-SQL database
  db.con <- odbcConnect( dsn = driver.name, uid=user.name, pwd = user.pwd)
  return(db.con)
}

#############################
## Query input database
query.db <- function(con.in){
  ##
  ## Query cannot last more than 20sec
  res <- withTimeout({
    ##
    ## Extract the View variables
    db.var <- sqlQuery(con.in, 'select * from dbo.h_BusEvents')
    }, timeout = 20, onTimeout = "silent")
  ##
  ## If the connection with the database breaks
  if( !exists("db.var") ){
    cat("Missing database, check connection, db.var and db.gi do not exists\n")
    break
  }
  if( !is.data.frame(db.var) | is.null(db.var) ){
    cat("Empty database, check connection, db.var and db.gi are null\n")
    break
  }

  return(db.var = db.var)
}
