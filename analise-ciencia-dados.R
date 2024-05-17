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



library(tidytext)
library(dplyr)


texto_df <- tibble(texto = texto)

texto_token <- texto_df %>%
  unnest_tokens(word, texto)

stopwords_portu <- c(stopwords("pt"), "mas", "o", "é", "ser", "nesse", "a",	"o",	"e",	"de",	"que",	"do",	"da",	"em",	"um",	"uma",	"para",	"com",	"é",	"se",	"não",	"por",	"mais",	"mas",	"como",	"ao",	"está",	"seu",	"sua",	"ou",	"quando",	"ser",	"nessa",
                     " a",	" o",	" e",	" de",	" que",	" do",	" da",	" em",	" um",	" uma",	" para",	" com",	" é",	" se",	" não",	" por",	" mais",	" mas",	" como",	" ao",	" está",	" seu",	" sua",	" ou",	" quando",	" ser",	" nesse",	" isso",	" aqui",	
                     "lá",	" então",	" também",	" ainda",	" apenas",	" mesmo",	" muito",	" bem",	" já",	" até",	" mesmo",	" apenas",	" tudo",	" todos",	" toda",	" todo",	" qualquer",	" cada",	" qualquer",	" cada",	" sem",	" uns",	" umas",	" outros",	" outras",	" outro",	" outra",	" entre",	" pela",	" pelo",	" pelas",	" pelos",	" assim",	" hoje",	" ontem",	" amanhã",	" depois",	" antes",	" durante",	" agora",	" então",	" sempre",	" nunca",	" mais",	" menos",	" talvez",	" inclusive",	" exclusivamente",	" igualmente",	" assim",	" além",	" frente",	" trás",	" cima",	" baixo",	" dentro",	" fora",	" longe",	" perto",	" próximo",	" distante",	" vez",	" vezes",	" parte",	" partes",	" certo",	" certa",	" certos",	" certas",	" coisas",	" coisa",
)
stopwords_portu_df <- data_frame(word = stopwords_portu)

texto_token <- texto_token %>%
  anti_join(stopwords_portu_df, by = "word")

texto_token %>%
  count(word, sort = TRUE)


texto_token %>%
  count(word, sort = TRUE) %>%
  filter(n > 100) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col(fill = "#245968") +
  xlab(NULL) +
  coord_flip() +
  labs(
    y = "Frequência Termos"
  )