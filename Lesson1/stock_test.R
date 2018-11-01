require(httr)
require(jsonlite)
require(dplyr)
require(mongolite)

url <- 'http://www.twse.com.tw/exchangeReport/MI_INDEX?response=json&date=20181029&type=ALL'

raw_data <- jsonlite::fromJSON(url)

stock_df <- raw_data$data5 %>% data.frame(.,stringsAsFactors = F)
colnames(stock_df) <- raw_data$fields5
stock_df$`漲跌(+/-)` <- stock_df$`漲跌(+/-)` %>% lapply(.,function(t){substr(t,nchar(t)-4,nchar(t)-4)}) %>% unlist()

conn <- mongo(collection = 'stock_R',url = 'mongodb://student:password@127.0.0.1:27017/testdb')
conn$insert(stock_df)
