NF 6308 Assignment6

Project name: Genome Assembly
The project demos the genome assembly process by using
third-party modules such as fastq-dump, trimmomatic,
spades.py, and quast.py, and in the end, a quality report
generated for evaluating the process outcome.


## Description

This genome assembly uses NGS data from SRA(a public database);
the assembled target is a bacterial genome SRR522244 from the
NIH SRA database. We will follow the steps to finish our task. 
1. Querying raw data 
2. Trimming and Filtering data 
3. Assembling sequence 
4. Assembly Validation

In the end, we can check the quality report in the quast_report
file and conclude the quality of the assembly result.


## Getting Started

* Hi, this is the documentation for assignment 6 of the bio-computational method course.
* That's start genome assembly project from the beginning, step by step, code by code.
* The working environment is under the Command line prompt, such as a Mac terminal or
Ubuntu (with Bash script), so please prepare it in advance.   


### Dependencies

* Python version 3.8.10 and compatible modules (if needed)
* SRA toolkit 
* Trimmomatic 0.39-2
* Spades.py
* Quast.py


### Installing

Install the third-party software above with specific dependencies
(if needed)

### Executing program

* Use the vim editor to prepare bash scripts for the following steps:

  1. Download SRA sequence raw data from the NCBI server via the fastq-dump command
  2. Trim and Filter the downloaded FASTQ file and separate it into paired and unpaired files
  3. Use spades.py to assemble paired data
  4. Apply quast.py to perform the assembly quality evaluation base on its algorithm 

* In the end, make all four scripts into one via the pipeline


The file storage structure should follow the instructure
below:  


```
module-06-YaoChiehYao-master
.
├── README.md
├── analysis/
│   └── batch-assembleGenome-456118.output
├── data/
│   ├── SRR522244_1.fastq
│   ├── SRR522244_2.fastq
│   └── trimmed/
│       ├── Rhodo.R1.paired.fastq
│       ├── Rhodo.R1.unpaired.fastq
│       ├── Rhodo.R2.paired.fastq
│       └── Rhodo.R2.unpaired.fastq
├── results/
│   ├── quast_results/
│   │   ├── latest/
│   │   └── results_2022_10_20_18_38_38/
│   │       ├── basic_stats/
│   │       │   ├── GC_content_plot.pdf
│   │       │   ├── Nx_plot.pdf
│   │       │   ├── contigs_GC_content_plot.pdf
│   │       │   ├── contigs_coverage_histogram.pdf
│   │       │   ├── coverage_histogram.pdf
│   │       │   └── cumulative_plot.pdf
│   │       ├── icarus.html
│   │       ├── icarus_viewers/
│   │       │   └── contig_size_viewer.html
│   │       ├── quast.log
│   │       ├── report.html
│   │       ├── report.pdf
│   │       ├── report.tex
│   │       ├── report.tsv
│   │       ├── report.txt
│   │       ├── transposed_report.tex
│   │       ├── transposed_report.tsv
│   │       └── transposed_report.txt
│   └── rhodo/
│       ├── K21/
│       ├── K33/
│       ├── K55/
│       ├── assembly_graph.fastg
│       ├── assembly_graph_with_scaffolds.gfa
│       ├── before_rr.fasta
│       ├── contigs.fasta
│       ├── contigs.paths
│       ├── corrected/
│       ├── dataset.info
│       ├── input_dataset.yaml
│       ├── misc/
│       ├── params.txt
│       ├── scaffolds.fasta
│       ├── scaffolds.paths
│       ├── spades.log
│       ├── tmp/
│       └── warnings.log
└── scripts/
    ├── getNGS.sh
    ├── runQuast.sh
    ├── runSpades.sh
    ├── sbatch_assembleGenome.sh
    └── trim.sh
```


  Here is the link of file: 
```
https://github.com/NU-Bioinformatics/module-06-YaoChiehYao.git
```

## Method

* fasterq-dump
  A tool to download SRA sequence files from the NCBI server. The split-3 parameter splits the FASTQ file into Left and Right pairs (R1,R2). If the sequence data is single-end, then the algorithm data will be put in a single file with no separation. 

* trimmomatic
  A software works for single-end and pair-end sequence data to trim Illumina FASTQ files, remove adaptors, and filter data for assembly.
  
  - The PE and SE parameter indicates the FASTQ data is pair-end or single-end. 
  - The phred 33 / phred 64 are the quality score converter 
  - The threads show how many server threads for running in this job
  - HEADCROP indicates how many bases should be removed from the beginning of the sequence (trim the primer/ adaptor)
  - ILLUMINACLIP cuts adaptor and other Illumina-specified sequences from the read
  - SLIDINGWINSODE performs a sliding window trimming approach. It starts scanning from the 5' end and clips the reads once the average quality within the window falls below a threshold
  - MINLEN drops the minimum reads if it is less than a specified length
   
  (Reference the Trimmomatic Manual: V0.32)

* spades
  an open-source genome assembly tool to align sequence data into contigs
  and scaffolds based on the setting.

  - 1 is the filename of the input file (forward paired-end reads)
  - 2 is is the filename of another input file (reverse paired-end reads)
  - 0 is assigned to the output directory

* quast
  open source quality validation tool to evaluate assembly results and
  turn into report files

  - The contigs.fasta is the assembly quality file, and have to give the output path after the quast.py

## Conclusion
Because the quest runs without a reference genome sequence, we can only say the result is identical since
the cumulate length of the contig, mismatch N's, and GC% align to a particular pattern but lack comparison.

In contrast, in their paper, Pabinger and Canzar et al. 2013 evaluate multiple genome assemblers for bacterial organisms. The evaluation tables compares each outcome from a specific method which is clear to judge the quality among different methods. 

Therefore, I will consider adding a reference sequence from Refseq in the NCBI or getting the R. sphaeroides HiSeq data from GAGE-B as a reference for further assembly validation.



# Statistics without reference	contigs
contigs	                        323
contigs (>= 0 bp)	              420
contigs (>= 1000 bp)	          285
contigs (>= 5000 bp)	          200
contigs (>= 10000 bp)	          147
contigs (>= 25000 bp)	          54
contigs (>= 50000 bp)	          13
Largest contig	                104244
Total length	                  4531150
Total length (>= 0 bp)	        4555060
Total length (>= 1000 bp)	      4503318
Total length (>= 5000 bp)	      4275282
Total length (>= 10000 bp)	    3881057
Total length (>= 25000 bp)	    2363848
Total length (>= 50000 bp)	    1002058
N50	                            25496
N75	                            14630
L50	                            51
L75	                            108
GC (%)	                        68.8
# Mismatches	
N's	                            0
N's per 100 kbp	                0



## Help

Any other issue contact with yao.yao-@northeastern.edu


## Authors

Yao Chieh Yao
Northeastern University Bioinformatics


## Version History

* 1.0
    * Assignment01 Finish 
* 0.1
    * Assignment01 Release 


## License

This project is an assignment work and only license to TA and professors of Northeastern University Bioinformatics 


## Acknowledgments
