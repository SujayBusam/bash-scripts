#!/bin/bash
# Script name count_linesinfiles.sh

# Description: Counts the number of ordinary files in the current working directory and its sub-
# directories. For reach ordinary file found, the script counts the number of lines in the file and 
# prints the total number of lines for files in the directory tree rooted at the current working
# directory.

# Input: none

# Output: Show line count followed by corresponding file. Also display total linecount and number of files found


# Create an array containing all regular files in current directory and sub-directories
file_array=(`find . -type f`)

# Display message
echo "Counting lines of all files..."

total_lines=0
file_count=0


# For each file in array
for i in ${file_array[@]}; do

	# Get the line count of the file
	line_count=`wc -l $i | cut -d ' ' -f1`
	# Echo the line count and file name
	echo "$line_count $i"

	# Update total line count
	let total_lines=total_lines+line_count
	# Update file count
	let file_count=file_count+1

done

# Echo total lines and total files
echo "$total_lines Total"
echo "*************************"
echo "Number of files found: $file_count"
echo "*************************"

exit 0