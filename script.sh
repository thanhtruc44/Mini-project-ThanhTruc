#!usr/bin/bash
#Create working directory
echo "Enter the path to the working directory"
read path
cd $path
#Input
Input1=$1
Input2=$2
#######################      Export enviroments     ########################

bash Export_enviroments.sh 

###################   Quality control and Preprocessing  ###################

bash Quality_control.sh $Input1 $Input2

####################   Assembly and filter contig  #########################

bash Assembly.sh

####################           Annotation        ############################

bash Annotation.sh

#########################      Annalysis     ################################

bash Analysis.sh

echo "Done"

