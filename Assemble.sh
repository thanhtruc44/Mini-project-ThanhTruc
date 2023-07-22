#!/bin/bash
##########################################################################################
#####################         Assembly and filter contig            ######################
##########################################################################################

Spades="./result/Assembly/Spades"
Kraken2="./result/Assembly/Kraken2"
mkdir -p $Spades
mkdir -p $Kraken2

# #Assembly by spades tool

spades_version=$(conda run -n spades spades --version)
echo $spades_version >> version.txt
conda run -n spades spades --rna -1 ./result/Quality_control/Trimming/input1_trimmed.fastq.gz -2 ./result/Quality_control/Trimming/input2_trimmed.fastq.gz -o $Spades


#Filter contig by kraken2 tool
#Database virus: download at https://benlangmead.github.io/aws-indexes/k2 "Viral" 0.6GB và unzip by wget command

kraken2_version=$(conda run -n kraken2 kraken2 --version)
echo $kraken2_version >> version.txt
conda run -n kraken2 kraken2 --db virus --threads 8 --report $Kraken2/kraken2_report --output $Kraken2/kraken2_output $Spades/transcripts.fasta

#Run python
python3 Choose_contig.py 
