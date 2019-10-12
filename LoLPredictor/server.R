# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny); library("jsonlite"); library("rvest")
source("../functions.R")

shinyServer(function(input, output) {
  
  #Reactive vector with 21 entries, in the following order:
  #Entry 1: API key
  #Entries 2-6: Blue team summoner names in the order: Top, Jungle, Mid, Supp, ADC
  #Entries 7-11: Red team summoner names in the same order
  #Entries 12-16: Blue team champion names in the same order
  #Entries 17-21: Red team champion names in the same order
  input_vector = reactive({
    c(input$key, 
      input$team1_top_summ, input$team1_jungle_summ, input$team1_mid_summ, input$team1_supp_summ, input$team1_adc_summ,
      input$team2_top_summ, input$team2_jungle_summ, input$team2_mid_summ, input$team2_supp_summ, input$team2_adc_summ,
      input$team1_top_champ, input$team1_jungle_champ, input$team1_mid_champ, input$team1_supp_champ, input$team1_adc_champ,
      input$team2_top_champ, input$team2_jungle_champ, input$team2_mid_champ, input$team2_supp_champ, input$team2_adc_champ)
  })
  
  #Initialize a matrix with all champions currently existing in league, and their unique champion IDs.
  champ_frame = reactive({
    key = input$key
    champ_info(key)
  })
  
  #Get personal champ stat. This includes all available stats.
  personal_stat = reactive({
    key = input$key
    champ_name = input$champ_name
    summoner_name = input$summoner_name
    get_personal_champ_stat(summoner_name, champ_name, key)
  })
  
  #Vectorized get_id so that it takes all the summoner names and returns all their summoner ids.
    id_vector = reactive({
      id_10 = integer(10)
      for(i in 1:10) {
        id_10[i] = get_id(input_vector()[i+1], input_vector()[1])
      }
      return(id_10)
    })
    
    
    
  # Youngseok -> "Case insensitive / champions never played (data from web) / new function"
  # Functions newly added below till 'personal_win_df2' function
    
  #Vectorized summoner names
    summ_name_vector = reactive({
      summ_name_10 = character(10)
      for(i in 2:11) {
        summ_name_10[i-1] = input_vector()[i]
      }
      return(summ_name_10)
    })
    
  #Vectorized champion names 
    champ_name_vector = reactive({
      champ_name_10 = character(10)
      for(i in 12:21) {
        champ_name_10[i-11] = input_vector()[i]
      }
      return(champ_name_10)
    })
  
  #Get Vectorized names data
    names_vector = reactive({
      return(matrix(c(summ_name_vector(), champ_name_vector()), nrow = 10, ncol = 2))
    })
    
  #Corrected personal win data (data gain from names of summoner and champion / 
  #get data from web when summoner never played the champion)
    personal_win_df2 = reactive({
      winrate_df = cleaned_data2(names_vector(), input_vector()[1])
      return(winrate_df)
    })
    
  #Vectorized get_champ_id so that it takes all champ names and returns vector of respective champ ids
    champ_id_vector = reactive({
      champ_id_10 = integer(10)
      for(i in 1:10) {
        champ_id_10[i] = get_champ_id(input_vector()[i+11], input_vector()[1])
      }
      return(champ_id_10)
    })
    
  #Coerce the above two vectors (id_vector and champ_name_vector) into one data_frame
    id_champ_df = reactive({
      id_champ_10 = data.frame("id" = id_vector(), "champ_id" = champ_id_vector(), stringsAsFactors = FALSE)
      return(id_champ_10)
    })
    
  #Get personal winrates by calling on cleaned_data() function with id_champ_df() and input_vector()[1] as parameter
    personal_win_df = reactive({
      winrate_df = cleaned_data(id_champ_df(), input_vector()[1])
      return(winrate_df)
    })
    
  #Trying to subset id_champ_df to see if that is causing the problem in personal_win_df
    subset1 = reactive({
      id_champ_df()[3,2]
    })
    

  
  #Get individual champion id
  champ_id = reactive({
    key = input$key
    champ_name = input$champ_name
    get_champ_id(champ_name, key)
  })
  

  
  personal_win = reactive({
    key = input$key
    champ_name = input$champ_name
    summoner_name = input$summoner_name
    get_personal_champ_win_rate(summoner_name, champ_name, key)
  })
  
  output$id = renderTable({id_vector()}) #Test
  output$champ_id = renderTable({champ_id_vector()})
  output$all_ids = renderTable({id_champ_df()})
  output$class_all_ids = renderText({class(id_champ_df())})
  output$personal_win_df = renderTable({personal_win_df()})
  output$subset1 = renderText({subset1()})
  #output$table = renderTable({head(champ_frame(), n = 20)})
  #output$champ_id = renderText({champ_id()})
  #output$summary_personal = renderTable({summary(personal_stat())})
  #output$personal_win = renderText({personal_win()})
  
  
  
  # Youngseok -> "Case insensitive / champions never played (data from web) / new function"
  # Example output below. Try anything with any champions.
  output$names = renderTable({names_vector()})
  output$test = renderText({class(names_vector())})
  output$personal_win_df2 = renderTable({personal_win_df2()})
  


  
})