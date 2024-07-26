library(openxlsx)
library(trend)


# Cargar los datos
df_juigalpa_chirps = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Juigalpa CHIRPS (2002-2019).xlsx"))
df_juigalpa_ineter = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Juigalpa INETER (2002-2019).xlsx")) 
df_juigalpa_trmm = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Juigalpa TRMM (2002-2019).xlsx"))
df_managua_chirps = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Managua CHIRPS (2002-2019).xlsx"))
df_managua_ineter = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Managua INETER (2002-2019).xlsx"))
df_managua_trmm = read.xlsx(sprintf("%s%s",getwd(), "/data/precipitationAnual/Precipitación Anual _ Managua TRMM (2002-2019).xlsx"))

column_name_values <- "PREC.ANUAL"

# Obtener los valores de precipitación diaria
df_juigalpa_chirps_values <- df_juigalpa_chirps[[column_name_values]]
df_juigalpa_ineter_values <- df_juigalpa_ineter[[column_name_values]]
df_juigalpa_trmm_values <- df_juigalpa_trmm[[column_name_values]]
df_managua_chirps_values <- df_managua_chirps[[column_name_values]]
df_managua_ineter_values <- df_managua_ineter[[column_name_values]]
df_managua_trmm_values <- df_managua_trmm[[column_name_values]]

# Realizar la prueba de Mann-Kendall
result_chisq_juigalpa_chirps <- chisq.test(df_juigalpa_chirps_values)
result_chisq_juigalpa_ineter <- chisq.test(df_juigalpa_ineter_values)
result_chisq_juigalpa_trmm <- chisq.test(df_juigalpa_trmm_values)
result_chisq_managua_chirps <- chisq.test(df_managua_chirps_values)
result_chisq_managua_ineter <- chisq.test(df_managua_ineter_values)
result_chisq_managua_trmm <- chisq.test(df_managua_trmm_values)


# Función para convertir objeto htest a data frame con nombre
htest_to_df <- function(htest_obj, name) {
  data.frame(
    name = htest_obj$data.name,
    Xsquared = htest_obj$statistic,
    p.value = htest_obj$p.value
  )
}

# Convertir los resultados a data frames
df_juigalpa_chirps <- htest_to_df(result_chisq_juigalpa_chirps, "Juigalpa_CHIRPS")
df_juigalpa_ineter <- htest_to_df(result_chisq_juigalpa_ineter, "Juigalpa_INETER")
df_juigalpa_trmm <- htest_to_df(result_chisq_juigalpa_trmm, "Juigalpa_TRMM")
df_managua_chirps <- htest_to_df(result_chisq_managua_chirps, "Managua_CHIRPS")
df_managua_ineter <- htest_to_df(result_chisq_managua_ineter, "Managua_INETER")
df_managua_trmm <- htest_to_df(result_chisq_managua_trmm, "Managua_TRMM")

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
addWorksheet(wb, "Resultados_Chi_Square")
writeData(wb, sheet = "Resultados_Chi_Square", x = combined_df)

# Guardar el workbook en un archivo
saveWorkbook(wb, "R_chi_square_Anual.xlsx", overwrite = TRUE)
