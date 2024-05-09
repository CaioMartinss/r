imdb_cvs <-read_csv("imdb.csv")

spec(imdb_cvs)

imdb_cvs

imdb_cvs2 <-read_csv2("imdb.csv", sheet="")

imdb_xlsx <- read_excel("imdb.xlsx")

imdb_xlsx



#separando por virgula
readr::write_csv(mtcars, "mtcars.csv")

#separando por ponto e virgula
readr::write_csv2(mtcars, "mtcars2.csv")

readr::write_delim(mtcars, "mtcars3.txt", delim="\t")

writexl::write_xlsx(mtcars,"mtcars4.xlsx")

write_rds(mtcars, path = "mtcars5.rds")

write_rds(mtcars, path = "mtcars5.rds", compress = "gz")

read_rds("mtcars5.rds")

con <- RSQLite::dbConnect(
  RSQLite::SQLite(),
  dbname = "imdb.sqlite"
)



# Carregar o pacote RMySQL
library(RMySQL)

source("database_carometro.R")

# Conectar ao banco de dados MySQL
conexao <- dbConnect(MySQL(), 
                     user = user_carometro, 
                     password = password_carometro, 
                     dbname = dbname_carometro,
                     host = host_carometro )

# Exemplo de consulta
resultado <- dbGetQuery(conexao, "select * from alunos;")


# Exibir o resultado
print(resultado)

# Desconectar do banco de dados
dbDisconnect(conexao)
#-------------------------------------------------------------------------
source("database_imdb.R")
conexao <- dbConnect(MySQL(), 
                     user = user_imdb , 
                     password = password_imdb , 
                     dbname = dbname_imdb,
                     host = host_imdb)

# Exemplo de consulta
resultado_imdb <- dbGetQuery(conexao, "select * from filmes where id = 1");

# Exibir o resultado
print(resultado_imdb)

# Desconectar do banco de dados
dbDisconnect(conexao)


user_imdb = "root"
password_imdb = "root" 
dbname_imdb = "imdb"
host_imdb = "localhost"


# database_config.R
user_carometro <- "root"
password_carometro <- "root"
dbname_carometro <- "dbcarometro"
host_carometro <- "localhost"






