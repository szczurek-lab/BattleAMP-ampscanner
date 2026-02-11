#!/bin/bash
# AMPscanner v2 inference wrapper for battleamp-snakemake
#
# Interface contract:
#   $1 = path to input FASTA file (absolute)
#   $2 = path to output TSV file (absolute)
#
# Output columns: sequence  Prediction  Probability_score

set -euo pipefail

INPUT_FASTA="$1"
OUTPUT_TSV="$2"

if [ -z "$INPUT_FASTA" ] || [ -z "$OUTPUT_TSV" ]; then
    echo "Usage: inference.sh <input.fasta> <output.tsv>" >&2
    exit 1
fi

if [ ! -f "$INPUT_FASTA" ]; then
    echo "Error: input FASTA not found: $INPUT_FASTA" >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_OUTPUT="${OUTPUT_TSV}.raw"

# Step 1: Run AMPscanner (produces CSV: id,prediction,score,sequence,prediction_num)
cd "$SCRIPT_DIR"
python -m classif.inference -i "$INPUT_FASTA" -o "$TMP_OUTPUT"

# Step 2: Convert to standard pipeline format
python3 - "$TMP_OUTPUT" "$OUTPUT_TSV" << 'PYEOF'
import sys
import pandas as pd

raw_path = sys.argv[1]
out_path = sys.argv[2]

df = pd.read_csv(raw_path, delimiter=",")

# AMPscanner output columns (all lowercase after clean_ampscanner_preds):
# id, prediction, score, sequence, prediction_num
# Prediction values: "AMP" or "non-AMP"

out = pd.DataFrame({
    "sequence": df["sequence"],
    "Prediction": df["prediction"],
    "Probability_score": df["score"],
})

out.to_csv(out_path, sep="\t", index=False)
print(f"Converted {len(out)} predictions to {out_path}", file=sys.stderr)
PYEOF

rm -f "$TMP_OUTPUT"
echo "AMPscanner inference complete: $(wc -l < "$OUTPUT_TSV") lines" >&2
