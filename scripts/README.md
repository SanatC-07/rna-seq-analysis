# RNA-Seq Analysis Pipeline


## Overview
This is a custom RNA-Seq analysis pipeline designed to process raw sequencing data, perform quality control, trimming, alignment, and quantification. The pipeline is built using bash scripting and integrates several widely-used bioinformatics tools such as SRA Toolkit, FastQC, Trimmomatic, HISAT2, and featureCounts.

The pipeline automates the process of downloading raw data, performing quality checks, trimming adapters, aligning sequences to a reference genome, and generating gene expression counts.


## Dependencies
Ensure you have the following dependencies installed on your system:

- SRA Toolkit (for prefetch and fasterq-dump)

- FastQC (for quality control)

- Trimmomatic (for trimming sequences)

- HISAT2 (for sequence alignment)

- Samtools (for SAM/BAM file processing)

- featureCounts (for gene expression quantification)


## Pipeline Steps
The pipeline consists of the following main steps:

### Step 1: Prefetch SRR Files
Downloads raw data from the SRA database based on the list of SRR IDs provided in SRR_Acc_List.txt.

### Step 2: Quality Control (FastQC)
Performs initial quality control on the raw FASTQ files using FastQC. Quality reports are saved for review.

### Step 3: Read Trimming (Trimmomatic)
Trims adapter sequences and filters low-quality reads using Trimmomatic. It generates both paired and unpaired output files, which are passed to the next step.

### Step 4: Alignment (HISAT2)
Aligns the processed reads to the reference genome (GRCh38) using HISAT2. The resulting SAM file is converted to a sorted and indexed BAM file using Samtools.

### Step 5: Quantification (featureCounts)
Counts the number of reads aligned to each gene using featureCounts and saves the results in a counts.txt file for downstream analysis.

### Step 6: Timing
At the end of the pipeline, the script will print the total execution time.


## License
This pipeline is provided under the MIT License. See the LICENSE file for more details.

### Notes on Customization:
- Ensure that paths in the script are correctly updated to match your system.

- Modify the reference genome or the adapter sequences as needed for your data.