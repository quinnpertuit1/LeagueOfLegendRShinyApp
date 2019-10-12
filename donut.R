library(ggplot2)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=12, face="bold")
  )

dat = data.frame(count=c(40,60), Teams=c("Team Blue", "Team  Red"))


dat$fraction = dat$count / sum(dat$count)

dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))

dat$Teams <- factor(dat$Teams, levels = c("Team Blue", "Team  Red"))


p1 = ggplot(dat, aes(fill=Teams, ymax=ymax, ymin=ymin, xmax=4, xmin=2)) +
  geom_rect(color='black') +
  coord_polar(theta="y") +
  xlim(c(1, 4)) 
  labs(title="Winning Rates")



rates1<-p1 + scale_fill_brewer(palette="Pastel1") + blank_theme +
  theme(axis.text.x=element_blank())  + ggtitle("") +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) +
  theme(legend.title = element_text(size=12, face="bold")) +
  theme(legend.text = element_text(size = 10, face = "bold")) 

rates1 + geom_label(aes(label=paste(fraction*100,"%"),x=3,y=(ymin+ymax)/2), show.legend = FALSE)

