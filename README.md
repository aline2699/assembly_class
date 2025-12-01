This repository is used for the two classes "genome and transcriptome assembly" and 
"organization and annotation of eucaryote genomes". The scripts used for the first part 
can be found in the folder scripts, while the scripts for the latter part are in the 
folder scripts_annotation.


The histogram result from kmere_counting from the genome and transcriptome assembly class 
can be found at: 
http://genomescope.org/genomescope2.0/analysis.php?code=NwmERHY3LWSIBdqqmW9h
These results were obtained by setting the Max k-mer coverage to 5000, because otherwise 
there is a peak around 9000. This peak is most likely due to the chloroplasts and 
mitochondria. Not correcting for it will result in a bad estimation of the length of the 
DNA.

