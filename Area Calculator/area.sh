#!/bin/bash

#The purpose of this program is to take 2 inputs, width and length, and then calculate the area of a rectangle

#The condition variables below dictate whether the while loops execute.  This allows the program to be ended early by pressing cancel
width_condition=true
length_condition=true
output_unit_condition=true


######################################################################
#This section is about asking the user for inputs (unit, width, length).


unit=$(whiptail --title "Enter The Unit You Want To Give Inputs In" --inputbox "Centimetres = 'cm'  Inches = 'in'" 10 60 3>&1 1>&2 2>&3)
unit_status=$?
if [ $unit_status = 0 ]; then

    echo "Unit Selected"
    #This statement converts text to lowercase, this is to prevent errors from having 'CM' or 'IN' instead of 'cm' 'in'
    unit=$(echo $unit | tr '[:upper:]' '[:lower:]')

else

    #The 'condition=false' statements, are so that if cancel is selected, the following while loops will never start (the program will end early)
    echo "You chose Cancel."
    width_condition=false
    length_condition=false
    output_unit_condition=false

fi



#The '10 60' is the size of the dialogue box, the bit afterwards is for redirecting stdout and stderr 
#(This is because stderr is where the input goes and it needs to be swapped in order to be stored in width)

#While (heh) this condition is true, the dialogue box asking for the width will be created, Regardless of what is done in the loop it will be made false so this segment of code can only occur once.  However it could also never occur if cancel is pressed in the unit section above.

#The same idea is repeated for length
while [ "$width_condition" = true ]

do

    width=$(whiptail --title "Width Input Box" --inputbox "Please Enter A Width For A Rectangle?" 10 60 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then

        echo "The width is:" $width

    else

        #The condition=false statements are to end the program early
        echo "You chose Cancel."
        length_condition=false
        output_unit_condition=false

    fi

#Here, the loop for width is ended
width_condition=false

done



while [ "$length_condition" = true ]

do

length=$(whiptail --title "Length Input Box" --inputbox "Please Enter A Length For A Rectangle?" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then

    echo "The Length is:" $length

else

    echo "You chose Cancel."
    output_unit_condition=false

fi

#This ends the loop
length_condition=false

done


######################################################################
#This section is for calculating the area of the rectangle using the measurements inputted


#Here, the unit that the output is measured in is determined

while [ "$output_unit_condition" = true ]

do

    output_unit=$(whiptail --title "Which unit do you want the area in?" --yes-button "Centimetres" --no-button "Inches" --yesno "Select A Unit" 10 60 3>&1 1>&2 2>&3)
    exitstatus=$?

    #If centimetres is pressed then:
    if [ exitstatus=0 ]; then

        #If the input unit is cm then... do nothing
        if [ $unit="cm" ]; then

            #The colon ':' should do nothing
            :

        else

            length=$(( length / 2.54 ))
            width=$(( width / 2.54 ))

        fi


    #If inches is pressed then:
    else

        #If the input unit is inches then... do nothing
        if [ $unit="in" ]; then

            :

        else

            length=$(( length * 2.54 ))
            width=$(( width * 2.54 ))

        fi
    
    fi

#Ends the loop
output_unit_condition=false

done

#This calculates the area
area=$(( $width * $length ))

echo 'The area of the rectangle is:' $area 