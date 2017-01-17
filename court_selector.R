#url builder

#Maps Courts for Court number. Could substitute for simple function court# + 562?
courts <- list(court1 = "563",
               court2 = "564",
               court3 = "565",
               court4 = "566",
               court5 = "567",
               court6 = "568",
               court7 = "569",
               court8 = "570",
               court9 = "571",
               court10 = "572")

#Extracts which link has required court from given time. 
#Could be combined with below into a function
court_link_selector <- function(session, court_number, court_time ) {
  session %>%
    read_html() %>%
    html_nodes(paste0("#court", court_number, " div")) %>% #creates selector ie "#court566 div"
    stringr::str_detect(paste0(court_time, ":")) %>%
    which()
}

#Extracts CourtId from given court and link_no
ctid_finder <- function(session, link_no, court_number) {
  session %>%
    read_html() %>%
    html_nodes(paste0("#court", court_number, " div")) %>%
    extract2(link_no) %>%
    html_node("a") %>%
    html_attr("href") %>%
    stringr::str_extract("(?<=ctid=)\\d\\d\\d\\d")
}  

create_confirmation_link <- function(session, court_number, court_time, date) {
  link_no <-  court_link_selector(session = session, court_number = court_number, court_time = court_time)
  
  ctid <- ctid_finder(session = session, link_no = link_no, court_number = court_number)
  
  
  base_url_confirm <- "https://edgbastonpriory.mycourts.co.uk//bookings_process.asp?"
  confirmation_link <-  paste0(base_url_confirm, "ctid=", ctid, "&dt=", booking_date)
}








 
  

