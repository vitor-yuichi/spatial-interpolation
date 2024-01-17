# declarando as biblitoecas necessárias
library(spm) #biblioteca de datasets 
library(gstat) #biblioteca de geoestatística
library(sp) # manipulação de dados espaciais
library(raster) # manipulação de dados raster
library(rgdal) # manipulação de dados espaciais 
library(ggplot2) #biblioteca de plots 
library(dplyr) #bibliotecas que realizam operações em objetos data frame 
library(sf) #é como se fosse o pandas do python no R data.frame
library(terra)
library("mapview") #visualizar mapas 
library(stars) #transformar dataframe em grids
library(tidyr)

mapviewOptions(fgb  = TRUE)


# determinando o caminho do arquivo e lendo
file_path <- "C:/Users/vitor.yuichi/Desktop/Pasta Vitor/Univ/modeloEstocasticoDeterministico/RawFile/baseFile.csv"
raw_file <- read.csv(file_path, dec = ",")

#somando colunas 
raw_file$pluvio_trimester <- raw_file$pluvio_jan + raw_file$pluvio_fev + raw_file$pluvio_mar



#Retirando pluviômetros 157, 528, 1000817, 1000938 (Não estão na Bacia de Tamanduateí)
raw_file = raw_file[!(raw_file$prefixo == 157 | 
                        raw_file$prefixo == 528 | 
                        raw_file$prefixo == 1000817 |  
                        raw_file$prefixo == 1000938), ]


#Separando os pluviômetros de teste: 629, 1000550, 1000490, 1000380

testfile = raw_file[(raw_file$prefixo == 629 | raw_file$prefixo == 1000550 | raw_file$prefixo == 1000490 
                     | raw_file$prefixo == 1000380),]

trainingfile = raw_file[!(raw_file$prefixo == 629 | raw_file$prefixo == 1000550 | raw_file$prefixo == 1000490 
                          | raw_file$prefixo == 1000380),]

#convertendo de data.frame para spatial dataframe (teste/treinamento) 




# convertendo para sf nas variáveis novas 
trainingfile_as_sf = st_as_sf(trainingfile, coords = c("xcoord", "ycoord"), crs = 4326)
testfile_as_sf = st_as_sf(testfile, coords = c("xcoord", "ycoord"), crs = 4326)
wholebase <- st_as_sf(raw_file, coords = c("xcoord", "ycoord"), crs = 4326)




# misturando as bases
# Set the number of samples and rows per sample
num_samples <- 30
rows_per_sample <- 13

# Initialize an empty list to store the samples
sample_list <- list()

# Loop to generate and append samples
for (i in 1:num_samples) {
  # Sample 13 rows without replacement
  sample_rows <- sample(1:nrow(trainingfile_as_sf), rows_per_sample, replace = FALSE)
  
  # Extract the sample from the dataframe
  sample_df <- trainingfile_as_sf[sample_rows, ]
  
  # Append the sample to the list
  sample_list[[i]] <- sample_df
}



mapview(trainingfile_as_sf['pluvio_trimester'])


# vamos usar como fonte de teórica a página: https://pages.cms.hu-berlin.de/EOL/gcg_quantitative-methods/Lab14_Kriging.html#Data

#vamo coleta da base total wholebase os limites para definirmos um grid

bbox <- st_bbox(wholebase)

bbox

# valor criar um espaço regular definindo o tamanho da célula

cell_size <- 0.001

x <- seq(bbox$xmin, bbox$xmax, by=cell_size)
y <- seq(bbox$ymin, bbox$ymax, by=cell_size)

# vamos criar então uma grande regular 
grid_pluvio <- expand.grid(x=x, y=y)
plot(grid_pluvio$x, grid_pluvio$y, pch=19, cex=0.1)

# convertendo o grid de dataframe para star com st_as_stars()
grid_pluvio$tmp <- 1
grid_pluvio <- st_as_stars(grid_pluvio, crs = st_crs(trainingfile_as_sf))
st_crs(grid_pluvio) <- st_crs(trainingfile_as_sf)
grid_pluvio


#idw interpolation 
# gerando o interpolardor
pluvio.idw <- gstat::idw(pluvio_trimester ~ 1, locations= wholebase, newdata = grid_pluvio, idp = 2)


#plotando a interpolação
plot(rast(pluvio.idw['var1.pred']))
#(wholebase['pluvio_trimester'], col=1, cex=0.5, add=T, type = "p")
plot(testfile_as_sf$geometry, add = T, type ='p', col = 'red')
  



#este trecho itera sobre todas as linhas uma a uma interpolando cada uma dos sf frames sobre o grid gerado
# a finalidade deste código é extrair o valor de cada raster gerado pela interpolação nos pontos fixos de teste 


# criando lista de lista dos dataframes 
list_of_testframes <-  list()

# Quantidade de idp_power geradas
idp_power <- list(0.5, 1, 2, 5, 10)
 
test_samples = list()
position <- 1 #definir posição da lista dentro da iterações
position_of_tests <-1 # posição da lista de listas
#extraindo valor do ponto   

testfile_as_sf1 <- testfile_as_sf


#este trecho itera sobre todas as linhas uma a uma interpolando cada uma dos sf frames sobre o grid gerado
# a finalidade deste código é extrair o valor de cada raster gerado pela interpolação nos pontos fixos de teste 

for (idp in idp_power){
  for (dataframe in sample_list){
    pluvio.idw <- gstat::idw(pluvio_trimester ~ 1, locations = dataframe, newdata = grid_pluvio, idp = idp)
    testfile_as_sf1 <- testfile_as_sf
    testfile_as_sf1$values_extracted <- terra::extract(rast(pluvio.idw['var1.pred']), testfile_as_sf)$var1.pred
    test_samples[[position]] <- select(testfile_as_sf1, prefixo, pluvio_trimester, values_extracted)
    position <- position + 1
  }
  list_of_testframes[[position_of_tests]] <- test_samples
  position_of_tests <- position_of_tests + 1
  position <- 1
  test_samples <- list()
}
  
#vamos criar uma lista de pivotações que posteriores servirão para concatenar todos os valores 
pivot_temp_list = list()
pivot_position <- 1

#vamos gerar uma lista com 5 dataframes e em cada um deles teremos o valor extraido com a tabela pivota com seus respectivo idp

final_dataframes <- list()
final_dataframe_position <- 1

# vamos iterar cada lista com seus respectivos dataframes e concatenar os valores de cada uma delas uma só única lista 

for (list in list_of_testframes){
  for (dataframe in list){
    pivot_temp_list[[pivot_position]] <-  st_drop_geometry(select(dataframe, prefixo, values_extracted)) %>% 
      pivot_wider(names_from = "prefixo", values_from = c("values_extracted"))
    pivot_position <- pivot_position  + 1
  }
  final_dataframes[[final_dataframe_position]] <- bind_rows(pivot_temp_list)
  pivot_position <- 1
  pivot_temp_list <- list()
  final_dataframe_position <- final_dataframe_position +1
}



#plots e cálculos de erro
testfile_as_sf

valor =3


# Create a grouped boxplot
boxplot(final_dataframes[[valor]]$"1000380", final_dataframes[[valor]]$"1000490",
        final_dataframes[[valor]]$"629", final_dataframes[[valor]]$'1000550',
        names = colnames(final_dataframes[[valor]]),  # Group names
        main = "Grouped Boxplot Example",
        xlab = "Groups",
        ylab = "Values",
        col = c("lightblue", "lightgreen"),  # Boxplot colors
        border = "black",
        ylim = c(100, 1200),
        main = paste("Boxplot", valor)
)

# Defina manualmente os limites de x e y

# Crie um vetor de posições no eixo x para os grupos
x <- 1:4

# Crie um vetor com os valores a serem plotados
y <- c(1100, 278,
       875, 357)

# Adicione pontos manualmente
points(x, y, pch = 19, col = "blue")



#RMSE
library(Metrics)
rmse1 = list()
rmse2 = list()
rmse3 = list()
rmse4 = list()

cols = colnames(final_dataframes[[1]])


for (i in 1:5) {
rmse1[[i]] <- rmse(final_dataframes[[i]]$'1000380', 1100)
rmse2[[i]] <- rmse(final_dataframes[[i]]$'1000490', 278)
rmse3[[i]] <- rmse(final_dataframes[[i]]$'629', 875)
rmse4[[i]] <- rmse(final_dataframes[[i]]$'1000550', 357)
}

rmse=data.frame(
 'P:1000380' = unlist(rmse1),
'P:1000490' = unlist(rmse2),
  'P:629' = unlist(rmse3),
  'P:1000550' = unlist(rmse4)
)

#Erro Quadrático Médio
rowMeans(rmse)
