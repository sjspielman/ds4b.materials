library(tidyverse)


datapath <- "data-raw/datasets/"
algae <- readr::read_csv(file.path(datapath, "algae.csv"))  
biopsy <- readr::read_csv(file.path(datapath, "biopsy.csv")) 
bodyfat <- readr::read_csv(file.path(datapath, "bodyfat.csv")) 
birthwt <- readr::read_csv(file.path(datapath, "birthwt.csv"))
crabs <- readr::read_csv(file.path(datapath, "crabs.csv"))
damselfly <- readr::read_csv(file.path(datapath, "damselfly.csv"))
olives <- readr::read_csv(file.path(datapath, "olives.csv")) 
pima <- readr::read_csv(file.path(datapath, "pima.csv")) 
urine <- readr::read_csv(file.path(datapath, "urine.csv"))  
sparrows <- readr::read_csv(file.path(datapath, "sparrows.csv"), col_types = list(Age = col_factor(),
                                                                                  Survival = col_factor(),
                                                                                  Sex = col_factor() )) 
wine <- readr::read_csv(file.path(datapath, "wine.csv")) 
wine_version1 <- readr::read_csv(file.path(datapath, "wine_version1.csv"))
wine_version2 <- readr::read_csv(file.path(datapath, "wine_version2.csv"))
pbta <- readr::read_tsv(file.path(datapath,"pbta-histologies.tsv"), guess_max =1e5)
mammogram <- readr::read_csv(file.path(datapath, "mammogram.csv"))
seals <- readr::read_csv(file.path(datapath, "seals.csv"))



ToothGrowth %>%
  rename(tooth_length = len, supplement = supp) %>%
  as_tibble() -> tooth_growth

chickwts %>%
  mutate(chick_id = 1:n()) %>%
  as_tibble() -> chick_weights

PlantGrowth %>%
  as_tibble() -> plant_growth

MASS::cats %>%
  as_tibble() %>%
  select(-Sex) %>%
  rename(body_weight = Bwt, heart_weight = Hwt) %>%
  distinct() %>%
  mutate(heart_weight = heart_weight/1000)-> domestic_cats

CO2 %>%
  as_tibble() %>%
  rename(plant_id = Plant,
         origin = Type,
         treatment = Treatment,
         co2_concentration = conc,
         co2_uptake_rate = uptake) -> cold_tolerance

# tidy data paper data
messy1 <- tibble::tribble(
  ~name, ~treatmenta, ~treatmentb,
  "John Smith", NA, 2, 
  "Jane Doe", 16, 11,
  "Mary Johnson", 3,1
)

messy2 <- tibble::tribble(
  ~"John Smith", ~"Jane Doe", ~"Mary Johnson",
  NA, 16, 3,
  2, 11, 1
)

tidy <- tibble::tribble(
  ~name, ~treatment, ~result,
  "John Smith", "a", NA,
  "John Smith", "b", 2,
  "Jane Doe", "a", 16,
  "Jane Doe", "b", 11,
  "Mary Johnson", "a", 3,
  "Mary Johnson", "b",1
)

bodyfat %>%
  mutate(id = 1:n()) %>%
  select(id, everything()) -> bodyfat


usethis::use_data(messy1, messy2, tidy, algae,
                  biopsy,
                  birthwt,
                  crabs,
                  bodyfat,
                  damselfly,
                  domestic_cats,
                  olives,
                  pima,
                  urine,
                  sparrows,
                  seals,
                  wine,
                  wine_version1,
                  wine_version2,
                  pbta,
                  mammogram,
                  plant_growth,
                  cold_tolerance,
                  tooth_growth,
                  chick_weights,
                  overwrite = TRUE)
