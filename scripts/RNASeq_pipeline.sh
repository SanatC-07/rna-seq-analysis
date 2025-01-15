#!/bin/bash

# Change to base directory
cd /c/Users/sanat/Projects/RNA_Seq_Analysis/data/raw

# Step 1: Prefetch SRR files
echo "Downloading raw data..."
prefetch --option-file SRR_Acc_List.txt --output-directory raw/sra
echo "Download complete!"
