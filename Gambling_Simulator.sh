#!/bin/bash
echo "Welcome To Gambler Simulator"

percentage()
{
	percentage=$(( $STAKE_OF_EVERY_DAY * 50 / 100 ))
	Minimum_percentage=$(( $STAKE_OF_EVERY_DAY - $percentage ))
	Maximum_percentage=$(( $STAKE_OF_EVERY_DAY + $percentage ))
}

#Declairing Constant Values
STAKE_OF_EVERY_DAY=100
BET_OF_EVERY_GAME=1
Cash=$STAKE_OF_EVERY_DAY
	percentage
while (( $Cash > Minimum_percentage && $Cash < $Maximum_percentage ))
do
		if ((RANDOM%2 == 0))
		then
			Cash=$(( $Cash + $BET_OF_EVERY_GAME ))
		else
			Cash=$(( $Cash - $BET_OF_EVERY_GAME ))
		fi
done
echo "Total Cash is : $Cash"
