#!/bin/bash

# First step: do the work on images (replacing green screen, cropping, resizing)
cd trombinoclean
#./replacehsv.py

# Second step: we convert the XLSX files to CSV files
#rm ../data/*/**.csv # does not seem to work on bash
cd ../raw
# Loop on all .xlsx files recursively, with a little spice because files can have spaces in the names
find . -type f -name "*.xlsx" -print0 | while IFS= read -r -d '' file; do
	outdir="../data/$(dirname "$file")"
	filename=$(basename "$file")
	converted="$outdir/${filename%xlsx}csv"
	if [ -f "$converted" ]; then
		echo "Converted $file is already present in $outdir."
	else
		# Convert file to csv and place them in the right folder directly.
		# The 44,24,76 are values found on the internet. It seems to indicate that the csv should be separated by commas,
		# among other options.
		libreoffice --headless --convert-to csv:"Text - txt - csv (StarCalc)":44,34,76 "$file" --outdir $outdir
	fi
done
