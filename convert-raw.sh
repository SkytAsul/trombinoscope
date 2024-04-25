#!/bin/bash

# First step: do the work on images (replacing green screen, cropping, resizing)
cd trombinoclean
./replacehsv.py

# Second step: we delete all existing CSV files
rm ../data/**/*.csv
cd ../raw
# Loop on all .xlsx files recursively, with a little spice because files can have spaces in the names
find . -type f -name "*.xlsx" -print0 | while IFS= read -r -d '' file; do
	# Convert file to csv and place them in the right folder directly.
	# The 44,24,76 are values found on the internet. It seems to indicate that the csv should be separated by commas,
	# among other options.
	libreoffice --headless --convert-to csv:"Text - txt - csv (StarCalc)":44,34,76 "$file" --outdir "../data/$(dirname "$file")"
done
