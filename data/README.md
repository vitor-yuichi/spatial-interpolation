
# Spatial Interpolation documentation 

## Escopo Geral
O objetivo primário deste trabalho é comparar as várias combinações de pluviômetros dentro da Bacia de Tamanduateí, dividindo-se em 1/3 dos pluviômetros para teste e 2/3 para treinamento. 

* O primeiro algoritmo testado é o IDW (Inverse Distance Weigh); 
* Após a geração da superfície interpolada foi comparado o valor o do pluviômetro teste com o valor interpolado na célula onde está o pluviômetro;
#### Parâmetro geral:
* Datas estão no formato iso 8601;
### Teste IDW (Executado em 2023-07-21)
#### Informações e parâmetros estabelecidos:
* Tamanho do pixel: 0.001;
* Potência (parâmetro IDW, padrão no ArcGIS): 2;
* Tamanho da grade: 1km x 1km;
* Foram geradas 30 combinações distintas (60 tabelas), 30 para teste e 30 para treinamento [PointsShuffle.md](https://github.com/vitor-yuichi/spatial-interpolation/blob/main/data/PointsShuffle.md); 
* Geração dos Rasters do algoritmo IDW, pontos vetoriais de uma tabela csv e extrair valor do raster [CsvAsVector_RasterGeneration_ExtractPointVal.md](https://github.com/vitor-yuichi/spatial-interpolation/blob/main/data/CsvAsVector_RasterGeneration_ExtractPointVal.md) 
* Análise dos resultados [DataAnalysisIDWResults.md](https://github.com/vitor-yuichi/spatial-interpolation/blob/main/data/DataAnalysisIDWResults.md);
#### IDW resultados:
* Processo realizado: importação dos dados - >Valor absoluta da diferença entre o valor do Pluviômetro e o e o ponto extraído do Raster, dividido pelo valor inicial do pluviômetro -> Cálculo do Desvio Relativo médio (Média de todos as tabelas testes) -> Geração de Histograma (bins=15)
* ![Plot](https://github.com/vitor-yuichi/spatial-interpolation/blob/main/data/Sample.png)
* Média dos desvios: 0.23
* A maior quantidade de amostras está entre na faixa de 0.13 a 0.15 de desvio relativo;
* O maior desvio relativo é de 43% (3 amostras); 


