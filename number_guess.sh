#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

START_GAME(){
	# Pick the secret number
	SECRET_NUM=$((RANDOM % 1000 + 1))  
	echo "Enter your username:"
	read USERNAME
	TOTAL_GUESS_NUM=0
	
	# Check if the username exists in the database
	TUN=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME';")
	TUSER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")  
	
	# If the username is not in the table
	if [[ -z $TUN ]]
	then
		echo "Welcome, $USERNAME! It looks like this is your first time here."
		# Insert new user to the table & create game_id for the user
		INSERT_NEW_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
		TUSER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")
		TUN=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME';")
		CREATE_GID=$($PSQL "INSERT INTO game(user_id) VALUES($TUSER_ID);")
		NEW_GID=$($PSQL "SELECT MAX(game_id) FROM game WHERE user_id = $TUSER_ID;")
		GUESS_GAME "Guess the secret number between 1 and 1000:"
	
	# If the username exists in the table
	else

		# Get the total games played and the least guess_num of one game
 		GAMES_PLAYED=$($PSQL "SELECT COUNT(game_id) FROM game WHERE user_id = $TUSER_ID;") 
		BEST_GAME=$($PSQL "SELECT MIN(guess_num) FROM game WHERE user_id =$TUSER_ID;") 
		echo Welcome back, $TUN! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
		# Create game_id for the user
		CREATE_GID=$($PSQL "INSERT INTO game(user_id) VALUES($TUSER_ID);")
		NEW_GID=$($PSQL "SELECT MAX(game_id) FROM game WHERE user_id = $TUSER_ID;")
		GUESS_GAME "Guess the secret number between 1 and 1000:"
  fi
}

GUESS_GAME(){
	((TOTAL_GUESS_NUM++))
	if [[ $1 ]]
	then 
		echo "$1"
	fi
	read GNUM
	CHECK_NUM
}

CHECK_NUM(){			
	# If the guess number is not a number 
	if ! [[ $GNUM =~ ^[0-9]+$ ]]
	then
		GUESS_GAME "That is not an integer, guess again:"
	
	# If the guess number is higher than the secret number
	elif [[ $GNUM -gt $SECRET_NUM ]]
	then
		GUESS_GAME "It's lower than that, guess again:"
	
	# If the guess number is lower than the secret number
	elif [[ $GNUM -lt $SECRET_NUM ]]
	then
		GUESS_GAME "It's higher than that, guess again:"
	
	# Guess the secret number -eq scenario
	else  
		INSERT_TOTAL_GNUM=$($PSQL "UPDATE game SET guess_num = $TOTAL_GUESS_NUM WHERE game_id = $NEW_GID;")
		echo You guessed it in $TOTAL_GUESS_NUM tries. The secret number was $SECRET_NUM. Nice job!
	fi
}

# Run the script
START_GAME
