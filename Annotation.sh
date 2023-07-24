#!/bin/bash
#################################################################
########################   Annotation  ##########################
#################################################################

#Create result folder

Prokka="./result/Annotation/Prokka"
Hmmer="./result/Annotation/Hmmer"
mkdir -p $Prokka
mkdir -p $Hmmer

#Annotating protein by Prokka tool

prokka_version=$(conda run -n prokka prokka --version)
echo $prokka_version >> version.txt
conda run -n prokka prokka --force --outdir $Prokka --addgenes --addmrna --compliant --kingdom Viruses --species Tembusu ./result/Assembly/Kraken2/tembusu.fasta

#Annotating domain by Hmmer tool with Pfam database
#Download Pfam database:
wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
gunzip Pfam-A.hmm.gz
conda run -n hmmer hmmpress Pfam-A.hmm/Pfam-A.hmm
hmmer_version=$(conda run -n hmmer hmmscan -h)
echo $hmmer_version >> version.txt
conda run -n hmmer hmmscan --domtblout $Hmmer/hmmer.tbl Pfam-A.hmm/Pfam-A.hmm $Prokka/*.faa
