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
    #https://stackoverflow.com/questions/2264428/how-to-convert-a-string-to-lower-case-in-bash
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
    width_status=$?
    if [ $width_status = 0 ]; then

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
length_status=$?
if [ $length_status = 0 ]; then

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

    output_unit=$(whiptail --title "Which unit do you want the area in?" --yes-button "Metres Squared" --no-button "Inches Squared" --yesno "Select A Unit" 10 60 3>&1 1>&2 2>&3)
    output_unit_status=$?

    #If metres squared is pressed then:
    if [ "$output_unit_status" = 0 ]; then

        output_unit=m^2

        #If the input unit is cm then you need to change unit to metres
        if [ "$unit" = "cm" ]; then

            #Changing the measurements from centimetres to metres          
            length=$(echo "scale=8; $length / 100" | bc)
            width=$(echo "scale=8; $width / 100" | bc)

            echo $length
            echo $width


        #In this scenario, output unit is metres squared but input unit is inches, so we need to change unit as well
        else

            #These next 2 lines convert the measurements in inches to metres
            length=$(echo "scale=8; $length / 100 * 2.54" | bc)
            width=$(echo "scale=8; $width / 100 * 2.54" | bc)

            echo $length
            echo $width

        fi


    #If inches squared is pressed then:
    else

        output_unit=in^2

        #If the input unit is inches then do nothing
        if [ $unit = "in" ]; then

            :

        #If input unit is centimetres, then you have to convert to inches
        else

            length=$(echo "scale=8; $length / 2.54" | bc)
            width=$(echo "scale=8; $width / 2.54" | bc)

        fi
    
    fi

#This calculates the area
area=$(echo "scale=8; $width * $length" | bc)

#Ends the loop
output_unit_condition=false

done

echo 'The area of the rectangle is:' $area $output_unit