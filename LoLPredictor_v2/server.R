# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny); library("rvest"); library("magrittr"); library("ggplot2"); library(radarchart)
source("../functions_v2.R")

shinyServer(function(input, output) {
  
  #Reactive vector with 21 entries, in the following order:
  #Entry 1: Tier
  #Entries 2-6: Blue team champion names
  #Entries 7-11: Red team champion names
  input_vector = reactive({
    c(input$tier,
      input$team1_top_champ, input$team1_jungle_champ, input$team1_mid_champ, input$team1_supp_champ, input$team1_adc_champ,
      input$team2_top_champ, input$team2_jungle_champ, input$team2_mid_champ, input$team2_supp_champ, input$team2_adc_champ)
  })
  
  
  ########## WINRATES
  #Blue team win rates into a vector: (top win rate, jungle win rate, mid win rate, support win rate, adc win rate)
  blue_win = reactive({
    bluewin = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    bluewin[1] = as.numeric(get_web_data(input_vector()[2], input_vector()[1], "Top")[3]) #3 corresponds to the "win" object in return
    bluewin[2] = as.numeric(get_web_data(input_vector()[3], input_vector()[1], "Jungle")[3])
    bluewin[3] = as.numeric(get_web_data(input_vector()[4], input_vector()[1], "Middle")[3])
    bluewin[4] = as.numeric(get_web_data(input_vector()[5], input_vector()[1], "Support")[3])
    bluewin[5] = as.numeric(get_web_data(input_vector()[6], input_vector()[1], "ADC")[3])
    return(bluewin)
  })
  
  #Red team win rates into a vector. Same process as above.
  red_win = reactive({
    redwin = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    redwin[1] = as.numeric(get_web_data(input_vector()[7], input_vector()[1], "Top")[3]) #3 corresponds to the "win" object in return
    redwin[2] = as.numeric(get_web_data(input_vector()[8], input_vector()[1], "Jungle")[3])
    redwin[3] = as.numeric(get_web_data(input_vector()[9], input_vector()[1], "Middle")[3])
    redwin[4] = as.numeric(get_web_data(input_vector()[10], input_vector()[1], "Support")[3])
    redwin[5] = as.numeric(get_web_data(input_vector()[11], input_vector()[1], "ADC")[3])
    return(redwin)
  })
  
  #All 10 win rates into a data frame
  winrates_df = reactive({
   windf = data.frame(Blue = blue_win(), Red = red_win(), row.names = c("Top", "Jungle", "Mid", "Support", "ADC"), stringsAsFactors = FALSE)
   return(windf)
  })
  
  ########## BANRATES
  #Almost the exact same process as winrates, but subsetting the returned object from the get_web_data() function differently
  blue_ban = reactive({
    blueban = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    blueban[1] = as.numeric(get_web_data(input_vector()[2], input_vector()[1], "Top")[4]) #3 corresponds to the "win" object in return
    blueban[2] = as.numeric(get_web_data(input_vector()[3], input_vector()[1], "Jungle")[4])
    blueban[3] = as.numeric(get_web_data(input_vector()[4], input_vector()[1], "Middle")[4])
    blueban[4] = as.numeric(get_web_data(input_vector()[5], input_vector()[1], "Support")[4])
    blueban[5] = as.numeric(get_web_data(input_vector()[6], input_vector()[1], "ADC")[4])
    return(blueban)
  })
  
  red_ban = reactive({
    redban = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    redban[1] = as.numeric(get_web_data(input_vector()[7], input_vector()[1], "Top")[4]) #3 corresponds to the "ban" object in return
    redban[2] = as.numeric(get_web_data(input_vector()[8], input_vector()[1], "Jungle")[4])
    redban[3] = as.numeric(get_web_data(input_vector()[9], input_vector()[1], "Middle")[4])
    redban[4] = as.numeric(get_web_data(input_vector()[10], input_vector()[1], "Support")[4])
    redban[5] = as.numeric(get_web_data(input_vector()[11], input_vector()[1], "ADC")[4])
    return(redban)
  })
  
  banrates_df = reactive({
    bandf = data.frame(Blue = blue_ban(), Red = red_ban(), row.names = c("Top", "Jungle", "Mid", "Support", "ADC"), stringsAsFactors = FALSE)
    return(bandf)
  })
  
  ########## PICKRATES
  #Again, the same method. The manual, but reliable one.
  blue_pick = reactive({
    bluepick = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    bluepick[1] = as.numeric(get_web_data(input_vector()[2], input_vector()[1], "Top")[2]) #3 corresponds to the "win" object in return
    bluepick[2] = as.numeric(get_web_data(input_vector()[3], input_vector()[1], "Jungle")[2])
    bluepick[3] = as.numeric(get_web_data(input_vector()[4], input_vector()[1], "Middle")[2])
    bluepick[4] = as.numeric(get_web_data(input_vector()[5], input_vector()[1], "Support")[2])
    bluepick[5] = as.numeric(get_web_data(input_vector()[6], input_vector()[1], "ADC")[2])
    return(bluepick)
  })
  
  red_pick = reactive({
    redpick = numeric(5)
    #The below can be made into a for loop if we change each "lane" argument for the get_web_data() function into a number.
    #But this method is easier and faster to run
    redpick[1] = as.numeric(get_web_data(input_vector()[7], input_vector()[1], "Top")[2]) #3 corresponds to the "pick" object in return
    redpick[2] = as.numeric(get_web_data(input_vector()[8], input_vector()[1], "Jungle")[2])
    redpick[3] = as.numeric(get_web_data(input_vector()[9], input_vector()[1], "Middle")[2])
    redpick[4] = as.numeric(get_web_data(input_vector()[10], input_vector()[1], "Support")[2])
    redpick[5] = as.numeric(get_web_data(input_vector()[11], input_vector()[1], "ADC")[2])
    return(redpick)
  })
  
  pickrates_df = reactive({
    pickdf = data.frame(Blue = blue_pick(), Red = red_pick(), row.names = c("Top", "Jungle", "Mid", "Support", "ADC"), stringsAsFactors = FALSE)
    return(pickdf)
  })
  
  ########## PLOTS
  radar_win = reactive({
    
    radar_win_graph(winrates_df())
    
  })
  
  
  radar_pick = reactive({
    
    radar_pick_graph(pickrates_df())
    
  })
  
  radar_ban = reactive({
    
    radar_ban_graph(banrates_df())
    
  })
  
  prob = reactive({
  
    team_win_prob(pickrates_df(), winrates_df(), banrates_df())
    
  })

  
  prediction = reactive({
    
    pie_graph(prob())
    
  })

  
  
  ########## OUTPUTS
  output$radarwin = renderChartJSRadar({radar_win()})
  output$radarpick = renderChartJSRadar({radar_pick()})
  output$radarban = renderChartJSRadar({radar_ban()})
  
  
  
  
  output$winrates = renderTable({winrates_df()})
  output$banrates = renderTable({banrates_df()})
  output$pickrates = renderTable({pickrates_df()})

  output$pie = renderPlot({prediction()})
  
  
  
})

