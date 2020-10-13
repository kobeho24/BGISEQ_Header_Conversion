#!/bin/bash

# Example BGI SAMPLE NAME
declare -a SAMPLE_ID_SET=(A7 A8 A9 A10)

for X in {1..4}; do
        for N in {1..4}; do
                for M in {1..4}; do

# Set of sample index barcodes from 10x Genomics
        SAMPLE_ID_NUMBER=$(($X - 1 ))
        SAMPLE_ID=${SAMPLE_ID_SET[$SAMPLE_ID_NUMBER]}
        declare -a INDEX_BARCODES=($(cat sample_indices_merged.csv | grep -w ${SAMPLE_ID} | awk -v FS=',' '{print $2}'))
# Loop to iterate through each set of files, to attach cell barcodes per sample
                INDEX_NUMBER=$(($M - 1 ))
                BARCODE=${INDEX_BARCODES[$INDEX_NUMBER]}
                INPUT_FILE_R1=${SAMPLE_ID}_${BARCODE}_S1_L00${N}_R1_001.fastq.gz
                INPUT_FILE_R2=${SAMPLE_ID}_${BARCODE}_S1_L00${N}_R2_001.fastq.gz
		OUTPUT_FILE_R1=illumina_${SAMPLE_ID}_${BARCODE}_S1_L00${N}_R1_001.fastq.gz
        	OUTPUT_FILE_R2=illumina_${SAMPLE_ID}_${BARCODE}_S1_L00${N}_R2_001.fastq.gz
                python convertHeaders_LJ.py -i $INPUT_FILE_R1 -o $OUTPUT_FILE_R1 &
        	python convertHeaders_LJ.py -i $INPUT_FILE_R2 -o $OUTPUT_FILE_R2
                done
        done
done

