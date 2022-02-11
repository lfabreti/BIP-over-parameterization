#!/usr/bin/Rscript --

### Check for convergence ###
library(convenience)

args = commandArgs(trailingOnly=TRUE)
NUM_TAXA = args[1]
NUM_SITES = args[2]
BL_MEAN = args[3]
sim = args[4]
SUBST_MODEL = args[5]


name_files <- c( paste0("output/",SUBST_MODEL,"_nTaxa_",NUM_TAXA,"_nSites_",NUM_SITES,"_bl_",BL_MEAN,"_sim_",sim,"_run_1.log"),
                 paste0("output/",SUBST_MODEL,"_nTaxa_",NUM_TAXA,"_nSites_",NUM_SITES,"_bl_",BL_MEAN,"_sim_",sim,"_run_1.trees"),
                 paste0("output/",SUBST_MODEL,"_nTaxa_",NUM_TAXA,"_nSites_",NUM_SITES,"_bl_",BL_MEAN,"_sim_",sim,"_run_2.log"),
                 paste0("output/",SUBST_MODEL,"_nTaxa_",NUM_TAXA,"_nSites_",NUM_SITES,"_bl_",BL_MEAN,"_sim_",sim,"_run_2.trees") )

check_convergence <- checkConvergence(list_files = name_files)

writeLines( as.character(check_convergence$converged), con = paste0("convergence_assessment/",SUBST_MODEL,"_nTaxa_",NUM_TAXA,"_nSites_",NUM_SITES,"_bl_",BL_MEAN,"_sim_",sim,".txt") )
