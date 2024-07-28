library(openxlsx)
library(stats)

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

# Realizar la prueba de Kolmogorov Smirnov
result_ks_juigalpa_chirps <- ks.test(df_juigalpa_chirps_values, "pnorm", mean=mean(df_juigalpa_chirps_values), sd=sd(df_juigalpa_chirps_values))
result_ks_juigalpa_ineter <- ks.test(df_juigalpa_ineter_values, "pnorm", mean=mean(df_juigalpa_ineter_values), sd=sd(df_juigalpa_ineter_values))
result_ks_juigalpa_trmm <- ks.test(df_juigalpa_trmm_values, "pnorm", mean=mean(df_juigalpa_trmm_values), sd=sd(df_juigalpa_trmm_values))
result_ks_managua_chirps <- ks.test(df_managua_chirps_values, "pnorm", mean=mean(df_managua_chirps_values), sd=sd(df_managua_chirps_values))
result_ks_managua_ineter <- ks.test(df_managua_ineter_values, "pnorm", mean=mean(df_managua_ineter_values), sd=sd(df_managua_ineter_values))
result_ks_managua_trmm <- ks.test(df_managua_trmm_values, "pnorm", mean=mean(df_managua_trmm_values), sd=sd(df_managua_trmm_values))


# Combinar todos los data frames en uno solo
combined_df <- rbind(
  result_ks_juigalpa_chirps,
  result_ks_juigalpa_ineter,
  result_ks_juigalpa_trmm,
  result_ks_managua_chirps,
  result_ks_managua_ineter,
  result_ks_managua_trmm
)

# Crear un nuevo workbook
wb <- createWorkbook()

# Añadir una hoja y escribir los datos
addWorksheet(wb, "Resultados_Kolmogorov_Smirnov")
writeData(wb, sheet = "Resultados_Kolmogorov_Smirnov", x = combined_df)

# Guardar el workbook en un archivo
saveWorkbook(wb, "R_Kolmogorov_Smirnov_Daily.xlsx", overwrite = TRUE)
