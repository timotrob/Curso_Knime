
library(PMCMR)
df <- read.csv2("C:\\Users\\user\\Downloads\\BestFitnessAckley.csv",sep=";")
res <- runFriedmanNemenyiTest(as.matrix(df))


runFriedmanNemenyiTest<-function(resultMatrix){
  # Excuta Friedman test e posthoc.friedman.nemenyi.test
  #Args:
  #resultMatrix : Matriz com resultado de classificador por coluna
  #Retorna:
  #List com friedmanTest e friedman.nemenyi
  cat("Carregando os pacotes...\n")
  #Carregando o pacote caret (treino e validação)
  if(!require(PMCMR))
  {
    #Caso o usuário não tenha o pacote instala a partir do CRAN
    print("O programa precisa do package PMCMR. Instalando o package PMCMR...")
    install.packages("PMCMR")
    library(PMCMR)
  }

  resp<-list()
  resp$friedmanTest<-friedman.test(resultMatrix)
  resp$friedman.nemenyi<-posthoc.friedman.nemenyi.test(resultMatrix)
  return(resp)
}
