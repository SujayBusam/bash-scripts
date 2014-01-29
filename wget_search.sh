#!/bin/bash
# Script name wget_serach.sh
# Description: Given a text file containing a list of URLs and a sequence of words, searches for occurences
# of the words in the webpages.

# Input: A text file of URLs and a sequence of words

# Output: Displays the word followed by the list of URLs and the occurence of the word in each page


# Make sure there is a suffient number of arguments
[[ $# > 1 ]] || { echo "At least two arguments needed: a URL text file and at least one word \
to search for."; exit 1; }

# Make sure the file exists
[ -f $1 ] || { echo "Given file, $1, does not exist."; exit 1; }

# for every word in the provided arguments..
# (skip the first because it is the url file)
for (( i = 2; i <= $# ; i++ ))
do

	current_word=${!i}
	# Print the searched word
	echo $current_word

  	# Run through each URL
  	html_num=1
  	for line in `cat "$1"`; do
  		echo -n "$line "

	    # Get the webpage and save it. If invalid URL, go to next URL.
	    wget -q -O $html_num.html $line 2>/dev/null

		# Print word occurrence only if valid URL
		if [ $? -ne 0 ]; then

			echo "not a valid URL. Going to next URL in file."

		else
			# Print the number of occurences of the word in the HTML file
			cat $html_num.html | grep $current_word -o | wc -l 
		fi

		# Increment file number
		let html_num=html_num+1

	done

done

exit 0