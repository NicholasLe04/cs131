#!/bin/bash

# Loop through the 3 vendor IDs
for vendorID in 1.0 2.0 4.0; do
	# Filter the rows with that ID and store outputs
	OUTPUT_FILE="$(date "+%F-%T")-${vendorID}.csv"
	grep -E "^${vendorID},.*" "${1}" > "${OUTPUT_FILE}"
	
	# Add file to .gitignore
	echo "${OUTPUT_FILE}" >> .gitignore
		
	# Store results of wc command
	wc "${OUTPUT_FILE}" >> ws4.txt
done

# Store results of cat .gitignore
cat .gitignore >> ws4.txt
