#Arbol filogenético
install.packages("pacman")
#Usar pacman para instalar (si no están instalados) y cargar todos los paquetes necesarios
pacman::p_load(
  ape,        # Análisis filogenéticos
  tidyverse,  # Manipulación de datos (dplyr, ggplot2, etc.)
  phangorn,   # Modelos evolutivos avanzados
)

#Instalar ggtree y Biostrings
BiocManager::install(c("ggtree", "Biostrings"))

#Paso 1: Cargar paquetes con pacman
pacman::p_load(ape, ggtree, tidyverse, phangorn)

# Leer el archivo FASTA (asegúrate de que está en tu directorio de trabajo)
aln <- read.FASTA("clustalw.fasta", type = "AA")  

# Leer metadatos desde CSV (ajusta el nombre de columnas si es necesario)
meta <- read_csv("metadatos.csv")  # Asegúrate de que el archivo existe
