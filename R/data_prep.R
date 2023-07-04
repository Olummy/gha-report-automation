# Tue Jul 04 10:17:11 2023 ------------------------------


## load libraries

library(tidyverse)
library(lubridate)
library(googlesheets4)
library(gmailr)
library(openxlsx)


## read data from googlesheet

guest_tbl <- read_sheet("1oUXGpb41PHn6ZbBOW6wJ0OfryhvUOQkh276SzWFADF4",
                        sheet = "Form Responses 1",
                        range = "Form Responses 1!A:V")

## extract the weekly data

this_week_data <- guest_tbl %>% 
  filter(Timestamp > today() - 7)


## format and write the dataframe as a spreadsheet document

hs <- createStyle(
  textDecoration = "BOLD", fontColour = "#FFFFFF", fontSize = 12,
  fontName = "Arial Narrow", fgFill = "#4F80BD"
)


write.xlsx(this_week_data, paste0("Harvesters Gbagada Campus Guest Data-", today(), ".xlsx"),
           colNames = TRUE, borders = "rows", headerStyle = hs
)


## email the spreadsheet document

html_msg <- gm_mime() %>% 
  gm_to(c("oladiranf@gmail.com", "oajala@harvestersng.org", "rasheedalawode@yahoo.com",
          "flabiran@harvestersng.org", "rubites007@gmail.com",
          "opetumotemitope@gmail.com", "omodarakayode@gmail.com",
          "a.dayoajimuda@gmail.com", "chinenyenwanna@gmail.com")) %>%
  gm_bcc("olumideoyalola@gmail.com") %>% 
  gm_from("olumideoyalola@gmail.com") %>% 
  gm_subject(paste0("Harvesters Gbagada Campus Guest Data-", today())) %>% 
  gm_html_body("Dear All, <br><br> Good evening and trust this email meets you in a great spirit. <br><br> <b>Attached is the captured data for the week.</b> <br> <br> Thank you, <br><br> Olumide Oyalola") %>% 
  gm_attach_file(paste0("Harvesters Gbagada Campus Guest Data-", today(), ".xlsx"))

gm_send_message(html_msg)

## delete the file after pushing the email to recipient

unlink(paste0("Harvesters Gbagada Campus Guest Data-", today(), ".xlsx"))
