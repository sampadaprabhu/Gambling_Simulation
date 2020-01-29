#!/bin/bash
echo "Welcome To Gambler Simulator"
declare -A gamblerDictionary

#Functions
percentage()
{
	percent=$(( $STAKE_OF_EVERY_DAY * 50 / 100 ))
	minimumPercentage=$(( $STAKE_OF_EVERY_DAY - $percent ))
	maximumPercentage=$(( $STAKE_OF_EVERY_DAY + $percent ))
}
winOrLoose()
{
	if (( $cash > 100 ))
	then
		win=$(( $win + 50 ))
	else
		loss=$(( $loss + 50 ))
	fi	
}
gamblerSimulation()
{
	for (( i=1; i<=20; i++ ))
	do
		cash=$STAKE_OF_EVERY_DAY
		percentage
		while (( $cash > minimumPercentage && $cash < $maximumPercentage ))
		do
			if ((RANDOM%2 == 0))
			then
				cash=$(( $cash + $BET_OF_EVERY_GAME ))
			else
				cash=$(( $cash - $BET_OF_EVERY_GAME ))
			fi
		done
		winOrLoose
		gamblerDictionary[$i]=$(( $cash - $STAKE_OF_EVERY_DAY ))
	done
	
}
luckyAndUnluckyDay()
{
	dayWiseAddition
	luckyAmount=${gamblerDictionary[1]}
	luckyDay=1
	unluckyAmount=${gamblerDictionary[1]}
	unluckyDay=1
	for (( i=1; i<=20; i++ ))
	do
		if (( ${gamblerDictionary[$i]} > $luckyAmount ))
		then
			luckyAmount=${gamblerDictionary[$i]}
			luckyDay=$i
		elif (( ${gamblerDictionary[$i]} < $unluckyAmount ))
		then
			unluckyAmount=${gamblerDictionary[$i]}
			unluckyDay=$i
		fi
	done
	echo "Luckiest Day Of Gambler is $luckyDay And the Amount is $luckyAmount"
	echo "Unluckiest Day Of Gambler is $unluckyDay And the Amount is $unluckyAmount"
}

dayWiseAddition()
{
	for (( i=2;i<=20;i++ ))
	do
		gamblerDictionary[$i]=$(( ${gamblerDictionary[$i]} + ${gamblerDictionary[$((i-1))]} ))
	done
	echo "Days "${!gamblerDictionary[@]}
	echo "cash " ${gamblerDictionary[@]}
}


#Declaring Constant Variables
STAKE_OF_EVERY_DAY=100
BET_OF_EVERY_GAME=1

#Variables
win=0
loss=0

gamblerSimulation
luckyAndUnluckyDay

while (( ${gamblerDictionary[20]} > 0 ))
do
	echo 
	gamblerDictionary=( )
	gamblerSimulation
	luckyAndUnluckyDay
done
echo
echo "Sorry You Can't Play this month..Because you haven't enough cash!!"
