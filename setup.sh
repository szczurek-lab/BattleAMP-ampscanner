#!/bin/bash
set -euo pipefail

pip install -r requirements.txt

# Verify model weights exist
MODEL_FILE="resources/models/ampscannerv2_021820_full_model.h5"
if [ ! -f "$MODEL_FILE" ]; then
    echo "ERROR: Model file not found: $MODEL_FILE" >&2
    exit 1
fi

echo "AMPscanner setup complete"
