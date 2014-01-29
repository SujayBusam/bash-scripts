#!/bin/bash
# Script name spy.sh

# Description: Checks if any users given as input are logged on to a machine. When the user logs out, the script
# sends the user an email with the subject title "Gotacha username!" The email includes the time the user logged
# in and out, and the duration of time on the machine.




# Make sure at least one user parameter is given
[[ $# > 0 ]] || { echo "You need to input at least one user as an argument."; exit 1; }

# Initialize user variables, for each user
for ((i=1;i<=$#;i++)); do

	current_user=`cat /etc/passwd | grep "${!i}" | cut -d: -f1`

	# Make sure user exists. Otherwise move on to next one.
    if [ -z "$current_user" ]; then
      echo "${!i} not a valid user. Moving on to next one if necessary."
      break
    fi

    #Array for usernames
	user_names[$i]=$current_user

	# Relevant times
	login_time[$i]=0
	logout_time[$i]=0


	# Variable to keep track of number times user is reported logged in. Allows script to display
	# total time user has spent logged in
	login_number[$i]=0

	echo "$current_user"

done



# Infinite loop where script actions are taken
while [ true ]; do
	
	# For each user
	for ((i=1;i<=$#;i++)); do

		# Check if user is logged in
		if who | grep -q ${user_names[$i]}; then

			# Check if user was logged in before while script was running
			if [ ${login_number[$i]} -gt 0 ]; then
				# User logged in previously
				# Increment user's login number
				let login_number[$i]=login_number[$1]+1

			# User has not legged in previously
			else
				login_number[$i]=1 # First login
				login_time[$i]=`date | cut -d ' ' -f4` # Record the login time
			fi

		# User is not logged in
		else

			# Check if user recently logged out
			if [ ${login_number[$i]} -gt 0 ]; then
				logout_time[$i]=`date | cut -d ' ' -f4` # Record the logout time

				# Email the user
				echo "Hello ${user_names[$i]}. I see you were logged in at ${login_time[$i]} and logged out \
at ${logout_time[$i]} for a total of ${login_time[$i]} minutes." | mail -s "Gotacha ${user_names[$i]}!" ${user_names[$i]}

				# Reinitialize user's arrays
				login_time[$i]=0
				logout_time[$i]=0
				login_number[$i]=0

			# Otherwise, user has not logged in since script has been running
			fi
		fi
	done

	# Sleep for a minute
	sleep 60
done
