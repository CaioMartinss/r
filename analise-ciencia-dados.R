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

texto <- read_html(c("https://www.baguete.com.br/noticias/30/10/2020/ciencia-de-dados-continuara-sendo-a-grande-profissao-do-futuro")) 
texto1 <-  texto %>%
  html_nodes("p") %>%
  html_text() 


texto1 <- as.data.frame(texto1)
paged_table(texto1)

transforme_sobre_texto <- tolower(texto1)
transforme_sobre_texto <- removePunctuation(transforme_sobre_texto) 
transforme_sobre_texto <- removeNumbers(transforme_sobre_texto) 
transforme_sobre_texto <- stripWhitespace(transforme_sobre_texto)

#gerar a lista de todos os artigos definidos e indefinidos em português
stopwords_pt <- c(stopwords("pt"), 
                  "o", "a", "os", "as", "um", "uma", "uns", "umas", 
                  "é", "do", "da", "dos", "das", "de", "para", "com", 
                  "em", "por", "se", "que", "na", "no", "nas", "nos", 
                  "este", "esta", "estes", "estas", "esse", "essa", 
                  "esses", "essas", "isto", "isso", "aquele", "aquela", 
                  "aqueles", "aquelas", "isto", "isso", "aquilo", 
                  "mesmo", "mesma", "mesmos", "mesmas", "também", 
                  "ainda", "já", "ainda", "bem", "muito", "muita", 
                  "muitos", "muitas", "todo", "toda", "todos", 
                  "todas", "outro", "outra", "outros", "outras", 
                  "qual", "quais", "seu", "sua", "seus", "suas", 
                  "nosso", "nossa", "nossos", "nossas", "dele", 
                  "dela", "deles", "delas", "esse", "essa", "esses", 
                  "essas", "isso", "isto", "aquilo", "aqui", "aí", 
                  "ali", "lá", "como", "quem", "cujo", "cuja", 
                  "cujos", "cujas", "quanto", "quanta", "quantos", 
                  "quantas", "onde", "quando", "porque", "porquê", 
                  "porquê", "portanto", "assim", "logo", "mais", 
                  "menos", "tão", "tanto", "tanta", "tantos", 
                  "tantas", "entre", "através", "através", 
                  "sobre", "sob", "debaixo", "diante", "atrás", 
                  "frente", "fora", "dentro", "fora", "dentro")


transforme_sobre_texto  <- removeWords(transforme_sobre_texto , stopwords_pt)
#
print(transforme_sobre_texto)
#mostrar as palavras excluídas
print(stopwords_pt)

wordcloud(transforme_sobre_texto, scale = c(6, 0.5), max.words = 4, color = wes_palette("Royal1"))

#------------------------------------------------------------
texto <- read_html(c("https://www.baguete.com.br/noticias/30/10/2020/ciencia-de-dados-continuara-sendo-a-grande-profissao-do-futuro")) 
texto_corpus <-  texto %>%
  html_nodes("p") %>%
  html_text() 

corpus_texto <-VCorpus(VectorSource(texto_corpus))

corpus_texto <- tm_map(corpus_texto, removePunctuation)
corpus_texto <- tm_map(corpus_texto, removeNumbers)
corpus_texto <- tm_map(corpus_texto, removeWords, stopwords("pt"))


dtm_texto <- DocumentTermMatrix(corpus_texto)
dtm_texto 




#------------------------------------------------------------
texto <- read_html(c("https://www.baguete.com.br/noticias/30/10/2020/ciencia-de-dados-continuara-sendo-a-grande-profissao-do-futuro")) 
texto_tidy <-  texto %>%
  html_nodes("p") %>%
  html_text()

texto_df <- data_frame(text = texto_tidy)


texto_token <- texto_df %>%
  unnest_tokens(word, text)

stopwords_portu <- c(stopwords("pt"), "mas","o","é", "ser", "nesse")
stopwords_portu_df <- data.frame(word = stopwords_portu)

texto_token <- texto_token %>%
  anti_join(stopwords_portu_df, by = "word")

texto_token %>%
  count(word, sort = TRUE)


texto_token %>%
  count(word, sort = TRUE) %>%
  filter(n > 3) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col(fill = "#245968") +
  xlab(NULL) +
  coord_flip() +
  labs(
    y = "Frequência Termos"
  )


texto_ngrams <- texto_df %>%
unnest_tokens(ngram, text, token = "ngrams", n = 3)

texto_ngrams %>%
  count(ngram, sort = TRUE)



ngrams_new <- texto_ngrams %>%
  separate(ngram, c("P1", "P2", "P3"), sep = " ")


ngrams_new<- ngrams_new%>%
  filter(!P1 %in% stopwords_portu ) %>%
  filter(!P2 %in% stopwords_portu ) %>%
  filter(!P3 %in% stopwords_portu )

freq_ngram <- ngrams_new %>% 
  count(P1,P2,P3,sort = TRUE)
freq_ngram <- na.omit(freq_ngram)

paged_table(freq_ngram)