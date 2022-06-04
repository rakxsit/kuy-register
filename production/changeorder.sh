#!/bin/bash

# Make a folder with text files with desired order for pictures to be surfed through
# Make folder with images that should be shuffled
# Call the order folder as the argument

# Loop through files in participant number folders
partno=$1

# Make directory for new images
mkdir participants/"${partno}"/images; 

for orderfile in participants/"${partno}"/orders/*.txt; do
	# change order file to unix to avoid return carriage line
	perl -pi -e 's/\r\n|\n|\r/\n/g' "${orderfile}"

	# Now go through images and change to correct order
	for image in stimuli/*.png; 
	        do
			# Copy images in intended order
			read line; cp -v "$image" participants/"${partno}"/images/"${line}"; 
		done < "${orderfile}"
	done

# Add instruction pages
cp -v instructions/*.png participants/"${partno}"/images;