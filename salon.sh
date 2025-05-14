#!/bin/bash
#Connect to the database
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

#Function page title
echo -e "\n~~~~~ MY SALON ~~~~~"
#Display message at first
echo -e "\nWelcome to My Salon, how can I help you?\n"

#Prepare the service munu list
SERVICE_MENU(){
  SERVICE_LIST=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")

  echo "$SERVICE_LIST" | while read SERVICE_ID BAR SERVICE_NAME 
    do
      echo -e "$SERVICE_ID) $SERVICE_NAME"
    done
}

#Define the SHOW_MENU function
SHOW_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  #Run the service menu
  SERVICE_MENU
  #Get selected service id from customer
  read SERVICE_ID_SELECTED
  APPOINTMENT_SERVICE
}

APPOINTMENT_SERVICE(){
  SERVICE_ID=$($PSQL "SELECT service_id FROM services;")
  #if invalid input: checking non-numbers input
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    SHOW_MENU "I could not find that service. What would you like today?"

  #if invalid input: checking by service id
  elif [[ $SERVICE_ID_SELECTED != [$SERVICE_ID] ]]
  then
    SHOW_MENU "I could not find that service. What would you like today?"

  #else valid
  else
  #Get the phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #Get customer name from customer table
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
  #Not found: ask for name
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      #Add new customer into customer list
      NEW_CUSTOMER_ADD=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
    fi
  #Found: ask for appointment time
    SERVICE_SELECTED_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
    SERVICE_NAME_FORMATTED=$(echo $SERVICE_SELECTED_NAME | sed -E 's/^ *| *$//g')
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME_FORMATTED?"
    read SERVICE_TIME

  #Once get the time value, write it into the appointment table
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  APPOINMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
  #Closing with confirmation message
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
  fi
}

#Run the SHOW_MENU script
SHOW_MENU

