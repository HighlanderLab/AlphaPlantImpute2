#!/bin/bash
set -euo pipefail

# Test workflow with ped files

# Create library from .ped (only using HD genotypes in .ped)
python ../../pythonhmm-script.py -createlib -out lib -ped masked.ped -n_haplotypes 20 -n_sample_rounds 5 -hd_threshold 0.9 -seed 42 -ncorrect

# Impute using this library
python ../../pythonhmm-script.py -impute -out imputed -library lib.ped -ped masked.ped -n_haplotypes 20 -seed 42

# Check accuracy - should be 1.0 for HD and 0.9679 for LD (with seed 42)
python ../../pythonhmm-script.py -decode true.ped imputed.ped
python ../accuracy.py

