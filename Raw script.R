setwd("C:/Users/cjcar/Desktop")

library(codependent)
library(InsectDisease)
library(tidyverse)

gb <- read_csv('NCBIVirus_BG_nt_metadata.csv')

gb %>% 
  filter(Host == 'Drosophila melanogaster') %>%
  select(Host, Species) %>%
  unique() -> dm

dm %>%
  nrow()

# install.packages("~/Github/insectDisease", 
#                  repos = NULL, type = 'source')

id <- InsectDisease::viruses

id %>% 
  filter(Host == 'Drosophila melanogaster') %>%
  pull(Virus)

# Drosophila C virus and sigma virus are named, both in GenBank
# Retrovirus (RTV) and reovirus-like particle are not
# reovirus is equivalent to Drosophila reovirus
# So let's say there are 3 viruses here compared to 30 in GenBank - so 
# a multiplication factor of 10

id %>% 
  select(Host, Virus) %>%
  unique() -> assn

b <- binera(assn, iter = 100, plots = TRUE)
b 

c <- copredict(assn, iter = 100, n.indep = 6000000) # 6 million estimate based on Larsen et al. 2018 QRB

c[[1]][1]*10

gb %>% 
  select(Host, Species) %>%
  write_csv('~/Github/drosophily/GenBank_as_Edgelist.csv')
