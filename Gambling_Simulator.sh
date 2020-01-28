#!/bin/bash
echo "Welcome To Gambler Simulator"
declare -A GamblerDictionary
percentage()
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
LuckyAndUnluckyDay()
{
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
#Declairing Constant Values
STAKE_OF_EVERY_DAY=100
BET_OF_EVERY_GAME=1
Win=0
Loss=0
for (( i=1; i<=20; i++ ))
do
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
	WinOrLoose
	GamblerDictionary[$i]=$(( $Cash - $STAKE_OF_EVERY_DAY ))
done
for (( i=2;i<=20;i++ ))
do
	GamblerDictionary[$i]=$(( ${GamblerDictionary[$i]} + ${GamblerDictionary[$((i-1))]} ))
done

echo "Days "${!GamblerDictionary[@]}
echo "cash " ${GamblerDictionary[@]}
LuckyAndUnluckyDay
