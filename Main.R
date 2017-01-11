library(httr)
library(rvest)
library(dplyr)
library(magrittr)

courts <- list(court1 = "court563",
               court2 = "court564",
               court3 = "court565",
               court4 = "court566")

#Goes to edgbaston mycourts page (current day)
mycourts_url <- "https://edgbastonpriory.mycourts.co.uk/" 


source("credentials.R")

#login
sesh <- html_session(mycourts_url)

h <- sesh %>%
  read_html() 

h_form <- html_form(h)[[1]]

h_form_values_set <-  set_values(h_form,
                                 username = username,
                                 password = password)

h_form_submit <- submit_form(form = h_form_values_set,
                             session = sesh,
                             Submit = "Submit")


# Navigate to Correct Date
sesh <- sesh %>%
  jump_to("https://edgbastonpriory.mycourts.co.uk/bookings.asp?st1=1600&st2=2400&d=14&tabID=132")

#Log in Works

read_html(sesh) %>%
  html_nodes("#left_col a")
  
booking_link <- sesh %>%
  read_html() %>%
  html_node("#court563 .book_this_court") %>%
  html_attr("href") %>%
  paste0(mycourts_url, .) %>%
  stringr::str_replace_all(pattern = " ", replacement = "%20")



sesh <- sesh %>%
  jump_to(booking_link)

confirmation_link <- sesh %>%
  read_html() %>%
  html_node(css = "#right_col > table > tr:nth-child(2) > td:nth-child(4) > a") %>%
  html_attr("href") %>%
  paste0(mycourts_url, .) %>%
  stringr::str_replace_all(pattern = " ", replacement = "%20")
  
sesh <- sesh %>%
  jump_to(confirmation_link)
  
