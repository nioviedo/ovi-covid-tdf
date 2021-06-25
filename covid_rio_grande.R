#-----Mise en place-----
#Limpiamos el entorno, fijamos el directorio de trabajo 

rm(list=ls())
gc()
dataDir <- "C:/Users/Ovi/Desktop/covid_tdf"
setwd(dataDir)

#----Biblioteca----
library(readxl)
library(xlsx)
library(haven)
library(stargazer)
library(Formula)
library(dplyr)

#1. Limpiamos la base----
ayer = Sys.Date()-1
ayer <- format(ayer, format="%Y%m%d")
myfiles <- list.files(dataDir, pattern = "*.csv", full.names = FALSE)
file.rename(myfiles[length(myfiles)], paste0(ayer, "_RioGrande",".csv" ))
#new_files <- paste0(ayer,myfiles[length(myfiles)],_RioGrande,".csv")

Casos <- read.csv("20210527_RioGrande.csv", skip = 3)
Casos <- data.frame(Casos, index = "fecha")
N = nrow(Casos)
A = N-27

#2. Ratio de contagios----
Casos <- Casos %>% slice(A:N)
casos_14 <-sum(Casos$casos_dx[15:28])
casos_28 <-sum(Casos$casos_dx[1:14])
casos_idx = casos_14/casos_28

#3. Incidencia----
incidencia = casos_14/95881

if (casos_idx < 0.8 & incidencia < 50) {
  print("Zona de riesgo BAJO")
}
if(casos_idx < 1.2 & 0.8 <= casos_idx & incidencia < 150){
  print("Zona de riesgo MEDIO")
}
if(casos_idx > 1.2  | incidencia > 250){
  print("Zona de riesgo ALTO")
}


