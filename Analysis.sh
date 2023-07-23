#!/bin/bash
################################################################
#####################     Analysis      ########################
################################################################

blastn="./result/Analysis/blastn"
mafft="./result/Analysis/mafft"
iqtree="./result/Analysis/iqtree"
mkdir -p $blastn
mkdir -p $mafft
mkdir -p $iqtree

#Input_path

Input="./result/Assembly/Kraken2/tembusu.fasta"

#Search "tembusu virus genome" on BV-BRC database then download all genome of tembusu virus

#Make database NCBI from file fasta

makeblastdb -in Genome_Tembusu_BVBRC_db.fasta -dbtype nucl -out tembusu_db

#Use blastn tool

blastn_version=$(conda run blastn blastn --version)
echo $blastn_version >> version.txt
conda run -n blast+ blastn -query $Input -db tembusu_db -out $blastn/blastn.txt -outfmt 6

#Combine 2 fasta files

cat $Input Genome_Tembusu_BVBRC_db.fasta > $mafft/mafft_input.fasta

#Mutiple alignment by Mafft tool

mafft_version=$(conda run -n mafft mafft --version)
echo $mafft_version >> version.txt
conda run -n mafft mafft --auto --thread 4 --reorder $mafft/mafft_input.fasta > $mafft/Mafft.aln

#Create a phylogenetic tree

iqtree_version=$(conda run -n iqtree iqtree --version)
echo "iqtree: $iqtree_version" >> version.txti
conda run -n iqtree iqtree -s $mafft/Mafft.aln -m GTR -bb 1000 -nt 4 -pre $iqtree/iqtree