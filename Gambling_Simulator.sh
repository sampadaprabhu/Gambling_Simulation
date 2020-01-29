#!/bin/bash
echo "Welcome To Gambler Simulator"
declare -A GamblerDictionary

#Functions
Percentage()
{
	percentage=$(( $STAKE_OF_EVERY_DAY * 50 / 100 ))
	Minimum_percentage=$(( $STAKE_OF_EVERY_DAY - $percentage ))
	Maximum_percentage=$(( $STAKE_OF_EVERY_DAY + $percentage ))
}
WinOrLoose()
{
	if (( $Cash > 100 ))
	then
		Win=$(( $Win + 50 ))
	else
		Loss=$(( $Loss + 50 ))
	fi	
}
GamblerSimulation()
{
	for (( i=1; i<=20; i++ ))
	do
		Cash=$STAKE_OF_EVERY_DAY
		Percentage
		while (( $Cash > Minimum_percentage && $Cash < $Maximum_percentage ))
		do
			if ((RANDOM%2 == 0))
			then
				Cash=$(( $Cash + $BET_OF_EVERY_GAME ))
			else
				Cash=$(( $Cash - $BET_OF_EVERY_GAME ))
			fi
		done
		WinOrLoose
		GamblerDictionary[$i]=$(( $Cash - $STAKE_OF_EVERY_DAY ))
	done
	
}
LuckyAndUnluckyDay()
{
	DayWiseAddition
	Lucky_Amount=${GamblerDictionary[1]}
	Lucky_Day=1
	Unlucky_Amount=${GamblerDictionary[1]}
	Unlucky_Day=1
	for (( i=1; i<=20; i++ ))
	do
		if (( ${GamblerDictionary[$i]} > $Lucky_Amount ))
		then
			Lucky_Amount=${GamblerDictionary[$i]}
			Lucky_Day=$i
		elif (( ${GamblerDictionary[$i]} < $Unlucky_Amount ))
		then
			Unlucky_Amount=${GamblerDictionary[$i]}
			Unlucky_Day=$i
		fi
	done
	echo "Luckiest Day Of Gambler is $Lucky_Day And the Amount is $Lucky_Amount"
	echo "Unluckiest Day Of Gambler is $Unlucky_Day And the Amount is $Unlucky_Amount"
}

DayWiseAddition()
{
	for (( i=2;i<=20;i++ ))
	do
		GamblerDictionary[$i]=$(( ${GamblerDictionary[$i]} + ${GamblerDictionary[$((i-1))]} ))
	done
	echo "Days "${!GamblerDictionary[@]}
	echo "cash " ${GamblerDictionary[@]}
}


#Declaring Constant Variables
STAKE_OF_EVERY_DAY=100
BET_OF_EVERY_GAME=1

#Variables
Win=0
Loss=0

GamblerSimulation
LuckyAndUnluckyDay

while (( ${GamblerDictionary[20]} > 0 ))
do
	echo 
	GamblerDictionary=( )
	GamblerSimulation
	LuckyAndUnluckyDay
done
echo
echo "Sorry You Can't Play this month..Because you haven't enough cash!!"
