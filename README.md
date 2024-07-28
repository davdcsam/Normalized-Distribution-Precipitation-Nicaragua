# Análisis de Precipitación en Juigalpa y Managua (2002-2019)

Este proyecto analiza los datos de precipitación anual, mensual y diaria en Juigalpa y Managua utilizando varios métodos estadísticos. El análisis se realiza utilizando Jupyter Notebooks en Python y scripts de R.

## Requisitos

### Python

- pandas
- openpyxl

### R

- openxlsx
- trend
- stats

## Análisis

### Anual (Chi-Square Test)

En los scripts de R, se realiza la prueba de Chi-Cuadrado para los datos de precipitación anual de Juigalpa y Managua.

```r
library(openxlsx)
library(trend)

# Cargar los datos
df_juigalpa_chirps = read.xlsx(sprintf("%s%s", getwd(), "/data/precipitationAnual/Precipitación Anual _ Juigalpa CHIRPS (2002-2019).xlsx"))

# Realizar la prueba de Chi-Cuadrado
result_chisq_juigalpa_chirps <- chisq.test(df_juigalpa_chirps$PREC.ANUAL)
print(result_chisq_juigalpa_chirps)
```

### Diario (Kolmogorov-Smirnov Test)

Tambien se realiza la prueba de Kolmogorov-Smirnov para los datos de precipitación diaria.

```r
library(openxlsx)
library(stats)

# Cargar los datos
df_juigalpa_chirps = read.xlsx(sprintf("%s%s", getwd(), "/data/precipitationDaily/Precipitación Diaria _ Juigalpa CHIRPS (2002-2019).xlsx"))

# Realizar la prueba de Kolmogorov-Smirnov
result_ks_juigalpa_chirps <- ks.test(df_juigalpa_chirps$PREC.DIARIA, "pnorm", mean=mean(df_juigalpa_chirps$PREC.DIARIA), sd=sd(df_juigalpa_chirps$PREC.DIARIA))
print(result_ks_juigalpa_chirps)
```

## Mensual (Mann-Kendall Test)

```r
library(openxlsx)
library(trend)

# Cargar los datos
df_juigalpa_chirps = read.xlsx(sprintf("%s%s", getwd(), "/data/precipitationMonthly/PRECIPITACION - Juigalpa CHIRPS (2002-2019).xlsx"))

# Realizar la prueba de Mann-Kendall
result_mk_juigalpa_chirps <- mk.test(df_juigalpa_chirps$Valor)
print(result_mk_juigalpa_chirps)
```
