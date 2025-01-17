#!/bin/bash

# Change to base directory
cd /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

# Step 1: Prefetch SRR files
echo "Downloading raw data..."
prefetch --option-file SRR_Acc_List.txt --output-directory /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw
echo "Download complete!"

# Step 2: Convert to fastq and perform QC
fasterq-dump SRR1039509.sra -O /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

fastqc SRR1039509_1.fastq SRR1039509_2.fastq -o /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw 

# Step 3: Trim reads and run FastQC again
java -jar /c/Softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
-threads 4 \
-phred33 \
SRR1039509_1.fastq SRR1039509_2.fastq \
SRR1039509_1_paired.fastq SRR1039509_1_unpaired.fastq \
SRR1039509_2_paired.fastq SRR1039509_2_unpaired.fastq \
ILLUMINACLIP:custom_adapters.fa:2:30:10 \
SLIDINGWINDOW:4:20 MINLEN:36

fastqc SRR1039509_1_paired.fastq SRR1039509_2_paired.fastq SRR1039509_1_unpaired.fastq SRR1039509_2_unpaired.fastq -o /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

