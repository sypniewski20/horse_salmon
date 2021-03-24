### This script reads .sf files from salmon output and joins them into single dataframe

library(tidyverse)
setwd('~/rnaseq/')

### Creating list of .sf files
sfl <- list.files(recursive = T)
sfl2 <- sfl[grep('*.sf',sfl)]
fl <- list.files('RNA-Seq/SALMON_OUT/')

rnadf <- list()

### Appending .sf files into list
for (i in 1:length(sfl2)) {
  df <- read.table(sfl2[i], header = T)
  df$tissue <- fl[i]
  rnadf[[i]] <- df
}

### Binding files into single dataframe
dfinal <- bind_rows(rnadf)

### Removing rnadf for memory saving
remove(rnadf)

### Saving dataframe to RDS
saveRDS(dfinal,'sfbind')
