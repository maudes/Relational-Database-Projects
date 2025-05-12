#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != winner ]]
  then   
  TEAM_ID=$($PSQL "SELECT name FROM teams WHERE name='$WINNER';")
#if not found
  if [[ -z $TEAM_ID ]]
  then 
#insert team_id
  INSERT_TEAM_W=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
  fi
#get new team_id 
  TEAM_ID=$($PSQL "SELECT name FROM teams WHERE name='$WINNER';")
  fi

  if [[ $OPPONENT != opponent ]]
  then 
#get team_id  
  TEAM_ID=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT';")
#if not found
  if [[ -z $TEAM_ID ]]
  then
#insert team_id
  INSERT_TEAM_O=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
  fi
#get new team_id 
  TEAM_ID=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT';")
  fi

#get games table
  if [[ $YEAR != year ]]
  then
     #get team_id for winner and opponent
	  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")

     #insert game
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR,'$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
      if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into games, $YEAR $ROUND"
      fi
  fi

done