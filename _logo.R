# Install required packages
required_packages <- c("hexSticker", "magick", "tidyverse", "ggplot2", "lares")

rutils.install_require_packages <- function(packages) {
  new.packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(new.packages))
    install.packages(new.packages, dependencies = TRUE)
  sapply(packages, require, character.only = TRUE)
}

rutils.install_require_packages(required_packages)


# Load required packages
library(dplyr)
library(ggplot2)
library(hexSticker)
library(magick)

# Load fonts
sysfonts::font_add_google("Zilla Slab", "pf", regular.wt = 500)

# Read logo image
logo_img <- magick::image_read("assets/images/logo.png") %>%
  #image_convert("png") %>%
  image_resize("1080 x 200") %>%
  image_fill(color = "#FFF9F2", point = "+45") # %>% image_annotate("SOA Predictive Analytics", size=16, location="+10+175", color="black")

# Create `hex-sticker`
hex_sticker <- hexSticker::sticker(
  subplot = logo_img,
  s_x = 1,
  s_y = 1.2,
  s_width = 1.1,
  s_height = 14,
  package = "SOA Predictive Analytics",
  p_x = 1,
  p_y = 0.7,
  p_size = 10,
  p_family = "pf",
  filename = "assets/images/logo-soa-predictive-analytics.png",
  h_size = 1.2,
  h_fill = "#FFF9F2",
  h_color = "#3F8CCC",
  p_color = "#000000",
  dpi = 320
)

# Display sticker and save `hexsticker` logo.
plot(hex_sticker)
ggplot2::ggsave(
  hex_sticker,
  filename = "assets/images/logo-soa-predictive-analytics.png",
  width = 2,
  height = 2,
  dpi = 300
)
