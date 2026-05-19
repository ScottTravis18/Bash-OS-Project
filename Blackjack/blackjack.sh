#!/bin/bash

#This array contains every card inside the deck, it will get smaller as the game progresses and be reset as a new game begins

deck=("AH" "2H" "3H" "4H" "5H" "6H" "7H" "8H" "9H" "10H" "JH" "QH" "KH" "AD" "2D" "3D" "4D" "5D" "6D" "7D" "8D" "9D" "10D" "JD" "QD" "KD" "AS" "2S" "3S" "4S" "5S" "6S" "7S" "8S" "9S" "10S" "JS" "QS" "KS" "AC" "2C" "3C" "4C" "5C" "6C" "7C" "8C" "9C" "10C" "JC" "QC" "KC")

#Player and dealer card arrays, contains the cards the player and dealer have been dealt
#https://stackoverflow.com/a/53018127

# Source - https://stackoverflow.com/a/53018127
# Posted by tmt, modified by community. See post 'Timeline' for change history
# Retrieved 2026-05-19, License - CC BY-SA 4.0

declare -a player=()
declare -a dealer=()



#I will be generating random numbers using $RANDOM
#number=$(( $RANDOM % N )) will allow me to generate a number between 0 and N-1
#https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function


############################################################
#The following function random and it being called 'random 52' is just for testing
random() {

    number=$(( $RANDOM % $1 ))
    echo $number

}
#random 52
############################################################

deal() {

    #num_cards stores the current number of cards in the deck array
    num_cards="${#deck[@]}"

    #number variable stores a randomly generated number that ranges from position 0 to N-1, where N=number of cards in deck
    number=$(( $RANDOM % $num_cards ))

    #This stores an item from the array (at index position determined in previous line), in a variable
    card=${deck[number]}
    echo "This is the card to be dealt "$card

    #Now the card will be added to the array for either player cards or dealer cards

    player+=($card)

}

deal