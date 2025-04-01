# AMPScanner

## Supported tasks
AMP classification

## Installation

**environment**
- python 3.8
- `requirements.txt`

```
conda create -n ampscanner python=3.8
conda activate ampscanner
sh setup.sh
```

Test whether everything works:
```
sh inference.sh sample.fasta results.tsv
```