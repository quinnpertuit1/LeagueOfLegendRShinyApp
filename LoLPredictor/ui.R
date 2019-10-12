# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny); library("jsonlite"); library("rvest")

shinyUI(fluidPage(
  
  # Application title
  titlePanel("LoL Predictor"),
  
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      h3("API Key"),
      textInput("key",
                "API Key:"),
      
      h3("Team Blue"),
      h4("Top"),
      textInput("team1_top_summ",
                "Summoner Name:",
                "JoeunDay"),
      textInput("team1_top_champ",
                "Champion Name:",
                "Caitlyn"),
      h4("Jungle"),
      textInput("team1_jungle_summ",
                "Summoner Name:",
                "galmaegi12"),
      textInput("team1_jungle_champ",
                "Champion Name:",
                "Morgana"),
      
      h4("Mid"),
      textInput("team1_mid_summ",
                "Summoner Name:",
                "Doqi"),
      textInput("team1_mid_champ",
                "Champion Name:",
                "Leona"),
      
      h4("ADC"),
      textInput("team1_adc_summ",
                "Summoner Name:",
                "JoonsMoons"),
      textInput("team1_adc_champ",
                "Champion Name:",
                "Braum"),
      
      h4("Support"),
      textInput("team1_supp_summ",
                "Summoner Name:",
                "Teamfighting"),
      textInput("team1_supp_champ",
                "Champion Name:",
                "Jhin"),
      
      h3("Team Red"),
      h4("Top"),
      textInput("team2_top_summ",
                "Summoner Name:",
                "Lidds"),
      textInput("team2_top_champ",
                "Champion Name:",
                "Fiora"),
      h4("Jungle"),
      textInput("team2_jungle_summ",
                "Summoner Name:",
                "1302B"),
      textInput("team2_jungle_champ",
                "Champion Name:",
                "Nocturne"),
      
      h4("Mid"),
      textInput("team2_mid_summ",
                "Summoner Name:",
                "Shifu Yee"),
      textInput("team2_mid_champ",
                "Champion Name:",
                "Maokai"),
      
      h4("ADC"),
      textInput("team2_adc_summ",
                "Summoner Name:",
                "Smooth Duder"),
      textInput("team2_adc_champ",
                "Champion Name:",
                "Kassadin"),
      
      h4("Support"),
      textInput("team2_supp_summ",
                "Summoner Name:",
                "Vendriv"),
      textInput("team2_supp_champ",
                "Champion Name:",
                "Rakan"),
      
      submitButton("Submit")
    ),
    
    
    mainPanel(
      h4("Summoner ID's"),
      tableOutput("id"),
      
      h4("Champion ID's"),
      tableOutput("champ_id"),
      
      h4("Summoner ID + Champion ID"),
      tableOutput("all_ids"),
      
      h4("Class of above reactive object"),
      textOutput("class_all_ids"),
      
      h4("Subset of ID + Champion ID. Position 3, 2 (Should return 3rd champ_id)"),
      textOutput("subset1"),
      
      h4("Personal Winrates Table"),
      tableOutput("personal_win_df"),
      
      #h4("Text vector input for get_id"),
      #textOutput("id2"),
      
      #h4("champion table"),
      #tableOutput("table"),
      
      #h4("id of chosen champion:"),
      #textOutput("champ_id"),
      
      #h4("details of personal stats retrieved"),
      #verbatimTextOutput("summary_personal"), #This needs fixing. Currently, it does not display a table, so I had to print a summary
      
      #h4("Personal win rate:"),
      #textOutput("personal_win")
      
      
      # Youngseok -> "Case insensitive / champions never played (data from web) / new function"
      # Example output below. Try anything with any champions.
      
      h4("Test names vector"),
      tableOutput("names"),
      
      
      h4("names win rate"),
      tableOutput("personal_win_df2")
      
      
    )
  )
))


