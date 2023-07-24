#!/bin/bash
###########################################################################################
##############################      Quality_control     ###################################
###########################################################################################

#Create result dicrectory    

QC="./result/Quality_control/QC"
Trim="./result/Quality_control/Trimming"
QC_after_trim="./result/Quality_control/QC_after_trimming"
mkdir -p $QC
mkdir -p $Trim
mkdir -p $QC_after_trim
touch ./version.txt 

#Parameters

input1=$1
input2=$2
Hign_Duplication="True" 

#Quality control by fastqc tool

fastqc_version=$(conda run -n fastqc fastqc --version)
echo $fastqc_version > version.txt
fastqc $input1 $input2 -o $QC

#Preprocessing by fastp tool

fastp_version=$(conda run -n fastp fastp --version)
echo $fastp_version >> version.txt


#If duplication rate is high then add the parameters "--deup" and "--dup_calc_accuracy 2" else use default parameter
if [ $Hign_Duplication == "True" ]; then 
conda run -n fastp fastp --in1 $input1 --in2 $input2 --out1 $Trim/input1_trimmed.fastq.gz --out2 $Trim/input2_trimmed.fastq.gz -l 50 -h wgs.html &> wgs.log --trim_poly_g -q 15 -u 40 --dedup --dup_calc_accuracy 2
else
conda run -n fastp --in1 $input1 --in2 $input2 --out1 $Trim/input1_trimmed.fastq.gz --out2 $Trim/input2_trimmed.fastq.gz -l 50 -h wgs.html &> wgs.log --trim_poly_g -q 15 -u 40
fi

mv wgs* $Trim
mv fastp.json $Trim

#Quality control after trimming

conda run -n fastqc fastqc $Trim/input1_trimmed.fastq.gz $Trim/input2_trimmed.fastq.gz -o $QC_after_trim
