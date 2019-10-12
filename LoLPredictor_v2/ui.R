# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny); library("jsonlite"); library("rvest")
source("../functions_v2.R")

shinyUI(fluidPage(
  
  # Application title
  titlePanel("LoL Predictor"),
  
  
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput("tier",
                  "Choose Tier:",
                  choices = c("Bronze", "Silver", "Gold", "Platinum", "Diamond")),
      
      h3("Team Blue"),
      h4("Top"),
      selectizeInput("team1_top_champ",  
                     "Champion Name:", 
                     choices = champ_name(), 
                     selected = "Darius", multiple = FALSE,
                     options = NULL),
      
      h4("Jungle"),
      selectizeInput("team1_jungle_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Sejuani", multiple = FALSE,
                options = NULL),
      
      h4("Mid"),
      selectizeInput("team1_mid_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Ahri", multiple = FALSE,
                options = NULL),
      
      h4("Support"),
      selectizeInput("team1_supp_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Braum", multiple = FALSE,
                options = NULL),
      
      h4("ADC"),
      selectizeInput("team1_adc_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Caitlyn", multiple = FALSE,
                options = NULL),
      
      
      h3("Team Red"),
      h4("Top"),
      selectizeInput("team2_top_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Fiora", multiple = FALSE,
                options = NULL),
      
      h4("Jungle"),
      selectizeInput("team2_jungle_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Nocturne", multiple = FALSE,
                options = NULL),
      
      h4("Mid"),
      selectizeInput("team2_mid_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Kassadin", multiple = FALSE,
                options = NULL),
    
      h4("Support"),
      selectizeInput("team2_supp_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Rakan", multiple = FALSE,
                options = NULL),
      
      h4("ADC"),
      selectizeInput("team2_adc_champ",
                "Champion Name:",
                choices = champ_name(),
                selected = "Vayne", multiple = FALSE,
                options = NULL),
      
      submitButton("Submit")
    ),
    
    
    mainPanel(
      h4("Win Rates"),
      tableOutput("winrates"),
      
      h4("Ban Rates"),
      tableOutput("banrates"),
      
      h4("Pick Rates"),
      tableOutput("pickrates"),
      h4("Radar Win Plot"),
      chartJSRadarOutput("radarwin"),
      
      h4("Radar Pick Plot"),
      chartJSRadarOutput("radarpick"),
      
      h4("Radar Ban Plot"),
      chartJSRadarOutput("radarban"),
      
      h4("Prediction"),
      plotOutput("pie", width = "100%", height = "600px")
      
    )
  )
))

