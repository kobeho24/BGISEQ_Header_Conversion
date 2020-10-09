#!/bin/bash

# Example BGI SAMPLE NAME
BGI_ID=V300070358
INPUT_FILE_DIR=/mnt/home/jhebd/rawdata/bgiseq/${BGI_ID}
declare -a SAMPLE_ID_SET=(A7 A8 A9 A10)

for X in {1..4}; do
	for N in {1..4}; do
    		for M in {1..4}; do
# Loop to iterate through each set of files, to attach cell barcodes per sample
        SAMPLE_ID_NUMBER=$(($X - 1 ))
        SAMPLE_ID=${SAMPLE_ID_SET[$SAMPLE_ID_NUMBER]}
# Set of sample index barcodes from 10x Genomics
        declare -a INDEX_BARCODES=($(cat sample_indices_merged.csv | grep -w ${SAMPLE_ID} | awk -v FS=',' '{print $2}'))
		INPUT_FILE_R1=${INPUT_FILE_DIR}/${BGI_ID}_L0${N}_${SAMPLE_ID}_${M}_1.fq.gz
        	INPUT_FILE_R2=${INPUT_FILE_DIR}/${BGI_ID}_L0${N}_${SAMPLE_ID}_${M}_2.fq.gz
	    	INDEX_NUMBER=$(($M - 1 ))
        	BARCODE=${INDEX_BARCODES[$INDEX_NUMBER]}
        	OUTPUT_FILE_R1=${SAMPLE_ID}_${BARCODE}_L00${N}_R1.fastq.gz
        	OUTPUT_FILE_R2=${SAMPLE_ID}_${BARCODE}_L00${N}_R2.fastq.gz
        	bash attachBarcodes.sh $INPUT_FILE_R1 $OUTPUT_FILE_R1 $BARCODE &
        	bash attachBarcodes.sh $INPUT_FILE_R2 $OUTPUT_FILE_R2 $BARCODE
		done
	done
done
