

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

purrr::map(.x = 1:length(fles), .f = function(i){
  
  # Filter each file
  cat(green(basename(fles[i])), '\n')
  fle <- fles[[i]]
  fle <- as.character(fle)
  nme <- basename(fle)
  
  # Read as a table
  tbl <- read.csv(fle)
  
  
  
  
  cat(green('Done!'), '\n')
  
})