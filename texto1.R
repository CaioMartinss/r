library(rvest)  
library(stringr)  
library(tidytext)  
library(dplyr)
library(ggplot2)  
library(tidyr) 
library(tm)
library(NLP)
library(wordcloud)
library(wesanderson)
library(knitr)
library(rmarkdown)
library(kableExtra)
library(htmltools)
library(prettydoc)


library(syuzhet)
library(RColorBrewer)



library(tm)
library(wordcloud)
library(SentimentAnalysis)
library(RColorBrewer)





#texto(carta de amor - roupa)
texto <- readLines("texto1.txt")
texto_palavras <- get_tokens(texto)

head(texto_palavras)
length(texto_palavras)

oracao <- get_sentences(texto)
length(oracao)
indelevel_sentimentos <- get_nrc_sentiment(texto_palavras, language = "portuguese")

colnames(indelevel_sentimentos) <- c('Raiva', 'Ansiedade', 'Desgosto', 'Medo', 'Alegria', 'Tristeza', 'Surpresa', 'Confiança')
barplot(
  colSums(prop.table(indelevel_sentimentos[, 1:8])),
  space = 0.1,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "carta de amor - texto1",
  sub = "caio martins do nascimento",
  xlab = "Emoções",ylab=NULL
)




