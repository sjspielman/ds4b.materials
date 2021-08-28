datapath <- "datasets/"
algae <- readr::read_csv(file.path(datapath, "algae.csv"))  
biopsy <- readr::read_csv(file.path(datapath, "biopsy.csv")) 
birthwt <- readr::read_csv(file.path(datapath, "birthwt.csv"))
damselfly <- readr::read_csv(file.path(datapath, "damselfly.csv"))
olives <- readr::read_csv(file.path(datapath, "olives.csv")) 
pima <- readr::read_csv(file.path(datapath, "pima.csv")) 
urine <- readr::read_csv(file.path(datapath, "urine.csv"))  
sparrows <- readr::read_csv(file.path(datapath, "sparrows.csv"))  
wine <- readr::read_csv(file.path(datapath, "wine.csv")) 
wine_version1 <- readr::read_csv(file.path(datapath, "wine_version1.csv"))
wine_version2 <- readr::read_csv(file.path(datapath, "wine_version2.csv"))
pbta <- readr::read_tsv(file.path(datapath,"pbta-histologies.tsv"), guess_max =1e5)
mammogram <- readr::read_csv(file.path(datapath, "mammogram.csv"))
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
