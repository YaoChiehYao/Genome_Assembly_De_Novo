#!/usr/bin/env bash
# runSpades.sh

mkdir -p "rhodo/"

function Spades {
    spades.py \
    -1 ../data/trimmed/paired/Rhodo.R1.paired.fastq \
    -2 ../data/trimmed/paired/Rhodo.R2.paired.fastq \
    -o ../data/trimmed/paired/rhodo
}

Spades # runs the function Spades
