#Instalación de paquetes
install.packages(c("ape", "tidyverse", "phangorn"))
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ggtree")  # Para visualización avanzada
#Cargar paquetes
library(ape)
library(tidyverse)
library(ggtree)
library (phangorn)

#1.Leer secuencias alineadas
aln_aa <- read.FASTA("clustalw.fasta", type = "AA")  
#Verificar el tipo de datos
print(class(aln_aa))  # Debe mostrar "AAbin"
#Leer metadatos (si los tienes)
meta <- read_csv("metadatos.csv")  # Asegúrate de que hay columna 'ID'

#Corregir la estructura de los metadatos
meta_correcta <- meta %>%
  separate(col = `ID,País,Subtipo,Notas`,  # Nombre de la columna actual (con acentos y comas)
           into = c("ID", "País", "Subtipo", "Notas"),  # Nuevos nombres de columnas
           sep = ",",  # Separador
           fill = "right")  # Rellenar NAs si hay valores faltantes
#Verificar el resultado
head(meta_correcta)

#2.Convertir a formato phyDat versión robusta
aln_phyDat <- phangorn::phyDat(as.character(aln_aa), 
                               type = "AA", 
                               levels = AA_STANDARD)  # Usa los 20 aminoácidos estándar

#3.Calcular matriz de distancias
matriz_dist <- dist.ml(aln_phyDat, model = "WAG")

#5.Construir árbol
arbol_nj <- nj(matriz_dist)
plot(arbol_nj, main = "Árbol de Proteína Vif")
plot(arbol_nj, type = "unrooted", main = "Árbol de Vif (NJ)")

#Visualizar el arbol con los metadatos completos
ggtree(arbol_nj) %<+% meta_correcta +
  geom_tiplab(aes(color=País), size=3) + 
  scale_color_manual(values=c("México"="#E41A1C","Colombia"="#377EB8","Brasil"="#4DAF4A","Nigeria"="#984EA3","Sudáfrica"="#FF7F00")) +
  theme_tree2() +
  xlim(0, 0.3)