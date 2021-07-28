#!/bin/bash

#make all

echo -e "\n\n\tPcre sequential :\n"
time ./pcre s < fasta_data.txt
time ./pcre s < fasta_data.txt
time ./pcre s < fasta_data.txt

echo -e "\n\n\tPcre parallel :\n"
time ./pcre p < fasta_data.txt
time ./pcre p < fasta_data.txt
time ./pcre p < fasta_data.txt

echo -e "\n\n\tPcre parallel count :\n"
time ./pcre pc < fasta_data.txt
time ./pcre pc < fasta_data.txt
time ./pcre pc < fasta_data.txt

echo -e "\n\n\tPcre jit sequential :\n"
time ./pcre_jit s < fasta_data.txt
time ./pcre_jit s < fasta_data.txt
time ./pcre_jit s < fasta_data.txt

echo -e "\n\n\tPcre jit parallel :\n"
time ./pcre_jit p < fasta_data.txt
time ./pcre_jit p < fasta_data.txt
time ./pcre_jit p < fasta_data.txt

echo -e "\n\n\tPcre jit parallel count :\n"
time ./pcre_jit pc < fasta_data.txt
time ./pcre_jit pc < fasta_data.txt
time ./pcre_jit pc < fasta_data.txt

echo -e "\n\n\tRe sequential :\n"
time ./re_pcre_core s < fasta_data.txt
time ./re_pcre_core s < fasta_data.txt
time ./re_pcre_core s < fasta_data.txt

echo -e "\n\n\tRe parallel :\n"
time ./re_pcre_core p < fasta_data.txt
time ./re_pcre_core p < fasta_data.txt
time ./re_pcre_core p < fasta_data.txt

echo -e "\n\n\tRe parallel count :\n"
time ./re_pcre_core pc < fasta_data.txt
time ./re_pcre_core pc < fasta_data.txt
time ./re_pcre_core pc < fasta_data.txt

# echo -e "\n\n\tStr sequential :\n"
# time ./str s < fasta_data.txt

# echo -e "\n\n\tStr parallel :\n"
# time ./str p < fasta_data.txt

# echo -e "\n\n\tRe.Str sequential :\n"
# time ./re_str s < fasta_data.txt

# echo -e "\n\n\tRe.Str parallel :\n"
# time ./re_str p < fasta_data.txt

