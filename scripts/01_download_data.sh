#!/bin/bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name="download_data_assembly"
#SBATCH --time=00:00:10
#SBATCH --mem-per-cpu=2G


cd /data/users/asteiner/assembly_annotation_course
ln -s /data/courses/assembly-annotation-course/raw_data/Nemrut-1 ./
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./