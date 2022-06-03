

# Load libraries ====================
require(pacman)
pacman::p_load(terra, sf, crayon, tidyverse, gtools, glue, fs)

# Load data =========================
path <- '../tbl'
fles <- dir_ls(path, regexp = '.csv')
fles <- as.character(fles)

fles
length(fles)

# To add the date ==================

i <- 1

tbls <- purrr::map(.x = 1:length(fles), .f = function(i){
  
  # Filter each file
  cat(green(basename(fles[i])), '\n')
  fle <- fles[[i]]
  fle <- as.character(fle)
  nme <- basename(fle)
  
  # Read as a table
  tbl <- read.csv(fle)
  colnames(tbl)
  rgn <- unique(tbl$region)
  vrs <- unique(tbl$variable)
  vrs
  length(vrs)
  
  smm <- tbl %>% 
    group_by(variable, region) %>% 
    dplyr::summarise(count = n()) %>% 
    ungroup() %>% 
    as.data.frame()
  
  glb <- tbl %>% 
    group_by(variable) %>% 
    dplyr::summarise(count = n()) %>% 
    ungroup() %>% 
    as.data.frame()
  
  lng <- sum(glb$count) / 50
  lng
  nvl <- rep(1:50, lng)
  tbl <- as_tibble(tbl)
  tbl <- mutate(tbl, nivel = nvl)
  
  # Get the dates
  dte <- str_split(nme, pattern = '_')
  dte <- dte[[1]][2]
  dte <- str_sub(dte, start = 1, end = 6)
  yea <- str_sub(dte, start = 1, end = 4)
  mnt <- str_sub(dte, start = 5, end = 6)
  
  # Add as a column 
  tbl <- mutate(tbl, year = yea, month = mnt)
  head(tbl)
  cat(green('Done!'), '\n')
  return(tbl)

  
})

allt <- bind_rows(tbls)
dir.create('../result')
write.csv(allt, '../result/all_tablas.csv', row.names = FALSE)

