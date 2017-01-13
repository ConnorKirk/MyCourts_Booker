#url builder
library(lubridate)
selection <-  list(time = 1720, court = 1, date = "26 January 2017")

base_url_book <-  "https://edgbastonpriory.mycourts.co.uk//bookings_confirm.asp?"
base_url_confirm <- "https://edgbastonpriory.mycourts.co.uk//bookings_process.asp?"
ctid <-  "14383"
day <- "20"
month <- "January"
year <- "2017"

query <-  paste0(base_url, "ctid=", ctid, "&dt=", selection$date)

days <- dmy(selection$date[[1]]) - today() %>%
  as.numeric()

