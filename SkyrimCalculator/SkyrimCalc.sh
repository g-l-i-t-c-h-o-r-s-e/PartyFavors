#./SkyrimCalc.sh 26280
#3 human minutes = 1 hour in Skyrim.
val=$(bc <<< "$1"/3)
val2=$(bc <<< "$1"/60)
echo "
\"$1\" human minutes Divided by \"3\" Equals \"$val\" Skyrim Hours."
echo "Which also equals \"$val2\" human hours.
"
