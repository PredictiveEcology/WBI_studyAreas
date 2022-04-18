source("studyAreas/00_WB_BCR.R")

Require(c("ggplot2", "ggspatial", "sf"))

ab <- canProvs[canProvs$NAME_1 == "Alberta", ]
absk <- canProvs[canProvs$NAME_1 %in% c("Alberta", "Saskatchewan"), ]

cols <- c("darkgreen", "goldenrod") ## need MPB col twice b/c there are 2 MPB polygons

## MPB
mpb_sf <- ecoregions[ecoregions$REGION_ID %in% c(112, 122, 124, 126, 120), ] %>%
  aggregate(.) %>%
  st_as_sf(.) %>%
  st_intersection(., absk) %>%
  dplyr::mutate(., INSECT = as.factor("MPB"))

gg_mpb <- ggplot(st_as_sf(studyArea)) +
  geom_sf(fill = "white", colour = "black", alpha = 0.5) +
  geom_sf(data = mpb_sf, fill = cols[1], col = cols[1], alpha = 0.5) +
  theme_bw() +
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0.25, "in"), pad_y = unit(0.25, "in"),
                         style = north_arrow_fancy_orienteering) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("MPB study area")
ggsave("studyAreas/figures/mpb_studyArea.png", gg_mpb)

## SBW
sbw_sf <- postProcess(ecoregions[ecoregions$REGION_ID %in% c(72), ], studyArea = ab) %>%
  st_as_sf(.) %>%
  dplyr::mutate(., INSECT = as.factor("SBW"))

gg_sbw <- ggplot(st_as_sf(studyArea)) +
  geom_sf(fill = "white", colour = "black", alpha = 0.5) +
  geom_sf(data = sbw_sf, fill = cols[3], colour = cols[3], alpha = 0.5) +
  theme_bw() +
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0.25, "in"), pad_y = unit(0.25, "in"),
                         style = north_arrow_fancy_orienteering) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("SBW study area")
ggsave("studyAreas/figures/sbw_studyArea.png", gg_sbw)

## both
insects_sf <- rbind(mpb_sf[, "INSECT"], sbw_sf[, "INSECT"])
gg_insects <- ggplot(st_as_sf(studyArea)) +
  geom_sf(fill = "white", colour = "black", alpha = 0.5) +
  geom_sf(mapping = aes(col = INSECT, fill = INSECT), data = insects_sf, alpha = 0.5) +
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_bw() +
  annotation_north_arrow(location = "bl", which_north = "true",
                         pad_x = unit(0.25, "in"), pad_y = unit(0.25, "in"),
                         style = north_arrow_fancy_orienteering) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("WBI insect disturbance study areas")
ggsave("studyAreas/figures/insect_disturbance_studyArea.png", gg_insects)
