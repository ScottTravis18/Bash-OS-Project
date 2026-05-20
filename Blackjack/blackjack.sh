#!/bin/bash

#This array contains every card inside the deck, it will get smaller as the game progresses and be reset as a new game begins

deck=("AH" "2H" "3H" "4H" "5H" "6H" "7H" "8H" "9H" "10H" "JH" "QH" "KH" "AD" "2D" "3D" "4D" "5D" "6D" "7D" "8D" "9D" "10D" "JD" "QD" "KD" "AS" "2S" "3S" "4S" "5S" "6S" "7S" "8S" "9S" "10S" "JS" "QS" "KS" "AC" "2C" "3C" "4C" "5C" "6C" "7C" "8C" "9C" "10C" "JC" "QC" "KC")

#Player and dealer card arrays, contains the cards the player and dealer have been dealt
#https://stackoverflow.com/a/53018127

declare -a player=()
declare -a dealer=()

############################################################ FUNCTIONS #####################################################


deal() {

    #Im creating a reference to the array name that is a parameter, it works better this way for some reason
    #https://devdocs.io/bash/shell-parameters (Use Ctrl + F and search 'nameref' when on webpage)
    local -n hand=$1


    #num_cards stores the current number of cards in the deck array
    #https://gist.github.com/magnetikonline/0ca47c893de6a380c87e4bdad6ae5cf7 - Cheatsheet for bash arrays
    num_cards="${#deck[@]}"



    #https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function
    #number variable stores a randomly generated number that ranges from position 0 to N-1, where N=number of cards in deck
    number=$(( $RANDOM % $num_cards ))


    #This stores an item from the array (at index position determined in previous line), in a variable
    card=${deck[number]}

    #TESTING
    #echo "This is the card to be dealt "$card


    #Now the card will be added to the array for either player cards or dealer cards

    #The reference to the array is used here, and the link is here again: https://devdocs.io/bash/shell-parameters
    #Another link: https://gist.github.com/magnetikonline/0ca47c893de6a380c87e4bdad6ae5cf7 - Cheatsheet for bash arrays
    hand+=($card)


    #This remove the card from the deck, as it has been dealt: https://devdocs.io/bash/arrays
    unset deck[number]
    #This next line should get rid of the gaps left by removing the card
    deck=("${deck[@]}")

}


dealer_choice() {

    dealer_card_num="${#dealer[@]}"

    

    if [ $dealer_card_num -lt 1 ]; then

        echo 'dealer +2'
        deal dealer
        deal dealer

    
    elif [  ]


    fi


}





#Example for using deal function: deal player
########################################################################################################################################################################

#This is where the program execution will begin
while true;

do

    echo 'Welcome to Blackjack!!!'
    echo "Press a key to select your actions: Q=Quit H=Hit S=Stand"


    # https://linuxize.com/post/bash-read/ - Reading characters
    
    #This checks for key presses
    read -r -n 1 key

    #The switch statement checks for different key presses, each one is a different action

    case "$key" in

        #Pressing Q quits the game
        q|Q)
            
            echo -e "\nQuitting Game"
            break

            ;;

        h|H)

            #The following 2 statements check how many cards are in player/dealer hands
            player_card_num="${#player[@]}"
            dealer_card_num="${#dealer[@]}"
            
            echo -e '\nDealing cards...'

            #add if statement so it only adds 2 cards on the first go, every other go it adds 1 card each
            #Dealing 2 cards each for player and dealer

            if [ $player_card_num -lt 1 ]; then
                echo '2 cards for player'
                deal player
                deal player

            else

                echo '1 card for player'
                deal player
               

            fi

            #PUT DEALER_CHOICE function here ish

            if [ $dealer_card_num -lt 1 ]; then

                echo 'dealer +2'
                deal dealer
                deal dealer


            elif [  ]

                echo 'dealer +1'
                deal dealer


            fi

            player_card_num="${#player[@]}"
            dealer_card_num="${#dealer[@]}"
            

            dealer_cards=()

            for (( i=1; i<$dealer_card_num; i++ )); do

                dealer_cards+=("${dealer[i]}")

            done

            echo "The cards the dealer has are: X" "${dealer_cards[@]}"

            echo "The cards you have are: ""${player[@]}"


            ;;


        *)
            echo 'Press One of The Available Options: Q, H, S'
            ;;
    esac


done