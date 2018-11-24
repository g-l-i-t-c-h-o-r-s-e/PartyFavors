#The 'random' video filter usually does not seem to work with a duration less than 1.7
#I used 'bc' to do math because it supports floating points. Use 'expr' instead if you're using integers.
#Change "for i in `seq 1 10`" to something like "for i in `seq 1 50`" if you want to render more than 10 videos.
#Make sure you have more video and audio filters than the amount of times you loop, otherwise "${array1[$i]}" will be empty.
#For example if you loop 20 times with "for i in `seq 1 20`" then make 20 lines of filters in videofilters.txt & audiofilters.txt.
#I'm using the nut format due to its compatibility with almost every ffmpeg codec and its overall performance compared to avi.

 IFS=$'\r\n' GLOBIGNORE='*' command eval 'array1=($(cat videofilters.txt))'
 IFS=$'\r\n' GLOBIGNORE='*' command eval 'array2=($(cat audiofilters.txt))'
mkdir results ; cd results ; rm *.nut ; cd ../
 newstart=$(bc <<< "$3"+"$4")
 filecount="0000"
 seek="00"
 add="$5"
#Loop starts here
 for i in `seq 1 20`
 do
 filecount=$(bc <<< "$filecount"+0.0001)
zeropad=${filecount#"."}

ffmpeg -ss $seek -i $1 -f nut -s $2 -vcodec huffyuv -acodec pcm_u32le \
-lavfi "[0:v]fifo,trim=start=0:duration=$3[a];[0:v]fifo,trim=start=$3:duration=$4,setpts=PTS-STARTPTS[b];[b]${array1[$i]}[c];[a][c]concat[d];[0:v]trim=start=$newstart:duration=0,setpts=PTS-STARTPTS[e];[d][e]concat[out]" \
-lavfi "[0:a]afifo,atrim=start=0:duration=$3[a];[0:a]afifo,atrim=start=$3:duration=$4,asetpts=PTS-STARTPTS[b];[b]${array2[$i]}[c];[a][c]concat=v=0:a=1[d];[0:a]atrim=start=$newstart:duration=0,asetpts=PTS-STARTPTS[e];[d][e]concat=v=0:a=1[out2]"  \
-map "[out]" -map "[out2]" -t $add - | ffmpeg -i - -f nut -c:v huffyuv -c:a pcm_u32le -y ./results/out_$zeropad.nut
#Do the math after each ffmpeg process so that -ss starts with 00
seek=$(bc <<< $seek+$add) ; done
 
if [[ ${1} =~ ("-h"|"-help") ]]; then
  clear
  echo "           Behold my shittiest help file"
  echo "INPUT RESOLUTION SKIP-SECONDS FILTER-DURATION SECOND-INTERVAL"
  echo "     ./FilterBatch3.0.sh input.avi 640x360 2 2 5"
else
cd ./results
 rm ieatass.txt
 wait
  for f in ./*.nut; do echo "file '$f'" >> ieatass.txt; done
  ffmpeg -f concat -safe 0 -i ieatass.txt -codec copy -y KMS.nut
 ffplay KMS.nut -af volume=0.1 ; fi
