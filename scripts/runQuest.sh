#!/usr/bin/env bash
# runQuast.sh

function Quast {
    quast.py ../data/trimmed/paired/rhodo/contigs.fasta
}

Quast
