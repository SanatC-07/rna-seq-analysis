#!/bin/bash

SECONDS=0

# Change to base directory
cd /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

# Step 1: Prefetch SRR files
echo "Downloading raw data..."
prefetch --option-file SRR_Acc_List.txt --output-directory /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw
echo "Download complete!"

# Step 2: Convert to fastq and perform QC
fasterq-dump SRR1039509.sra -O /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

fastqc SRR1039509_1.fastq SRR1039509_2.fastq -o /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw 

# Step 3: Trim reads and run FastQC again
java -jar /mnt/c/Softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
-threads 4 \
-phred33 \
SRR1039509_1.fastq SRR1039509_2.fastq \
SRR1039509_1_paired.fastq SRR1039509_1_unpaired.fastq \
SRR1039509_2_paired.fastq SRR1039509_2_unpaired.fastq \
ILLUMINACLIP:custom_adapters.fa:2:30:10 \
SLIDINGWINDOW:4:20 MINLEN:36
echo "Trimmomatic finished running!"

fastqc SRR1039509_1_paired.fastq SRR1039509_2_paired.fastq SRR1039509_1_unpaired.fastq SRR1039509_2_unpaired.fastq -o /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

# Step 4: Alignment with HISAT2 and Convert SAM to BAM
# Alignment
hisat2 -x /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw/grch38_genome/genome -1 SRR1039509_1_paired.fastq -2 SRR1039509_2_paired.fastq -S aligned_reads.sam
echo "HISAT2 finished running!"

# SAM to BAM
samtools view -bS aligned_reads.sam > aligned_reads.bam
samtools sort aligned_reads.bam -o aligned_reads_sorted.bam
samtools index aligned_reads_sorted.bam

# Step 5: Quantification
featureCounts -a Homo_sapiens.GRCh38.113.gtf -o /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/processed/counts.txt -p /mnt/c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw/aligned_reads.bam
echo "featureCounts finished running!"

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."