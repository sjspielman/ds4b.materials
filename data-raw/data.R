algae <- readr::read_csv("algae.csv")  
biopsy <- readr::read_csv("biopsy.csv") 
birthwt <- readr::read_csv("birthwt.csv")
damselfly <- readr::read_csv("damselfly.csv")
olives <- readr::read_csv("olives.csv") 
pima <- readr::read_csv("pima.csv") 
urine <- readr::read_csv("urine.csv")  
sparrows <- readr::read_csv("sparrows.csv")  
wine <- readr::read_csv("wine.csv") 
wine_version1 <- readr::read_csv("wine_version1.csv")
wine_version2 <- readr::read_csv("wine_version2.csv")
pbta <- readr::read_tsv("pbta-histologies.tsv", guess_max =1e5)
mammogram <- readr::read_csv("mammogram.csv")
usethis::use_data(algae,
                  biopsy,
                  birthwt,
                  damselfly,
                  olives,
                  pima,
                  urine,
                  sparrows,
                  wine,
                  wine_version1,
                  wine_version2,
                  pbta,
                  mammogram,
                  overwrite = TRUE)
