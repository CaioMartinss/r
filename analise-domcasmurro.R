library(syuzhet)
library(RColorBrewer)
library(wordcloud)
library(tm)
library(wordcloud)

texto <- readLines("texto1.txt")

texto_palavras <- get_tokens(texto)
length(texto_palavras)
head(texto_palavras)


oracoes_vetor <- get_sentences(texto)
length(oracoes_vetor)
print(texto)


sentimentos_df <- get_nrc_sentiment(texto_palavras, language = "portuguese")
head(sentimentos_df)



summary(sentimentos_df)

barplot(
  colSums(prop.table(sentimentos_df[, 1:8])),
  space = 0.2,
  horiz = FALSE,
  las = 1,
  cex.names = 0.7,
  col = brewer.pal(n = 8, name = "Set3"),
  main = "'Dom Casmurro' de Machado de Assis",
  sub = "Análise realizada por Diana Rebelo Rodriguez",
  xlab="emoções", ylab = NULL)

barplot(colSums(prop.table(sentimentos_df[, 1:8])))


palavras_tristeza <- texto_palavras[sentimentos_df$sadness > 0]

# Exibir as palavras associadas a cada emoção
palavras_tristeza_ordem <- sort(table(unlist(palavras_tristeza)), decreasing = TRUE)
head(palavras_tristeza_ordem, n = 12)
head(palavras_tristeza_ordem, n = 12)


length(palavras_tristeza_ordem)


nuvem_emocoes_vetor <- c(
  paste(texto_palavras[sentimentos_df$sadness> 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$joy > 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$anger > 0], collapse = " "),
  paste(texto_palavras[sentimentos_df$fear > 0], collapse = " "))

nuvem_emocoes_vetor <- iconv(nuvem_emocoes_vetor, "latin1", "UTF-8")


nuvem_corpus <- Corpus(VectorSource(nuvem_emocoes_vetor))


nuvem_tdm <- TermDocumentMatrix(nuvem_corpus)
nuvem_tdm <- as.matrix(nuvem_tdm)
head(nuvem_tdm)


colnames(nuvem_tdm) <- c('tristeza', 'felicidade', 'raiva', 'confiança')
head(nuvem_tdm)

set.seed(600)
comparison.cloud(nuvem_tdm, random.order = FALSE,
                 colors = c("green", "red", "orange", "blue"),
                 title.size = 1, max.words = 50, scale = c(2.5, 1), rot.per = 0.4)


sentimentos_valencia <- (sentimentos_df$negative * -1) + sentimentos_df$positive

simple_plot(sentimentos_valencia)

write.csv(sentimentos_df, file = "analise_sent_domCasmurro.csv", row.names = texto_palavras)


#salvar em txt
write.table(sentimentos_df, "sentimentos_df.txt", sep = "\t", row.names = FALSE)

#salvar em csv
write.csv(sentimentos_df, "sentimentos_df.csv", row.names = FALSE)


#abrir o arquivo
read.table("sentimentos_df.txt", sep = "\t", header = TRUE)




















