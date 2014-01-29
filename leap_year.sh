#!/bin/bash
# Script name leap_year.sh
# Description: Takes in a year as input and determines if it's a leap year. If the user does not enter a correct
# leap year then the script should compute the next leap year after the date entered.

# Input: A year

# Output: Displays a message stating whether or not given year is a leap year. Displays closest leap year if necessary.



# Function that determines whether passed in year is a leap year
is_leap_year() {
	year=$1

	# Run through leap year algorithm

	# If divisible by 400 then is leap year
	if (( (($year % 400)) == 0)); then
		leap_year=true

	# Else if divisible by 100, not leap year
	elif (( (($year % 100)) == 0)); then
		leap_year=false

	# Else if divisble by 4, then is leap year
	elif (( (($year % 4)) == 0)); then
		leap_year=true

	# Else not a leap year
	else
		leap_year=false
	fi
}


# Make sure one parameter is passed in
[ $# = 1 ] || { echo "You need to pass in one year as an argument."; exit 1; }

my_year=$1
leap_year=false

# Make sure parameter is a year
if [[ $my_year =~ [0-9]+$ ]] && (( (($my_year % 1)) == 0)) && (( $my_year >= 0 )); then

	# If it is a leap year, print it out
	is_leap_year $my_year
	if $leap_year; then
		echo "$my_year is a leap year."

	# Otherwise, print out the next closest leap year
	else
		echo "$my_year is not a leap year."

		# Find the next leap year
		while [ "$leap_year" = "false" ]; do
			let my_year=my_year+1
			is_leap_year $my_year
		done

		echo "The next closest leap year is $my_year"
	fi
	

# Invalid parameter
else
	echo "You did not enter a year"
	exit 1
fi


exit 0