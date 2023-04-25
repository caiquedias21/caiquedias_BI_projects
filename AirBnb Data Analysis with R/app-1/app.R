library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
library(shinydashboard)
library(plotly)
library(lubridate)


# Load and process data

# Set a directory

directory = 'c:/Users/caiqu/OneDrive/Documentos/Big Data with R/Project/'
setwd(directory)

# Load the data

load(file=paste(directory,'AirBnB (1).Rdata', sep = ''))

# Extract the columns that are important for the analysis


airbnb_extract <- subset(L, select = c(id, name, host_id, host_name, street, city, state,
                                       zipcode, country_code, country, latitude, longitude, 
                                       property_type, room_type, accommodates, bathrooms, bedrooms,
                                       beds, bed_type, square_feet, price, weekly_price, monthly_price,
                                       number_of_reviews, review_scores_rating, reviews_per_month ))

# Extract the Paris data

airbnb_extract = airbnb_extract[substr(airbnb_extract$zipcode,1,2) == "75",]
unique(airbnb_extract$zipcode)

# Create an "arrondissement" column


airbnb_extract = mutate(airbnb_extract,arrondissement = substr(airbnb_extract$zipcode,
                                                               str_length(airbnb_extract$zipcode)-1,
                                                               str_length(airbnb_extract$zipcode)))

# Delete unreal values

airbnb_extract = airbnb_extract[airbnb_extract$arrondissement != "IS" &
                                  airbnb_extract$arrondissement != "75"&
                                  airbnb_extract$arrondissement != "22"&
                                  airbnb_extract$arrondissement != "00",]

# Extract the number of prices from the string columns

airbnb_extract = mutate(airbnb_extract, price_num = as.numeric(str_extract(
  gsub(",", "", airbnb_extract$price), "[0-9]+\\.[0-9]+")), 
  weekly_price_num = as.numeric(str_extract(gsub(",", "", airbnb_extract$weekly_price), "[0-9]+\\.[0-9]+")), 
  monthly_price_num = as.numeric(str_extract(gsub(",", "", airbnb_extract$monthly_price), "[0-9]+\\.[0-9]+")))

# Load the reservations table

reservations_extract <- R

colnames(reservations_extract)[1] = "id"

# Join the two tables

airbnb_reservations = inner_join(reservations_extract,airbnb_extract,by='id')

# Transform to the date column

airbnb_reservations = mutate(airbnb_reservations, date_reservation = ymd(date))




ui <- dashboardPage(
  dashboardHeader(title = "AirBnb Analysis!"),
  dashboardSidebar(
      selectInput(inputId = 'appartment_features',
                  label = "Appartment Features",
                  choices = c("Accommodates","Bedrooms", "Bathrooms", "Beds", "Bed Type", "Room Type"),
                  selected = "Accommodates"),
      radioButtons(inputId = "linecolor",
                   label = "Color",
                   choices = c("black","red","green", "blue", "orange"),
                   selected = "red"),
      numericInput(inputId = "number_owners",
                   label = "Number of owners (max 30)",
                   value = 15,
                   max = 30),
      radioButtons(inputId = "barcolors",
                   label = "Color of vertical bar",
                   choices = c("black","red","green", "blue", "orange")),
      dateRangeInput(inputId = "daterange",
                     label = "Period of visit time",
                     start = "2013-01-01",
                     end = "2014-01-01",
                     max = max(airbnb_reservations$date_reservation),
                     min = min(airbnb_reservations$date_reservation)),
      radioButtons(inputId = "horizontalbarcolor",
                   label = "Color of horizontal bar",
                   choices = c("black","red","green", "blue", "orange")),
      selectInput(inputId = 'lineviscolor',
                  label = "Color of line",
                  choices = c("black","red","green", "blue", "orange"),
                  selected = "blue"),
      numericInput(inputId = "linewidth",
                   label = "Line Width",
                   value = 0.5,
                   step = 0.1,
                   max = 1.5)
                ),
  dashboardBody(
    fluidRow(
      box(title = "Average of price by appartments features",
          solidHeader = T,
          width = 6,
          collapsible = T,
          plotlyOutput("plotapptfea")),    
      box(title = "Number of appartments by owner",
          solidHeader = T,
          width = 6,
          collapsible = T,
          plotlyOutput("ownernumb"))          
            ),
    fluidRow(
      box(title = "Average of price by quarters or arrondissements",
          solidHeader = T,
          width = 6,
          collapsible = T,
          plotlyOutput("plotarrond")),    
      box(title = "Visit frequency of the different quarters according to time",
          solidHeader = T,
          width = 6,
          collapsible = T,
          plotlyOutput("plotvisits"))
            )
                )
                  )


server <- function(input,output){

  output$plotapptfea <- renderPlotly({
  
    # Summarize data and then plot
    
    input_test <- input$appartment_features
    
    if (input_test == "Accommodates"){
      
        data_df <- airbnb_extract %>% 
        group_by(accommodates) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
      
        print(ggplot(data=data_df) + 
              geom_point(aes(x = accommodates, y = price_mean)) +
              geom_smooth(mapping = aes(x = accommodates, y = price_mean),
                          colour=input$linecolor, method='lm'))+
              labs(x = "Number of accomodates", y = "Price Average ($)")
        
    } else if(input_test == "Bedrooms"){
      
        data_df <- airbnb_extract %>% 
        group_by(bedrooms) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
        
        print(ggplot(data=na.omit(data_df)) + 
              geom_point(aes(x = bedrooms, y = price_mean)) +
              geom_smooth(mapping = aes(x = bedrooms, y = price_mean),
                          colour=input$linecolor, method='lm'))+
              labs(x = "Number of bedrooms", y = "Price Average ($)")
      
    } else if(input_test == "Bathrooms"){
      
        data_df <- airbnb_extract %>% 
        group_by(bathrooms) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
      
        print(ggplot(data=na.omit(data_df)) + 
              geom_point(aes(x = bathrooms, y = price_mean)) +
              geom_smooth(mapping = aes(x = bathrooms, y = price_mean),
                          colour=input$linecolor, method='lm'))+
              labs(x = "Number of bathrooms", y = "Price Average ($)")

      
    } else if(input_test == "Beds"){
      
        data_df <- airbnb_extract %>% 
        group_by(beds) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
      
        print(ggplot(data=na.omit(data_df)) + 
              geom_point(aes(x = beds, y = price_mean)) +
              geom_smooth(mapping = aes(x = beds, y = price_mean),
                          colour=input$linecolor, method='lm'))+
              labs(x = "Number of beds", y = "Price Average ($)")

    } else if(input_test == "Bed Type"){
      
        data_df = airbnb_extract %>% 
        group_by(bed_type) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
      
        print(ggplot(data_df, aes(x = bed_type, y = price_mean)) +
                geom_col(fill=input$linecolor) +
                labs(x = "Bed Type", y = "Average of Price"))
      
    } else if(input_test == "Room Type"){
      
        data_df = airbnb_extract %>% 
        group_by(room_type) %>% 
        summarise(price_mean = mean(price_num,na.rm=TRUE))
        
        print(ggplot(data_df, aes(x = room_type, y = price_mean)) +
                geom_col(fill=input$linecolor) +
                labs(x = "Room Type", y = "Average of Price"))
      
    } else 

        next 
                  
  })
  
  output$ownernumb <- renderPlotly({
    
    # Summarize data and then plot
    
      options(dplyr.summarise.inform = FALSE)
      owners_count = airbnb_extract %>%
      select(host_id,host_name) %>%
      group_by(host_id, host_name) %>% 
      summarize(count_host = n()) %>%
      arrange(desc(count_host))  %>% 
      
      head(n=input$number_owners) 
    
      ggplot(owners_count, aes(x = owners_count$count_host, y = reorder(owners_count$host_name
                                                                      ,owners_count$count_host ))) +
      geom_col(fill=input$horizontalbarcolor) +
      geom_text(aes(label = owners_count$count_host), nudge_x = 6, colour="Red") +
      labs(x = "Number of appartments", y = "Owner")  
    
  })
  
  output$plotarrond <- renderPlotly({
    
    # Summarize data and then plot
    
      arro_price = airbnb_extract %>% 
      group_by(arrondissement) %>% 
      summarise(price_mean = mean(price_num,na.rm=TRUE))
    
      ggplot(arro_price, aes(x = reorder(arrondissement,price_mean), y = price_mean)) +
      geom_col(fill=input$barcolors) +
      labs(x = "Quarter (Arrondissement)", y = "Average of Price")
    
  })
  
  output$plotvisits <- renderPlotly({
    
      res_data = airbnb_reservations %>%
      select(date_reservation, arrondissement) %>%
      filter(date_reservation %in% input$daterange) %>%
      group_by(arrondissement)%>% 
      summarise(count_visits = n())
    
      ggplot(data=res_data, aes(x=arrondissement, y=count_visits, group=1)) +
      geom_path(linewidth=input$linewidth, colour = input$lineviscolor)+
      geom_point()+
      labs(x = "Quarter (Arrondissement)", y = "Total of visits")
    
  })