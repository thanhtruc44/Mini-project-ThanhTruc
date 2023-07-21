#!usr/bin/bash
#############################################################
###############     Export enviroments     ##################
#############################################################

#Export enviroments from yaml file

for yml in /mnt/d/Ktest/Project_virus/env/*.yml; do
conda env create -f $yml
done
