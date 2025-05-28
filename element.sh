#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#echo "User Input: $1"

BOT(){
  # USER DOES NOT INPUT ARGUMENT
  if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."

  # IF USER DOES INPUT ARGUMENT
  else 
  # IF THE ARGUMENT IS NUMERIC OR NOT, GET THE ARRAY OF REQUIRED ELEMENTS
    if [[ $1 =~ ^[0-9]+$ ]]
    then 
    ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
    else 
    ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")
    fi 

  # IF THE ARRAY IS EMPTY, INVALID INPUT
    if [[ -z $ELEMENT ]] 
    then
    echo "I could not find that element in the database."   
  # IF THE ARRAY IS NOT EMPTY, VALID INPUT
    else
    echo $ELEMENT | while read TYPEID BAR ATONUM BAR SYM BAR NAME BAR MASS BAR MP BAR BP BAR TYPE
      do
      echo "The element with atomic number $ATONUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
      done
    fi
  fi
}

# Pass the script's first argument ($1) to the BOT function
BOT "$1"