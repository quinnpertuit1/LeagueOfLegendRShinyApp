## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ------------------------------------------------------------------------
APIkey = "RGAPI-5f9ec25e-6ac2-4d82-9e56-3a5612c9b512" 
# Everyone will have different API key


## ----get_id--------------------------------------------------------------
# install.packages("jsonlite") : install "jsonlite" package to use API
library(jsonlite) # load jsonlite library

#Retrieves summoner id. Takes in 2 arguments: Summoner Name and API Key.
get_id = function(summoner_name, key) {
  summoner_name <- gsub(' ', "%20", summoner_name)
  Summonerurl <- paste("https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/",summoner_name,"?api_key=",key, sep = "")
  # Get the url of requested api data
  
  SummonerID <- fromJSON(Summonerurl) # Get the api data into "SummonerID" variable
  
  id = SummonerID$id
  # From Riot's API and a given game id, get the unique serial numbers for that id and assign this numeric values into "id" variable
  return(id)
}

## ----champ_info----------------------------------------------------------
#Returns matrix (dimensions: number of champions x 2) containing id and names of all champions currently in League of Legends.
champ_info = function(key) {
  championurl <- paste("https://kr.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&dataById=false&api_key=",key, sep="")
  champions <- fromJSON(championurl)
  # Get all champions data including id and name from Riot's API
    
  x = matrix(,length(champions[[1]]),2)
  # Create a empty matrix with 2 columns and 137 rows so that it can contain id and name of 137 champions in each row
  
  for(i in 1:137) {
    x[i,] = c(champions[[1]][[i]]$id, champions[[1]][[i]]$name) 
    # In each row, add champion id on first column and name no second column
  }
  return(x)
  # If this function is called, it will return the matrix containing id and names of all champions
}

## ----get_champ_id--------------------------------------------------------
get_champ_id = function(champ_name, key) { # A function to get champion unique id number if user input champion's name (case insensitive)

  champ_table = champ_info(key)
  # Load champion data by calling champ_info function.
  # Champion data table will contain ID in first column and Name in second column
  
  for(i in 1:137) { # For loop to check all champion data table
    
    if(toupper(champ_name) == toupper(champ_table[i,2])) { 
      # If chosen champion name equals to the value in champion data table's second column of a specific row,
      return(champ_table[i,1]) # Then, return the value in first column in the same row
    }
  }
}

 ## ----get_personal_champ_stat---------------------------------------------
 get_personal_champ_stat1 = function(summoner_id, champ_id, key) {
   
   staturl <- paste("https://na.api.riotgames.com/api/lol/NA/v1.3/stats/by-summoner/",summoner_id,"/ranked?season=SEASON2017&api_key=",key, sep = "")
   stat <- fromJSON(staturl)
   # With the given summonerid, get the player's game statistics 
   # This dataset will include various data for each champion they have played in the chosen season (2017)
   
   
   personal_champ_stat_data = matrix(,1,length(stat[[3]][[2]]))
   # Create a empty 1 row matrix that will contain all data with the chosen champion
   
   if(!(champ_id %in% stat[[3]][[1]])) { # If chosen champion is not in the dataset,
     cat("You haven't played this champion.") # Then, it means, the user haven't played that champion before
   }
   
   
   for(i in 1:length(stat[[3]][[1]])) { 
     
     if(champ_id == stat[[3]][[1]][i]) {
      personal_champ_stat_data = stat[[3]][i,] 
     }
   
   }
   
   return(personal_champ_stat_data)
     
 }

## ----get_personal_champ_stat---------------------------------------------
get_personal_champ_stat2 = function(summoner_name, champ_name, key) {
  
  summoner_id = get_id(summoner_name, key) # Get user to input their game id and store the function return value (summonerID) in "summonerid"" variable
  champ_id = as.numeric(get_champ_id(champ_name, key)) # Get user to input their chosen champion's name and store the function return value (championID) in "champ_id"" variable as numeric value
  
  staturl <- paste("https://na.api.riotgames.com/api/lol/NA/v1.3/stats/by-summoner/",summoner_id,"/ranked?season=SEASON2017&api_key=", key, sep = "")
  stat <- fromJSON(staturl)
  # With the given summonerid, get the player's game statistics 
  # This dataset will include various data for each champion they have played in the chosen season (2017)
  
  
  personal_champ_stat_data = matrix(,1,length(stat[[3]][[2]]))
  # Create a empty 1 row matrix that will contain all data with the chosen champion
  
  if(!(champ_id %in% stat[[3]][[1]])) { # If chosen champion is not in the dataset,
    return("Never Played Champion")
  }
  
  for(i in 1:length(stat[[3]][[1]])) { 
    
    if(champ_id == stat[[3]][[1]][i]) {
      personal_champ_stat_data = stat[[3]][i,] 
    }
    
  }
  
  return(personal_champ_stat_data)
  
}

## ----get_personal_tier-----------------------------------------
get_tier = function(summoner_name, key) {
  summonerid = get_id(summoner_name, key)
  
  leagueurl <- paste("https://na1.api.riotgames.com/lol/league/v3/leagues/by-summoner/",summonerid,"?api_key=",key, sep="")
  league <- fromJSON(leagueurl)
  
  return(league$tier)
}

## ----get_personal_champ_win_rate-----------------------------------------
 get_personal_champ_win_rate1 = function(summoner_id, champ_id, key) {
   stat <- get_personal_champ_stat1(summoner_id, champ_id, key)
   total_played = stat[[2]]$totalSessionsPlayed
   total_win = stat[[2]]$totalSessionsWon
  
   win_rate = total_win / total_played * 100
     
   return(win_rate)
 }

## ----get_personal_champ_win_rate-----------------------------------------
get_personal_champ_win_rate2 = function(summoner_name, champ_name, key) {
  stat <- get_personal_champ_stat2(summoner_name, champ_name, key)
  
  if(is.character(stat)) {
    tier <- get_tier(summoner_name, key)
    
    if(tolower(tier) == "bronze") {
      return(get_web_stat_bronze(champ_name))
    }
    else if(tolower(tier) == "silver") {
      return(get_web_stat_silver(champ_name))
    }
    else if(tolower(tier) == "gold") {
      return(get_web_stat_gold(champ_name))
    }
    else if(tolower(tier) == "platinum") {
      return(get_web_stat_platinum(champ_name))
    }
    else {
      return(get_web_stat_diamond(champ_name))
    }
    
  } else {
    total_played = stat[[2]]$totalSessionsPlayed
    total_win = stat[[2]]$totalSessionsWon
    
    win_rate = total_win / total_played * 100
    
    return(win_rate)
  }
}

## ----web_bronze_stat-----------------------------------------------------
# install.packages("rvest")
library(rvest)

get_web_stat_bronze = function(name) {
  
  stat_bronze = read_html("http://www.leagueofgraphs.com/champions/stats/bronze")
  
  stat_bronze %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_stat_bronze
  
  champ_stat_bronze[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    sub(" .*", "", x = .) -> web_champ_name_bronze
  
  champ_stat_bronze[[1]]$WinRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_win_rate_bronze
  
  champ_stat_bronze[[1]]$Popularity %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_pick_rate_bronze
  
  champ_stat_bronze[[1]]$BanRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_ban_rate_bronze
  
  web_bronze_stat = matrix(c((web_champ_name_bronze), (web_champ_pick_rate_bronze), (web_champ_win_rate_bronze), (web_champ_ban_rate_bronze)), ncol = 4)
  
  for(i in 1:nrow(web_bronze_stat)) {
    if(tolower(web_bronze_stat[i,1]) == tolower(name)) {
      return(web_bronze_stat[i,])
    }
  }
  
}

## ----web_silver_stat-----------------------------------------------------
get_web_stat_silver = function(name) {
  
  stat_silver = read_html("http://www.leagueofgraphs.com/champions/stats/silver")
  
  stat_silver %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_stat_silver
  
  champ_stat_silver[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    sub(" .*", "", x = .) -> web_champ_name_silver
  
  champ_stat_silver[[1]]$WinRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_win_rate_silver
  
  champ_stat_silver[[1]]$Popularity %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_pick_rate_silver
  
  champ_stat_silver[[1]]$BanRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_ban_rate_silver
  
  web_silver_stat = matrix(c((web_champ_name_silver), (web_champ_pick_rate_silver), (web_champ_win_rate_silver), (web_champ_ban_rate_silver)), ncol = 4)
  
  for(i in 1:nrow(web_silver_stat)) {
    if(tolower(web_silver_stat[i,1]) == tolower(name)) {
      return(web_silver_stat[i,])
    }
  }
  
  
}

## ----web_gold_stat-----------------------------------------------------
get_web_stat_gold = function(name) {
  
  stat_gold = read_html("http://www.leagueofgraphs.com/champions/stats")
  
  stat_gold %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_stat_gold
  
  champ_stat_gold[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    sub(" .*", "", x = .) -> web_champ_name_gold
  
  champ_stat_gold[[1]]$WinRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_win_rate_gold
  
  champ_stat_gold[[1]]$Popularity %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_pick_rate_gold
  
  champ_stat_gold[[1]]$BanRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_ban_rate_gold
  
  web_gold_stat = matrix(c((web_champ_name_gold), (web_champ_pick_rate_gold), (web_champ_win_rate_gold), (web_champ_ban_rate_gold)), ncol = 4)
  
  for(i in 1:nrow(web_gold_stat)) {
    if(tolower(web_gold_stat[i,1]) == tolower(name)) {
      return(web_gold_stat[i,])
    }
  }
  
}


## ----web_platinum_stat-----------------------------------------------------
get_web_stat_platinum = function(name) {
  
  stat_platinum = read_html("http://www.leagueofgraphs.com/champions/stats/platinum")
  
  stat_platinum %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_stat_platinum
  
  champ_stat_platinum[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    sub(" .*", "", x = .) -> web_champ_name_platinum
  
  champ_stat_platinum[[1]]$WinRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_win_rate_platinum
  
  champ_stat_platinum[[1]]$Popularity %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_pick_rate_platinum
  
  champ_stat_platinum[[1]]$BanRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_ban_rate_platinum
  
  
  web_platinum_stat = matrix(c((web_champ_name_platinum), (web_champ_pick_rate_platinum), (web_champ_win_rate_platinum), (web_champ_ban_rate_platinum)), ncol = 4)
  
  for(i in 1:nrow(web_platinum_stat)) {
    if(tolower(web_platinum_stat[i,1]) == tolower(name)) {
      return(web_platinum_stat[i,])
    }
  }
  
}

## ----web_diamond_stat-----------------------------------------------------
get_web_stat_diamond = function(name) {
  
  stat_diamond = read_html("http://www.leagueofgraphs.com/champions/stats/diamond")
  
  stat_diamond %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_stat_diamond
  
  champ_stat_diamond[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    sub(" .*", "", x = .) -> web_champ_name_diamond
  
  champ_stat_diamond[[1]]$WinRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_win_rate_diamond
  
  champ_stat_diamond[[1]]$Popularity %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_pick_rate_diamond
  
  champ_stat_diamond[[1]]$BanRate %>%
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub('\\%', '', x = .) -> web_champ_ban_rate_diamond
  
  web_diamond_stat = matrix(c((web_champ_name_diamond), (web_champ_pick_rate_diamond), (web_champ_win_rate_diamond), (web_champ_ban_rate_diamond)), ncol = 4)
  
  for(i in 1:nrow(web_diamond_stat)) {
    if(tolower(web_diamond_stat[i,1]) == tolower(name)) {
      return(web_diamond_stat[i,])
    }
  }
}

## ----web_diamond_stat-----------------------------------------------------
get_web_data = function(champ_name, tier, lane) {
  
  if(tier == "gold") {
    tier = ""
  }
  
  tier <- tolower(tier)
  lane <- tolower(lane)
  
  url_html = paste("http://www.leagueofgraphs.com/champions/stats/",lane,"/",tier,"/", sep = "")
  
  
  
  data_url <- read_html(url_html)
  
  data_url %>%
    html_nodes(xpath = '//*[(@id = "mainContent")]//*[contains(concat( " ", @class, " " ), concat( " ", "name", " " ))]') %>%
    html_text() %>%
    gsub("\r\n.", "", x = .) %>%
    gsub(" ", "", x = .) -> data_name
  
  
  data_url %>%
    html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//*[contains(concat( " ", @class, " " ), concat( " ", "percentage", " " ))]') %>%
    html_text() %>%
    gsub('\\%', '', x = .) -> data_pick_rate
    
  
  data_url %>%
    html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 4) and parent::*)]//*[contains(concat( " ", @class, " " ), concat( " ", "percentage", " " ))]') %>%
    html_text() %>%
    gsub('\\%', '', x = .) -> data_win_rate
    

  data_url %>%
    html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 5) and parent::*)]//*[contains(concat( " ", @class, " " ), concat( " ", "percentage", " " ))]') %>%
    html_text() %>%
    gsub('\\%', '', x = .) ->  data_ban_rate
    
  
  pick_rate = numeric(length(data_name))
  win_rate = numeric(length(data_name))
  ban_rate = numeric(length(data_name))
  
    
  for(i in 1:length(data_name)) {
    
    pick_rate[i] <- as.numeric(data_pick_rate[i*3])
    
    win_rate[i] <- as.numeric(data_win_rate[i*3])
    
    ban_rate[i] <- as.numeric(data_ban_rate[i*3])
    
  }
  
  table = matrix(c(data_name, pick_rate, win_rate, ban_rate), ncol = 4, dimnames = NULL)

  if(!(champ_name %in% data_name)) {
    
    if(tolower(tier) == "bronze") {
      return(get_web_stat_bronze(champ_name))
    }
    else if(tolower(tier) == "silver") {
      return(get_web_stat_silver(champ_name))
    }
    else if(tolower(tier) == "diamond") {
      return(get_web_stat_diamond(champ_name))
    }
    else if(tolower(tier) == "platinum") {
      return(get_web_stat_platinum(champ_name))
    }
    else {
      return(get_web_stat_gold(champ_name))
    }
    
  }
  else {
    for(i in 1:nrow(table)) {
      if(tolower(table[i,1]) == tolower(champ_name)) {
        return(table[i,])
      }
    }
    
    
  }

}




