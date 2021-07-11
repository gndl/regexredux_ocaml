#!/bin/bash

#make all

echo "Str sequential"
time ./str s < fasta_data.txt

echo "Str parallel"
time ./str p < fasta_data.txt

echo "Pcre sequential"
time ./pcre s < fasta_data.txt

echo "Pcre parallel"
time ./pcre p < fasta_data.txt

echo "Re.Str sequential"
time ./re_str s < fasta_data.txt

echo "Re.Str parallel"
time ./re_str p < fasta_data.txt

echo "Re.Pcre sequential"
time ./re_pcre_core s < fasta_data.txt

echo "Re.Pcre parallel"
time ./re_pcre_core p < fasta_data.txt
