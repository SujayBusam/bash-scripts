#!/bin/bash
# Script name birthday_match.sh
# Description: Takes in two birthdays in the form MM/DD/YYYY and returns whether there is a match if the two people were born on the same day of the week.

# Input: Two birthday in the form MM/DD/YYYY

# Output: Displays a message stating whether or not two birthdays are on the same day of the week.



# Make sure two parameters are passed in
[ $# = 2 ] || { echo "You need to pass in two dates as arguments. You passed in $#."; exit 1; }

# Date variables
date_one=$1
date_two=$2


# Make sure first date is in valid format MM/DD/YYYY
if [[ $date_one == [0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9] ]]; then
	# Make sure second date is in valid format
	if [[ $date_two == [0-1][0-9]/[0-3][0-9]/[0-9][0-9][0-9][0-9] ]]; then 
		
		# Make sure dates are a valid calendar dates
		if date -d "$date_one" 2>/dev/null 1>&2 && date -d "$date_two" 2>/dev/null 1>&2; then
			
			# Store the days corresponding to each date in variables
			day_one=`date -d "$date_one" "+%A"`
			day_two=`date -d "$date_two" "+%A"`

			echo "The first person was born on: $day_one"
			echo "The second person was born on: $day_two"

			# If days correspond, write appropriate message. Born on same day
			if [ $day_one = $day_two ]; then
				echo "Jackpot: You were both born on the same day!"

			# Not born on same day
			else
				echo "Therefore, you are not born on the same day."
			fi

		# One of the dates not a valid calendar date
		else
			echo "Not valid dates. Try again."
			exit 1
		fi

	# Second date did not pass format validation
	else
		echo "Second date not formatted correctly (MM/DD/YYYY). Try again."
		exit 1 
	fi


# First date did not pass format validation
else
	echo "First date not formatted correctly (MM/DD/YYYY). Try again."
	exit 1
fi


exit 0


