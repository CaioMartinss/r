print("hello word")

nome <- "caio"
sobrenome <- "martins"
idade <- 23

nomeCompleto <- paste("o meu nome é", nome,sobrenome, " e tenho ", idade)

print(nomeCompleto)


# Criar uma lista de números
numeros <- c(10, 15, 20, 25, 30)
numeros [c(0 + 1 - 1 + 1,2)]


numeros2 <- c(20,20,45,34,25)
somaTotal <- numeros + numeros2

# Calcular a média dos números
media <- mean(numeros)
media2 <- mean(numeros2)

mediaTotal <- media + media2
print(mediaTotal)

if(mediaTotal < 20){
  print("============")
  print("PIKA DE Cachorro!!!")
  print("============")
}else{
  print("=============")
  print("não é pika de cachorro")
  print("=============")
}

estudante <- "jose"
tipo <- class(estudante)
if(tipo == "character"){
  print("é um objeto do tipo character")
}

a <- 1
class(a)


mtcars
class(mtcars)


vetor_coercao <- c(1,1,"b","b", 10)
vetor_coercao
class(vetor)

vetor3 <- c(1,2,2)
vetor3 + 1


vetor4 <- c(1, 2, 3)
vetor5 <- c(10, 20, 30, 40, 50)
vetor4 + vetor5

TRUE <- 1
class(TRUE)

1 == 1
"1" == 1

1 != 1

4   %in% c(1, 2, 3)

3   %in% c(1, 2, 3)


5 -
  #5 % 2
  5 ^ 2
5 / 2

#acessando mtcara
mtcars

#@acessando a coluna(pelo nome)
21 %in% mtcars$mpg

8 %in% mtcars$mpg

#acessando a coluna cyl do dataframe mtcars
mtcars$cyl[mtcars$cyl < 8]
class(mtcars$cyl)

#mostrar as dimensôes do data.frame
dim(mtcars)

#primeiro a linha depois a coluna
mtcars[1, 1]
mtcars[,,]

mtcars

mtcars[, c(1, 2)]

mtcars[, c("disp", "hp")]

mtcars$cyl == 4

mtcars[mtcars$cyl == 4, ]

mtcars[mtcars$mpg > 25, ]


minha_soma <- function(x, y) {
  soma <- x + y
  soma 
}

minha_soma(2,10)

par <- function(x){
  
}

minha_soma(2,2)

sum(c(1, 3) + 3)

sum(c(1, 3), 3)

mean(1,6)

mean(c(1,3))

#de/para/de 2 em 2
seq(from = 4, to = 10, by = 2)

seq(de = 4, para = 10, por = 2)

seq(4, 10, 2)

help(seq)

head(mtcars) 
tail(mtcars) 
dim(mtcars) 
names(mtcars) 
str(mtcars) 

resultado <- minha_soma(3, 3)

resultado



# Criar um data frame simples
tabela <- data.frame(
  Nome = c("João", "Maria", "Pedro", "Ana"),
  Idade = c(25, 30, 28, 22),
  Nota = c(8.5, 7.0, 9.0, 6.5)
)

tabela2 <- data.frame(
  Nome = c("ismael", "José", "Thiago", "Ana"),
  Idade = c(25, 30, 28, 22),
  Nota = c(8.5, 7.0, 9.0, 6.5)
)


cbind(tabela, tabela2) 
rbind(tabela, tabela2)

ls()

minha_nova_soma <- function(x, y) {
  soma <- x + y
}

resultado2 <-minha_nova_soma(1, 1)

resultado2




libray(tidyverse)
