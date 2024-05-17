
library(wordcloud)
library(reshape2)
library(syuzhet)
library(RColorBrewer)
library(tm)
library(openxlsx)
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


library(ggplot2)






texto1 <- readLines("texto1.txt")


texto1 <- as.data.frame(texto1)
paged_table(texto1)


transforme_texto1 <- tolower(texto1)
transforme_texto1 <- removePunctuation(transforme_texto1)
transforme_texto1 <- removeNumbers(transforme_texto1)
traformme_texto1 <- stripWhitespace(transforme_texto1)

transforme_texto1 <- removeWords(transforme_texto1, stopwords("pt"))

print(transforme_texto1)


wordcloud(transforme_texto1, min.freq = 40,  scale = c(3, 0.5), colors = brewer.pal(8, "Dark2"))

texto1_palavras <- get_tokens(transforme_texto1)

sentimento_texto1 <- get_nrc_sentiment(texto1_palavras, language = "portuguese")

colnames(sentimento_texto1) <- c('Raiva', 'Ansiedade', 'Desgosto', 'Medo', 'Alegria', 'Tristeza', 'Surpresa', 'Confiança')

barplot(
  colSums(prop.table(sentimento_texto1[, 1:8])),
  space = 0.1,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  sub = "caio martins do nascimento",
  #xlab = "Emoções",
  ylab=NULL
)

legend(
  "topleft",                                 
  legend = colnames(sentimento_texto1[, 1:8]), 
  fill = brewer.pal(n = 8, name = "Set3"),
  cex = 0.6,
  title = "Emoções"
  
)




# Definindo o número de palavras mais comuns a serem mostradas
numero_palavras <- 20

# Filtrando as 'numero_palavras' palavras mais frequentes
frequencia_df_filtrado <- frequencia_df %>%
  slice_head(n = numero_palavras)

# Criando o gráfico de frequência com as palavras mais comuns
ggplot(frequencia_df_filtrado, aes(x = reorder(word, freq), y = freq)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Frequência das Palavras Mais Comuns", x = "Palavras", y = "Frequência") +
  coord_flip() # Rotaciona o eixo x para facilitar a leitura


#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

texto2 <- readLines("texto2.txt")


texto2 <- as.data.frame(texto2)
paged_table(texto2)


transforme_texto2 <- tolower(texto2)
transforme_texto2 <- removePunctuation(transforme_texto2)
transforme_texto2 <- removeNumbers(transforme_texto2)
traformme_texto2 <- stripWhitespace(transforme_texto2)

transforme_texto2 <- removeWords(transforme_texto2, stopwords("pt"))

print(transforme_texto2)


wordcloud(transforme_texto2, min.freq = 1, scale = c(3, 0.5), colors = brewer.pal(8, "Dark2"))


texto2_palavras <- get_tokens(transforme_texto2)

sentimento_texto2 <- get_nrc_sentiment(texto2_palavras, language = "portuguese")

colnames(sentimento_texto2) <- c('Raiva', 'Ansiedade', 'Desgosto', 'Medo', 'Alegria', 'Tristeza', 'Surpresa', 'Confiança')

barplot(
  colSums(prop.table(sentimento_texto2[, 1:8])),
  space = 0.1,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  sub = "caio martins do nascimento",
  xlab = "Emoções",
  ylab=NULL
)

legend(
  "topleft",                                 
  legend = colnames(sentimento_texto2[, 1:8]), 
  fill = brewer.pal(n = 8, name = "Set3"),
  cex = 0.6,
  title = "Emoções"
  
)





# Contagem da frequência das palavras
frequencia_palavras_texto2 <- table(texto2_palavras)

# Criando um data frame com as frequências
frequencia_df_texto2 <- data.frame(word = names(frequencia_palavras_texto2), freq = as.numeric(frequencia_palavras_texto2))

# Ordenando o data frame por frequência
frequencia_df_texto2 <- frequencia_df_texto2[order(frequencia_df_texto2$freq, decreasing = TRUE), ]

# Definindo o número de palavras mais comuns a serem mostradas
numero_palavras_texto2 <- 20

# Filtrando as 'numero_palavras_texto2' palavras mais frequentes
frequencia_df_filtrado_texto2 <- frequencia_df_texto2 %>%
  slice_head(n = numero_palavras_texto2)

# Criando o gráfico de frequência com as palavras mais comuns
ggplot(frequencia_df_filtrado_texto2, aes(x = reorder(word, freq), y = freq)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Frequência das Palavras Mais Comuns (Texto 2)", x = "Palavras", y = "Frequência") +
  coord_flip() +  # Rotaciona o eixo x para facilitar a leitura
  theme_minimal()  # Aplica um tema minimalista ao gráfico






