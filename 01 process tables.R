

# Load libraries ====================
require(pacman)
pacman::p_load(terra, sf, tidyverse, gtools, glue, fs)

# Load data =========================
path <- '../tbl'
fles <- dir_ls(path, regexp = '.csv')
fles <- as.character(fles)

fles
length(fles)