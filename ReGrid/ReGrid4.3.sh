#./ReGrid4.3.sh 3 0.08 100x100 input.avi 640x360 -tr
#./ReGrid4.3.sh 30 0.02 50x50 file:///home/pandela/Videos/Dig.mp4 1280x720 -br -f
delay=0.00
filter=""
bl=`expr $1 + 1`
br=$(bc <<< $1*2+1)
pre="nullsrc=d=0.0001:s=$5,lutrgb=0[null];[0:v]scale=$5,setsar=1/1[v];
[null][v]concat[in1];[in1]scale=$3,split=outputs="
  for i in `seq 1 $1`;do
   delay=$(bc <<< "$delay"+$2)
   c=$(bc <<< "$i"+$1)
   #c=`expr $i + 1`
  eval "Var$i=$delay"
#if [[ ${i} = "1" ]];then
# filter="[$i]vflip[$i]; \\"
#  echo ${filter} >> 2.meme
#   filter2=$(eval "echo [$c]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$c]';' '\'")
#  echo ${filter2} >> 3.meme 
# Outputs+="[$i]"
#Outputs2+="[$c]" ;else
if [[ ${6} =~ ("-u"|"-up") ]]; then
 bl=$(bc <<< $bl-1)
  filter=$(eval "echo [$bl]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$bl]';' '\'")
   echo $filter >> 2.meme
   filter2=$(eval "echo [$c]null[$c]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-d"|"-down") ]]; then
 filter=$(eval "echo [$i]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$i]';' '\'")
  echo $filter >> 2.meme
   filter2=$(eval "echo [$c]null[$c]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-l"|"-left") ]]; then
 filter=$(eval "echo [$i]null[$i]';' '\'")
  echo $filter >> 2.meme
   filter2=$(eval "echo [$c]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$c]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-r"|"-right") ]]; then
 bl=$(bc <<< $bl-1)
  br=$(bc <<< $br-1)
   filter=$(eval "echo [$bl]null[$bl]';' '\'")
    echo $filter >> 2.meme
   filter2=$(eval "echo [$br]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$br]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-br"|"-bottomright") ]]; then
 bl=$(bc <<< $bl-1)
  br=$(bc <<< $br-1)
   filter=$(eval "echo [$bl]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$bl]';' '\'")
    echo $filter >> 2.meme
   filter2=$(eval "echo [$br]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$br]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-bl"|"-bottomleft") ]]; then
 bl=$(bc <<< $bl-1)
  filter=$(eval "echo [$bl]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$bl]';' '\'")
   echo $filter >> 2.meme
   filter2=$(eval "echo [$c]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$c]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
if [[ ${6} =~ ("-tr"|"-topright") ]]; then
 br=$(bc <<< $br-1)
  filter=$(eval "echo [$i]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$i]';' '\'")
   echo $filter >> 2.meme
   filter2=$(eval "echo [$br]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$br]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
else
#Filter Chain Generation Starts here if $6 isnt specified, grid starts from topleft by default.
filter=$(eval "echo [$i]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$i]';' '\'")
 echo ${filter} >> 2.meme
  filter2=$(eval "echo [$c]setpts=''\'if'('eq'('N,0'),PTS,PTS+0'\$Var$i'/TB)'\'[$c]';' '\'")
  echo ${filter2} >> 3.meme 
 Outputs+="[$i]"
Outputs2+="[$c]"
fi ;fi ;fi ;fi ;fi ;fi ;fi
#fi;
done

if [[ ${6} =~ ("-u"|"-d"|"-l"|"-r") ]]; then
pre="nullsrc=d=0$Var1:s=$5,lutrgb=0[null]; \\
[0:v]scale=$5,setsar=1/1[v];[null][v]concat[in1];[in1]scale='$3',setsar=1/1,split=outputs="
echo "#./ReGrid4.3.sh $1 $2 $3 $4 $5 $6" >> 1.meme
echo "ffmpeg -ss 00:00:00 -i '$4' -lavfi \\
\"$pre"$1""$Outputs"; "  >> 1.meme
 cat 2.meme >> 1.meme
echo "$Outputs""vstack=inputs=$1[a];[a]split=outputs="$1"$Outputs2; "\\ >> 1.meme
 cat 3.meme >> 1.meme
 echo "$Outputs2""hstack=inputs=$1,scale=$5,setsar=1/1[b]; "\\ >> 1.meme
echo "aevalsrc=0:d=0$Var2[silence];[silence][0:a]concat=v=0:a=1[c]; \\
[b]trim=start=0$Var2:duration=0[out];[c]atrim=start=0$Var2:duration=0[out2]\" \\
-map \"[out]\" -map \"[out2]\" -f nut -c:v mjpeg -c:a pcm_u8 -q:v 0 -s $5  testme.nut" >> 1.meme
echo "ffplay -i testme.nut -af volume=0.05" >> 1.meme
 mv 1.meme ReGrid.sh
 chmod +x ReGrid.sh
 rm 2.meme
rm 3.meme
./ReGrid.sh
else

echo "#./ReGrid4.3.sh $1 $2 $3 $4 $5 $6" >> 1.meme
echo "ffmpeg -ss 00:00:00 -i '$4' -lavfi \\
\"$pre"$1""$Outputs"; "  >> 1.meme
 cat 2.meme >> 1.meme
echo "$Outputs""vstack=inputs=$1[a];[a]split=outputs="$1"$Outputs2; "\\ >> 1.meme
 cat 3.meme >> 1.meme
 echo "$Outputs2""hstack=inputs=$1,scale=$5,setsar=1/1[b]; "\\ >> 1.meme
echo "aevalsrc=0:d=0$Var2[silence];[silence][0:a]concat=v=0:a=1[c]; \\
[b]trim=start=0$Var2:duration=0[out];[c]atrim=start=0$Var2:duration=0[out2]\" \\
-map \"[out]\" -map \"[out2]\" -f nut -c:v mjpeg -c:a pcm_u8 -q:v 0 -s $5  testme.nut" >> 1.meme
echo "ffplay -i testme.nut -af volume=0.05" >> 1.meme

 if [[ ${7} =~ ("-f"|"-flyeye") ]]; then
  file=$(cat 1.meme)
  newline=" -vf lenscorrection=cx=0.5:cy=0.5:k1=-1:k2=0.1"
 echo -e "$file"$(echo "$newline")"" > 1.meme
 mv 1.meme shitballs.sh
 chmod +x shitballs.sh
 rm 2.meme
rm 3.meme
./shitballs.sh
else
if [[ ${7} =~ ("-2f"|"-2flyeye") ]]; then
  file=$(cat 1.meme)
  newline=" -vf lenscorrection=cx=0.5:cy=0.5:k1=-1:k2=1,lenscorrection=cx=0.5:cy=0.5:k1=-1:k2=1"
 echo -e "$file"$(echo "$newline")"" > 1.meme
 mv 1.meme shitballs.sh
 chmod +x shitballs.sh
 rm 2.meme
rm 3.meme
./shitballs.sh
else
 mv 1.meme shitballs.sh
 chmod +x shitballs.sh
 rm 2.meme
rm 3.meme
./shitballs.sh ;fi ;fi ;fi
