## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

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
    gsub(" ", "", x = .) -> web_champ_name_bronze
  
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
    gsub(" ", "", x = .) -> web_champ_name_silver
  
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
    gsub(" ", "", x = .) -> web_champ_name_gold
  
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
    gsub(" ", "", x = .) -> web_champ_name_platinum
  
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
    gsub(" ", "", x = .) -> web_champ_name_diamond
  
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
  
  champ_name %>%
    gsub(" ", "", x = .) -> champ_name
  
  
  if(tolower(tier) == "gold") {
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

## ----win_radar_plot-----------------------------------------------------
radar_win_graph = function(x) {
  
  c <- grDevices::col2rgb(c("royalblue","red"))
  
  colnames(x) <- c("Blue Team", "Red Team")
  
  labs <- c("TOP", "Jungle", "Mid", "Support",  "ADC")
  
  chartJSRadar(x, 
               labs= labs,
               main = "Win rate comparison by positions" ,
               polyAlpha = 0.2,
               lineAlpha = 0.4, 
               colMatrix = c, 
               scaleStartValue = as.numeric(min(as.numeric(min(x[[1]])),as.numeric(min(x[[2]]))))-1, 
               maxScale = as.numeric(max(as.numeric(max(x[[1]])),as.numeric(max(x[[2]]))))+0.5,
               labelSize = 30,
               )
  
}

## ----pick_radar_plot-----------------------------------------------------
radar_pick_graph = function(x) {
  
  c <- grDevices::col2rgb(c("royalblue","red"))
  
  colnames(x) <- c("Blue Team", "Red Team")
  
  labs <- c("TOP", "Jungle", "Mid", "Support",  "ADC")
  
  chartJSRadar(x, 
               labs= labs,
               main = "Pick rate comparison by positions" ,
               polyAlpha = 0.2,
               lineAlpha = 0.4, 
               colMatrix = c, 
               scaleStartValue = as.numeric(min(as.numeric(min(x[[1]])),as.numeric(min(x[[2]]))))-1, 
               maxScale = as.numeric(max(as.numeric(max(x[[1]])),as.numeric(max(x[[2]]))))+0.5,
               labelSize = 30,
  )
  
}


## ----pick_radar_plot-----------------------------------------------------
radar_ban_graph = function(x) {
  
  c <- grDevices::col2rgb(c("royalblue","red"))
  
  colnames(x) <- c("Blue Team", "Red Team")
  
  labs <- c("TOP", "Jungle", "Mid", "Support",  "ADC")
  
  chartJSRadar(x, 
               labs= labs,
               main = "Ban rate comparison by positions" ,
               polyAlpha = 0.2,
               lineAlpha = 0.4, 
               colMatrix = c, 
               scaleStartValue = as.numeric(min(as.numeric(min(x[[1]])),as.numeric(min(x[[2]]))))-1, 
               maxScale = as.numeric(max(as.numeric(max(x[[1]])),as.numeric(max(x[[2]]))))+0.5,
               labelSize = 30,
  )
  
}

## ----estimating_win_probability_of_teams-----------------------------------------------------
team_win_prob = function(pick, win, ban) {
  
  blue = cbind(pick[[1]], win[[1]], ban[[1]])
  
  red = cbind(pick[[2]], win[[2]], ban[[2]])
               
  blue_each_win_prob = numeric(5)
  
  red_each_win_prob = numeric(5)
  
  for(i in 1:nrow(blue)) {
    
    blue_each_win_prob[i] <- blue[i,1]*0.2 + blue[i,2]*0.5 + blue[i,3]*0.3
   
    red_each_win_prob[i] <- red[i,1]*0.2 + red[i,2]*0.5 + red[i,3]*0.3
     
  }
  
  blue_overall_prob = sum(blue_each_win_prob) / 5             
  
  red_overall_prob = sum(red_each_win_prob) / 5       
  
  
  return(c(blue_overall_prob, red_overall_prob))
  
}

## ----pie_graph-----------------------------------------------------
pie_graph = function(x) {

  
  prob = numeric(2)
  prob[1] = x[1]/sum(x)*100
  prob[2] = x[2]/sum(x)*100
  
  dat = data.frame(prob, Teams=c(paste("Blue", round(prob[1],2), "%"),
                                 paste("Red", round(prob[2],2), "%")))
  
  # dat$fraction = dat$prob / sum(dat$prob)
  # 
  # dat$ymax = cumsum(dat$fraction)
  # dat$ymin = c(0, dat$fraction[2])
  # 
  # dat$Teams <- factor(dat$Teams, levels = c("Blue", "Red"))

  
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=16, face="bold")
    )

  
  # p1 = ggplot(dat, aes(x="", y=prob, fill = Teams)) + 
  #   geom_bar(width = 1, stat = "identity") +
  #   scale_fill_manual(values = c("#56B4E9", "#CC6666"))
    
    
  
  # pie <- p1 + coord_polar("y", start=0, direction = -1)
  

  p1 = ggplot(dat, aes(x="", y=prob, fill = Teams)) + 
    geom_bar(width = 1, stat = "identity") +
    scale_fill_manual(values = c("#56B4E9", "#CC6666")) +
    coord_polar(theta="y") +
    labs(title="Winning Rates")

  rates1 <- p1 + blank_theme
    
  rates1
  
}


champ_name = function() {
  
  champ_list = read_html("http://www.leagueofgraphs.com/champions/stats")
  
  champ_list %>%
    html_nodes(xpath = '//*[@id="mainContent"]/div/div/div/table') %>%
    html_table(fill = TRUE) -> champ_list
  
  champ_list[[1]]$Name %>% 
    grep("          \r\n", x = ., value = T) %>%
    gsub("\r\n.*", "", x = .) %>%
    gsub(" ", "", x = .) -> champ_list
}

  
  
  
  
  
  