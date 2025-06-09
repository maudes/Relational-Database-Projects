#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

CHECK_TABLE(){
  # If empty value
  if [[ -z $1 ]] 
  then
    echo "Please provide an element as an argument."

  else # If with values, then get the arrays of values (for later use)
    # Check if it's a number (avoid data type conflict)
    if [[ $1 =~ ^[0-9]+$ ]]
    then # Check if it's in the atomic_number column
    ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
    else # If it's not a number, check if it's in the name or symbol columns
    ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1' OR symbol = '$1';")
    fi

    # Check if we have the array of elements > whether the input is valid
    # INVALID input = no elements in the array
    if [[ -z $ELEMENT ]]
    then 
    echo "I could not find that element in the database."
    # VALID input = array with elemets
    else
    # the while read VAR BAR VAR BAR is now working; so use IFS = "|"
    echo "$ELEMENT" | while IFS="|" read TYPEID ATONUM MASS MP BP SYM NAME TYPE
      do
      echo "The element with atomic number $ATONUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
      done
    fi
  fi 

}

# Call with a parameter (Otherwise, it'll always show no parameter response)
CHECK_TABLE "$1"
