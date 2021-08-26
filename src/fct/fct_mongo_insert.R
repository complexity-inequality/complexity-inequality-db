fmongo_insert <- function(df, nm_db, nm_collec){
  mongo_credentials <- config::get(file = "conf/globalresources.yml")
  mongo_set <- mongo(db = nm_db, collection = nm_collec, url = mongo_credentials$mongoURL, verbose = TRUE)
  mongo_set$drop()
  mongo_set$insert(data = df)
}

# Connect to Gateway
# mongo_set <- mongo(db = "db_test", collection = "col_test", url = "mongodb://root:passwd@172.21.0.1", verbose = TRUE)
# mongo_set$find()
# mongo_set <- mongo(db = "nm_db", collection = "nm_collec", url = config::get(file = "conf/globalresources.yml")$mongoURL, verbose = TRUE)

# mongo_set <- mongolite::mongo(db = "db_test", collection = "col_test", url = "mongodb://root:passwd@172.21.0.1", verbose = TRUE)
# mongo_set$find()
# 
# 192.168.160.4


# mongo_set <- mongolite::mongo(db = "db_test", collection = "col_test", url = "mongodb://root:passwd@172.21.0.1", verbose = TRUE)
# mongo_set$find()