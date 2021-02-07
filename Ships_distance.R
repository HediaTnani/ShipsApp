library(tidyverse)
library (geodist)

# Let's start having a look at the raw data
ships_rawdata <- read.csv("~/Downloads/ships.csv")

# Let's select the data we're interested in and format the date and time

ships <- ships_rawdata %>% 
          select(SHIP_ID,SHIPNAME,LAT,LON,DATETIME, ship_type) %>% 
          mutate(DATETIME = str_replace(DATETIME,"Z","")) %>% 
         tidyr::separate(., DATETIME, c("DATE", "TIME"), sep = "T") 
  
# Let's see the ship types 

shipstype <- as.list(ships[!duplicated(ships$ship_type), 5])

# let's see the ship names
shipsname <- as.list(ships[!duplicated(ships$SHIPNAME), 2])

unlist(shipsname, use.names=FALSE)

# To calculte the distance we need 2 positions so we'll have to remove the ones with only one observation

ships <- ships %>% mutate(SHIP_ID =as.character(SHIP_ID)) %>%  group_by(SHIP_ID) %>%
  mutate(count = n()) %>%
  arrange(count) %>% 
  filter(count >= 2) %>%
  select(-count) %>% 
  ungroup()


# Let's start calculating the distance
# The geodist function from geodist package 
ships <- ships %>%
  group_by(SHIP_ID) %>% 
  mutate(distance = geodist_vec(LON,
                         LAT,
                         sequential = TRUE, # If TRUE, calculate (vector of) distances sequentially along x 
                         pad = TRUE, #If sequential = TRUE values are padded with initial NA to return n values for input with n rows
                         measure = "geodesic"), #"geodesic" denotes the very accurate geodesic methods given in Karney (2013)
# choices "haversine" "vincenty", "geodesic", or "cheap" specifying desired method of geodesic distance calculation
max_distance = max(distance, na.rm = TRUE)) %>%
  filter(max_distance > 0) %>% 
  slice_max(distance) %>% 
  ungroup()

#he 'cheap' measure is inaccurate over such large distances
#All distances (distance) are in meters

# ---- save ----
usethis::use_data(ships, overwrite = TRUE)
