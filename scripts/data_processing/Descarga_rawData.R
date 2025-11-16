# Fijamos la carpeta en la que se van a descargar los datos
dir.create("data/raw_data", recursive = TRUE, showWarnings = FALSE)

# Ponemos las URLs de los archivos a descargar
urls <- c(
  "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE306900/GSE306907/suppl/GSE306907_gene_count_matrix.csv.gz",
  "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE306900/GSE306907/suppl/GSE306907_gene_count_2_matrix.csv.gz"
)

# Descarga y descompresión de cada uno de los dos archivos
for(url in urls){
  # Nombre base del archivo
  gz_file <- file.path("data/raw_data", basename(url))
  csv_file <- sub("\\.csv.gz$",".csv", gz_file)
  
  # Se borran los archivos antiguos si existen
  if(file.exists(csv_file)) file.remove(csv_file)
  
  # Descarga
  download.file(url, gz_file, mode = "wb")
  
  # Se lee el .gz y y se guarda como .csv descomprimido
  data_mat <- read.csv(gzfile(gz_file), header = TRUE, row.names = 1, check.names = FALSE)
  write.csv(data_mat, csv_file, row.names = TRUE)
  # Se borra el archivo .gz descargado
  file.remove(gz_file)
}