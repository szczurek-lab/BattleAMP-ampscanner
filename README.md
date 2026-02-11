# BattleAMP-AMPScanner

Fork of [AMP Scanner v2](https://github.com/lincoln-harris/amp-scanner-v2) (Veltri et al., 2018) adapted for the [BattleAMP benchmark pipeline](https://github.com/szczurek-lab/battleamp-snakemake).

## What is AMP Scanner v2

AMP Scanner v2 is a deep learning classifier for antimicrobial peptide prediction. It uses a CNN followed by an LSTM layer, with integer-encoded amino acid sequences padded to length 200. Sequences must be between 10 and 200 residues.

Original paper: Veltri et al. (2018). Deep learning improves antimicrobial peptide recognition. *Bioinformatics*, 34(16), 2740-2747. https://doi.org/10.1093/bioinformatics/bty179

## Requirements

- Python 3.8 (pinned for TensorFlow/Keras compatibility)
- conda (for environment creation by the pipeline)
- No GPU required (model is small, runs efficiently on CPU)

## Notes

- AMP Scanner v2 uses TensorFlow <= 2.2.3 and Keras 2.3.1, which require Python 3.8 and CUDA 10.1 for GPU support. Since most modern systems run CUDA 12, the model is configured to run on CPU (`gpu_required: false`). With 98k sequences and a 2.4MB model, CPU inference completes quickly.
- The pretrained model file is included in the repository. No weight download is needed.
- Sequences outside the 10-200 length range are silently dropped by the model internally. The pipeline's pre-filter also enforces this range.

## License

Same as the original AMP Scanner v2 repository.