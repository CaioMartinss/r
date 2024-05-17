library(ggplot2)
library(dplyr)


# Carregar dicionário léxico
load_lexicon <- function(file.path) {
  lexicon <- scan(file.path, what = "character", comment.char = ";")
  return(lexicon)
}

# Carregar dicionários léxicos
positive_words <- load_lexicon("positive_words_pt.txt")
negative_words <- load_lexicon("negative_words_pt.txt")

# Função para remover acentos
remove_accents <- function(text) {
  text <- iconv(text, to = "ASCII//TRANSLIT")
  return(text)
}

# Função para realizar limpeza no texto
clean_text <- function(text) {
  text <- tolower(text)
  text <- remove_accents(text)
  text <- removePunctuation(text)
  text <- removeNumbers(text)
  text <- removeWords(text, c(stopwords("pt"),
                              "o", "a", "os", "as", "um", "uma", "uns", "umas",
                              "de", "do", "da", "dos", "das", "em", "no", "na", "nos", "nas",
                              "por", "pelo", "pela", "pelos", "pelas",
                              "com", "sem", "entre", "para", "por", "sobre",
                              "que", "quem", "onde", "qual", "quais", "quando", "como", "porque",
                              "e", "mas", "ou", "se", "pois", "entao",
                              "este", "esta", "estes", "estas", "esse", "essa", "esses", "essas",
                              "aquele", "aquela", "aqueles", "aquelas",
                              "meu", "minha", "meus", "minhas", "teu", "tua", "teus", "tuas",
                              "seu", "sua", "seus", "suas", "dele", "dela", "deles", "delas",
                              "eu", "tu", "ele", "ela", "nos", "vos", "eles", "elas",
                              "me", "te", "se", "lhe", "nos", "vos", "lhes",
                              "isso", "isto", "aquilo", "aqui", "ali", "la", "ate"))
  text <- stripWhitespace(text)
  return(text)
}


texto <- readLines("texto1.txt")


texto_limpo <- clean_text(texto)

#função para calcular o sentimento do texto
calculate_sentiment <- function(text, positive_words, negative_words) {
 positive_count <- sum(text %in% positive_words)
 negative_count <- sum(text %in% negative_words)
 sentiment_score <- positive_count - negative_count
 
 if (sentiment_score > 0) {
   sentiment <- "Positivo"
 } else if (sentiment_score < 0) {
   sentiment <- "Negativo"
 } else {
   sentiment <- "Neutro"
 }
 
 return(list(sentimento_score = sentiment_score, sentiment = sentiment))
 
}


#calculando sentimento do texto limpo
sentiment_info <- calculate_sentiment(strsplit(texto_limpo, " ")[[1]], positive_words, negative_words)

#tokenização do texto limpo
corpus <- Corpus(VectorSource(texto_limpo))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("pt"))
corpus <- tm_map(corpus, stripWhitespace)

words <- unlist(strsplit(as.character(corpus), " "))


#frequencia das palavras
word_freq <- table(words)
word_freq <- sort(word_freq, decreasing = TRUE)


#criar um data frame
tokens_df <- data.frame(word = names(word_freq), freq = as.numeric(word_freq))

#grafico de frequencia das palavras
freq_plot <-ggplot(tokens_df,aes(x = word)) +
  geom_bar()+
  labs(title = "Frequência das palavras",
       x = "Palavras",
       y = "Frequência")+
  
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))

#calculando evolução dos sentimento ao longo do texto
sentiment_evolution <- data.frame(
  word_count = seq_along(words),
  positive_count = cumsum(words %in% positive_words),
  negative_count = cumsum(words %in% negative_words)
  
  
)


#grafico de evolução do sentimento
ggplot(sentiment_evolution, aes(x = word_count))+
  geom_line(aes(y = positive_count, color = "Positivo"))+
  geom_line(aes(y = negative_count, color = "Negativo"))+
  labs(title = "Evolução do sentimento",
       x = "posição no texto",
       y = "Contagem de palavras positivas e negativas")+
  scale_color_manual(values = c("Positivo" = "blue", "Negativo" = "red"))+
  theme_minimal()




#nuvem de palavras
wordcloud(words, min.freq = 2, random.order = FALSE, colors = brewer.pal(8, "Dark2"))


#imprimindo o resultado
cat("o texto é classificado como:", sentiment_info$sentiment, "com um score de:", sentiment_info$sentimento_score)




#grafico de barras

ggplot(tokens_df[1:10,], aes(x = reorder(word, freq), y = freq))+
  geom_bar(stat = "identity")+
  labs(title = "Frequência das palavras",
       x = "Palavras",
       y = "Frequência")+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))


#grafico de sentimentos em barras
sentiment_df <- data.frame(
  sentiment = c("Positivo", "Negativo", "Neutro"),
  count = c(sum(words %in% positive_words), sum(words %in% negative_words), length(words) - sum(words %in% positive_words) - sum(words %in% negative_words)
))




# Exemplo de data frame
sentiment_df <- data.frame(
  sentiment = c("positivo", "negativo", "neutro"),
  count = c(10, 5, 7),
  category = c("positivo", "negativo", "neutro")  # Categorias de sentimento
)

# Plot com cores baseadas em categorias
ggplot(sentiment_df, aes(x = sentiment, y = count, fill = category)) +
  geom_bar(stat = "identity") +
  labs(title = "Sentimento do texto",
       x = "Sentimento",
       y = "Contagem") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")  # Usando uma paleta de cores do RColorBrewer
















# Função para contar palavras positivas e negativas
count_words <- function(text, lexicon) {
  words <- unlist(strsplit(text, " "))
  words <- words[words != ""]
  count <- sum(words %in% lexicon)
  return(count)
}

# Função para calcular sentimento
sentiment <- function(text) {
  text <- clean_text(text)
  positive <- count_words(text, positive_words)
  negative <- count_words(text, negative_words)
  score <- (positive - negative) / (positive + negative)
  return(score)
}
