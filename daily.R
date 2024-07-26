library(openxlsx)

# Cargar los datos
df_juigalpa_chirps <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Juigalpa CHIRPS (2002-2019).xlsx"))
df_juigalpa_ineter <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Juigalpa INETER (2002-2019).xlsx"))
df_juigalpa_trmm <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Juigalpa TRMM (2002-2019).xlsx"))
df_managua_chirps <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Managua CHIRPS (2002-2019).xlsx"))
df_managua_ineter <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Managua INETER (2002-2019).xlsx"))
df_managua_trmm <- read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationDaily/Precipitación Diaria _ Managua TRMM (2002-2019).xlsx"))

column_name_values <- "PREC.DIARIA"

# Obtener los valores de precipitación diaria
df_juigalpa_chirps_values <- df_juigalpa_chirps[[column_name_values]]
df_juigalpa_ineter_values <- df_juigalpa_ineter[[column_name_values]]
df_juigalpa_trmm_values <- df_juigalpa_trmm[[column_name_values]]
df_managua_chirps_values <- df_managua_chirps[[column_name_values]]
df_managua_ineter_values <- df_managua_ineter[[column_name_values]]
df_managua_trmm_values <- df_managua_trmm[[column_name_values]]


























# Combinar todos los data frames en uno solo
combined_df <- rbind(
  df_juigalpa_chirps,
  df_juigalpa_ineter,
  df_juigalpa_trmm,
  df_managua_chirps,
  df_managua_ineter,
  df_managua_trmm
)

# Crear un nuevo workbook
wb <- createWorkbook()

# Añadir una hoja y escribir los datos
addWorksheet(wb, "Resultados_Mann_Kendall")
writeData(wb, sheet = "Resultados_Mann_Kendall", x = combined_df)

# Guardar el workbook en un archivo
saveWorkbook(wb, "R_mann_kendall_daily.xlsx", overwrite = TRUE)
