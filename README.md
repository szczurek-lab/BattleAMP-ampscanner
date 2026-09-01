# AMP Scanner v2

AMP Scanner v2, adapted for integration with the
[battleamp-snakemake](https://github.com/szczurek-lab/battleamp-snakemake) benchmarking
pipeline. The original model code and weights were received directly from the authors
upon request. A public repository has since become available at
[dan-veltri/amp-scanner-v2](https://github.com/dan-veltri/amp-scanner-v2), and the weights
shipped here are byte-identical to its `021820_FULL_MODEL.h5`.

## Supported tasks

AMP classification (binary: AMP / non-AMP).

## Training data

`training_data/` holds the Veltri et al. 2018 split, fetched unmodified from `original-dataset/` of
the upstream repository at commit `933052e2365631fe93098892120ee535e0ba381a`, on 2026-09-01.
Upstream is GPL-3.0 while this project is MIT.

| File | Records | Role |
|---|---|---|
| `AMP.tr.fa` | 712 | AMP training |
| `AMP.eval.fa` | 354 | AMP validation |
| `AMP.te.fa` | 712 | AMP test |
| `DECOY.tr.fa` | 712 | Non-AMP decoy training |
| `DECOY.eval.fa` | 354 | Non-AMP decoy validation |
| `DECOY.te.fa` | 712 | Non-AMP decoy test |

3,556 records, all distinct, 1,778 AMP and 1,778 decoy. This is the training set used for the
predictions BattleAMP reports, not a reconstruction: the shipped weights are byte-identical to
upstream `trained-models/021820_FULL_MODEL.h5` at that commit, sha256
`d56226f03fa5607923bb5b02ae9fead711c9923d1e100e4cba29e05f1db27bb4`.

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