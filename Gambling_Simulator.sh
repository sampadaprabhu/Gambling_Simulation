#!/bin/bash
echo "Welcome To Gambler Simulator"

#Declairing Constant Values
STAKE_OF_EVERY_DAY=100
BET_OF_EVERY_GAME=1
Cash=$STAKE_OF_EVERY_DAY
if ((RANDOM%2 == 0))
		then
			echo "Player is Win!!"
				Cash=$(( $Cash + $BET_OF_EVERY_GAME ))
		else
			echo "Player is loss!!"
				Cash=$(( $Cash - $BET_OF_EVERY_GAME ))
		fi
