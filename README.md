# Mini_project_ThanhTruc

## Script: Tembusu Virus Genome Analysis Pipeline

### Description 

This bash script is a genome analysis pipeline that performs a series of tasks, including exporting environments, quality control and preprocessing, assembly and contig filtering, annotation, and sequence analysis. The script takes two input files in FASTQ format and performs various bioinformatics analyses to analyze the genome data.

### Usage

1. Place your input FASTQ files in the working directory. The script will prompt you to enter the path to the working directory.

2. Run the script by providing the two input FASTQ files as arguments:

   bash Script.sh input_file1.fastq.gz input_file2.fastq.gz

### Pipeline Steps

The script consists of the following pipeline steps:

1. Export Environments (Export_enviroments.sh): This step exports environments from YAML files to Conda environments using the conda env create command.

2. Quality Control and Preprocessing (Quality_control.sh): This step performs quality control and preprocessing on the input FASTQ files using tools such as 'fastqc' and 'fastp'.

3. Assembly and Filter Contig (Assembly.sh): This step performs assembly of the reads into contigs using the 'spades' tool and filters the contigs using the 'kraken2' tool with a virus database.

4. Annotation (Annotation.sh): This step annotates protein-coding genes using the 'prokka' tool and identifies protein domains using the 'hmmer' tool with the Pfam database.

5. Analysis (Analysis.sh): This step performs sequence analysis, including running a BLASTn search on the BV-BRC database, multiple sequence alignment with 'mafft', and phylogenetic tree construction with 'iqtree'.

### Notes

1. Make sure you have the required dependencies installed for each step of the pipeline (specified in each sub-script).

2. Before running the script, review the file paths and parameters to ensure they match your specific setup.

## Module 1: Export Environments from YAML

### Description 

This script is a bash script that exports environments from YAML files to Conda environments. It looks for YAML files in the './env/' directory and creates Conda environments based on each YAML file found.

### Usage

1. Place your YAML files containing Conda environment specifications in the './env/' directory.
2. Make sure you have Conda installed on your system.
3. Run the script by executing the following command in the terminal:

   bash Export_enviroments.sh

### Notes

- This script assumes that you have Conda installed and properly configured on your system.

- The YAML files should contain valid Conda environment specifications.

- The script uses 'conda env create' to create environments from YAML files.

- The Conda environments will be created based on the YAML filenames.

- Remember to activate the desired environment using 'conda activate environment_name' before using it.

## Module 2: Quality Control Script

### Description

This script is a bash script for performing quality control and preprocessing of paired-end sequencing data using the `fastqc` and `fastp` tools from the Conda environment. The script performs the following steps:

1. Creates directories to store the output files.
2. Performs quality control using `fastqc` on the raw input fastq files.
3. Performs preprocessing using `fastp` to trim adapters, remove low-quality reads, and deduplicate reads if specified.
4. Performs quality control using `fastqc` on the trimmed fastq files.

### Usage

1. Place your raw paired-end sequencing fastq files in the same directory as the script.

2. Open a terminal and navigate to the directory containing the script.

3. Run the script with the following command:

   bash Quality_control.sh input_file_1.fastq.gz input_file_2.fastq.gz

Replace input_file_1.fastq.gz and input_file_2.fastq.gz with the actual paths to your raw paired-end fastq files.

### Output

The script will create the following directories to store the output files:
./result/Quality_control/QC: Quality control output before trimming.
./result/Quality_control/Trimming: Preprocessing output after trimming.
./result/Quality_control/QC_after_trimming: Quality control output after trimming.
The script will also generate a file named version.txt containing the versions of fastqc and fastp used in the analysis.

## Module 3: Assembly and Filter Contig

### Descripttion:

This bash script performs assembly and contig filtering using the 'spades' and 'kraken2' tools. It takes input trimmed FASTQ files, performs de novo transcriptome assembly using 'spades', and then filters the resulting contigs using the 'kraken2' tool with a virus database. The script performs the following steps:

1. Assembly using spades: The script will use the 'spades' tool to perform de novo transcriptome assembly. The assembled contigs will be saved in the './result/Assembly/Spades/' directory.

2. Filter contigs using kraken2: The script will use the 'kraken2' tool with the 'virus' database to filter the contigs. The filtered contigs and the kraken2 report will be saved in the './result/Assembly/Kraken2/' directory.
Run Python script:

3. The script will run a Python script named 'Choose_contig.py'. Make sure you have Python 3 installed.

### Prerequisites

- Ensure that you have installed the necessary dependencies (spades, kraken2) using Conda or other package managers.

- Download the 'viral' database for kraken2. You can download it from [https://benlangmead.github.io/aws-indexes/k2](https://benlangmead.github.io/aws-indexes/k2). The downloaded file should be unzipped using the 'wget' command.

### Usage

1. Make sure you have the required input files:
   - Trimmed FASTQ files should be available in the './result/Quality_control/Trimming/' directory. The files should be named 'input1_trimmed.fastq.gz' and 'input2_trimmed.fastq.gz'.

2. Create the necessary result directories:
   - Run the script to create directories for assembly and kraken2 results:
         bash Assembly.sh

### Notes

1. This script assumes that you have the required Conda environments (spades, kraken2) set up properly.

2. The 'viral' database for kraken2 should be downloaded and unzipped before running the script.

3. The resulting contigs will be saved in the './result/Assembly/Spades/' directory, and the filtered contigs and kraken2 report will be saved in the './result/Assembly/Kraken2/' directory.

4. Before running the script, review the file paths and parameters to ensure they match your specific setup.

## Module 4: Protein Annotation and Domain Identification

### Description:

This bash script performs protein annotation and domain identification using the 'prokka' and 'hmmer' tools. It annotates protein-coding genes with 'prokka' and identifies protein domains using 'hmmer' with the Pfam database. The script performs the following steps:

1. Protein Annotation using Prokka: The script will use the 'prokka' tool to annotate protein-coding genes. The annotated proteins will be saved in the './result/Annotation/Prokka/' directory.

2. Domain Identification using Hmmer: The script will use the 'hmmer' tool with the Pfam database to identify protein domains. The results will be saved in the './result/Annotation/Hmmer/' directory.

### Prerequisites

- Ensure that you have installed the necessary dependencies (prokka, hmmer) using Conda or other package managers.

- Download the Pfam database for 'hmmer'. You can download it from [https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz](https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz). The downloaded file should be unzipped using the 'wget' command.

- Before running the script, make sure you have the necessary input files, including the transcriptome assembly file 'tembusu.fasta' in the './result/Assembly/Kraken2/' directory.

### Usage

Run the script:
   bash Annotation.sh

### Notes

1. This script assumes that you have the required Conda environments (prokka, hmmer) set up properly.

2. The Pfam database for hmmer should be downloaded and unzipped before running the script.

3. The transcriptome assembly file 'tembusu.fasta' should be available in the './result/Assembly/Kraken2/' directory.

4. Before running the script, review the file paths and parameters to ensure they match your specific setup.

## Module 5: Sequence Analysis and Phylogenetic Tree Construction 

### Description

This bash script performs sequence analysis and constructs a phylogenetic tree using the 'blastn', 'mafft', and 'iqtree' tools. It uses the BLASTn tool to search for "tembusu virus genome" on the BV-BRC database and downloads all genomes of tembusu virus. It then uses 'mafft' for multiple sequence alignment and 'iqtree' to create a phylogenetic tree. The script performs the following steps:

1. BLASTn Analysis: The script will use the 'blastn' tool to search for "tembusu virus genome" on the BV-BRC database and download all genomes of tembusu virus. The results will be saved in the './result/Analysis/blastn/' directory.

2. Multiple Sequence Alignment using Mafft: The script will use the 'mafft' tool to perform multiple sequence alignment on the downloaded genomes and the 'tembusu.fasta' file. The aligned sequences will be saved in the './result/Analysis/mafft/' directory.

3. Phylogenetic Tree Construction using Iqtree: The script will use the 'iqtree' tool to create a phylogenetic tree from the aligned sequences. The phylogenetic tree will be saved in the './result/Analysis/iqtree/' directory.

### Prerequisites

- Ensure that you have installed the necessary dependencies (blastn, mafft, iqtree) using Conda or other package managers.

- Make sure you have downloaded the BV-BRC database for "tembusu virus genome" and saved it in a file named 'Genome_Tembusu_BVBRC_db.fasta'.

### Usage

Run the script:
   bash Analysis.sh

### Notes

1. This script assumes that you have the required Conda environments (blastn, mafft, iqtree) set up properly.

2. Before running the script, review the file paths and parameters to ensure they match your specific setup.

3. Make sure you have downloaded the BV-BRC database file 'Genome_Tembusu_BVBRC_db.fasta' for "tembusu virus genome" and placed it in the working directory.

# Trung's COMMENTS
***Một điều quan trọng đã nhắc: ko commit dữ liệu hay data nặng lên github. Nên up lên 1 nền tảng drive hay đám mây và share link***





