# AMP Scanner v2

AMP Scanner v2, adapted for integration with the
[battleamp-snakemake](https://github.com/szczurek-lab/battleamp-snakemake) benchmarking
pipeline. The original model code and weights were received directly from the authors
upon request (no public repository available).

## Supported tasks

AMP classification (binary: AMP / non-AMP).

## Reference

Daniel Veltri, Uday Kamath, Amarda Shehu, Deep learning improves antimicrobial peptide recognition, Bioinformatics, Volume 34, Issue 16, August 2018, Pages 2740–2747, https://doi.org/10.1093/bioinformatics/bty179

## Requirements

- Python 3.8
- conda (for environment creation by the pipeline)

The model architecture (CNN + LSTM) and pretrained weights are unchanged. 

## Installation

```bash
conda create -n ampscanner python=3.8
conda activate ampscanner
sh setup.sh
```

Test whether everything works:

```bash
sh inference.sh sample.fasta results.tsv
```

## Usage within the pipeline

This repository is included as a git submodule in battleamp-snakemake:

```bash
cd battleamp-snakemake
git submodule add git@github.com:szczurek-lab/BattleAMP-ampscanner.git models/ampscanner
```

The pipeline handles environment creation, inference, and evaluation automatically.

## License

Same as the original AMP Scanner model terms.