source("studyAreas/01_create_DEM.R")

#install_github("PredictiveEcology/climateData@development")

library("climateData")

climateDataDir <- normalizePath("~/data/climate/ClimateNA_data")

gcm <- "CanESM5" # "13GCMs_ensemble"

# Western Boreal ------------------------------------------------------------------------------

mdc_wb1 <- lapply(c(provs, "Yukon", paste(wb3, collapse = " & ")), function(x) {
  message("Processing historic MDC rasters for study area: ", x)
  dir1 <- file.path(climateDataDir, "historic_1991-2019", x)
  mdc1 <- makeMDC(inputPath = dir1, years = 1991:2019)
  writeRaster(mdc1, file.path("studyAreas/data", paste0("MDC_historic_1991-2019_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP2-4.5) MDC rasters for study area: ", x)
  dir2 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp245"), x)
  mdc2 <- makeMDC(inputPath = dir2, years = 2011:2100)
  writeRaster(mdc2, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp245_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP3-7.0) MDC rasters for study area: ", x)
  dir3 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp370"), x)
  mdc3 <- makeMDC(inputPath = dir3, years = 2011:2100)
  writeRaster(mdc2, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp370_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP5-8.5) MDC rasters for study area: ", x)
  dir4 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp585"), x)
  mdc4 <- makeMDC(inputPath = dir4, years = 2011:2100)
  writeRaster(mdc4, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp585_", x, ".grd")), overwrite = TRUE)
})

# Ontario -------------------------------------------------------------------------------------

mdc_wb1 <- lapply("Ontario", function(x) {
  message("Processing historic MDC rasters for study area: ", x)
  dir1 <- file.path(climateDataDir, "historic_1991-2019", x)
  mdc1 <- makeMDC(inputPath = dir1, years = 1991:2019)
  writeRaster(mdc1, file.path("studyAreas/data", paste0("MDC_historic_1991-2019_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP2-4.5) MDC rasters for study area: ", x)
  dir2 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp245"), x)
  mdc2 <- makeMDC(inputPath = dir2, years = 2011:2100)
  writeRaster(mdc2, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp245_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP3-7.0) MDC rasters for study area: ", x)
  dir3 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp370"), x)
  mdc3 <- makeMDC(inputPath = dir3, years = 2011:2100)
  writeRaster(mdc2, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp370_", x, ".grd")), overwrite = TRUE)

  message("Processing projected (SSP5-8.5) MDC rasters for study area: ", x)
  dir4 <- file.path(climateDataDir, "future_2011-2100", paste0(gcm, "_ssp585"), x)
  mdc4 <- makeMDC(inputPath = dir4, years = 2011:2100)
  writeRaster(mdc4, file.path("studyAreas/data", paste0("MDC_", gcm, "_ssp585_", x, ".grd")), overwrite = TRUE)
})
