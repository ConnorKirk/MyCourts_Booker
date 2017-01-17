#Libraries
library(stringr)
library(httr)
library(rvest)
library(dplyr)
library(magrittr)
library(lubridate)

#Load username and password
source("credentials.R")

#Goes to edgbaston mycourts page (current day)
mycourts_url <- "https://edgbastonpriory.mycourts.co.uk/" 


#Create new session
sesh <- html_session(mycourts_url)

#read session html
h <- sesh %>%
  read_html() 

#Get login form
h_form <- html_form(h)[[1]]

#Set login form credentials
h_form_values_set <-  set_values(h_form,
                                 username = username,
                                 password = password)
#Submit login form
h_form_submit <- submit_form(form = h_form_values_set,
                             session = sesh,
                             Submit = "Submit")


# Navigate to Correct Date
sesh <- sesh %>%
  jump_to("https://edgbastonpriory.mycourts.co.uk/bookings.asp?st1=0700&st2=2400&d=14&tabID=132")



# #Log in Works
# #Check log in successfull
#  read_html(sesh) %>%
#    html_nodes("#left_col a")
  

# #Find link for "booking" court
# booking_link <- sesh %>%
#   read_html() %>%
#   html_node("#court563 .book_this_court") %>%
#   html_attr("href") %>%
#   paste0(mycourts_url, .) %>%
#   stringr::str_replace_all(pattern = " ", replacement = "%20")


#Follow link to book court
# sesh <- sesh %>%
#   jump_to(booking_link)


#Find link to confirm court booking
# confirmation_link <- sesh %>%
#   read_html() %>%
#   html_node(css = "#right_col > table > tr:nth-child(2) > td:nth-child(4) > a") %>%
#   html_attr("href") %>%
#   paste0(mycourts_url, .) %>%
#   stringr::str_replace_all(pattern = " ", replacement = "%20")
 
#Follow link to confirm court booking 
# sesh <- sesh %>%
#   jump_to(confirmation_link)

#Gets the court times from sesh
sesh %>%
  read_html() %>%
  html_nodes("#court566 > div") %>%
  html_text()




  
