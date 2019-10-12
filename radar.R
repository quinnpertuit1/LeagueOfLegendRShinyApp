#install.packages("radarchart")
#devtools::install_github("MangoTheCat/radarchart")
#devtools::install()

library(radarchart)

c <- grDevices::col2rgb(c("royalblue","red"))

Winningrates <- c("Top", "Jungle", "Mid",
          "ADC",  "Support")

scores <- list(
  "Team Blue" = c(0.54, 0.52, 0.50, 0.49, 0.45),
  "Team  Red" = c(0.50, 0.55, 0.49, 0.47, 0.51)
)

scores <- data.frame("Label"=c("Top", "Jungle", "Mid",
                               "ADC",  "Support"),
                     "Team Blue" = c(0.54, 0.52, 0.50, 0.49, 0.45),
                     "Team  Red" = c(0.50, 0.55, 0.49, 0.47, 0.51)
                     )
chartJSRadar(scores, polyAlpha = 0.2, lineAlpha = 0.2, colMatrix = c, scaleStartValue = 0.4, maxScale = 0.55, showToolTipLabel=TRUE)