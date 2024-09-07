inputpath="$1"
outputpath="$2"

python -m classif.inference -i "$inputpath" -o "$outputpath" &&

python convertoutputs.py "$outputpath" "$outputpath"
