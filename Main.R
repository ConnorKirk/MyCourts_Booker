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

# Function to login to MyCourts. Returns the refreshed session.
MyCourts_Login <- function(session, username, password) {
  #read session html
  session_html <- session %>%
    read_html() 
  
  #Get login form
  login_form <- html_form(session_html)[[1]]
  
  #Set login form credentials
  login_form_values_set <-  set_values(login_form,
                                   username = username,
                                   password = password)
  #Submit login form
  login_form_submit <- submit_form(form = login_form_values_set,
                               session = session,
                               Submit = "Submit")
  
  
  
  temp_session <- session %>% 
    jump_to(session$url) 
  
  if(check_login_success(temp_session) == T){
    message("Login Successful")
    } else {
    warning("login not successful")
      
    return(temp_session)
  }
}
  

#Given a session, it will look for the logout link on the left column.
#Will return true (indicating the user is logged in) if found.
check_login_success <- function(session) {
  read_html(session)  %>%
    html_nodes("#left_col a") %>%
    grepl("logout_link", .) %>%
    any()
}


# Navigate to Correct Date
sesh <- sesh %>%
  jump_to("https://edgbastonpriory.mycourts.co.uk/bookings.asp?st1=0700&st2=2400&d=14&tabID=132")



# #Log in Works
#Check log in successfull
       read_html(sesh)  %>%
   html_nodes("#left_col a") %>%
         grepl("logout_link", .) %>%
         any()
  

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


MyCourts_Login(sesh, username, password)




  
