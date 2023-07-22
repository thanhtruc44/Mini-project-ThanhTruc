#!usr/bin/bash
#############################################################
###############     Export enviroments     ##################
#############################################################

#Export enviroments from yaml file

for yml in ./env/*.yml; do
conda env create -f $yml
done
