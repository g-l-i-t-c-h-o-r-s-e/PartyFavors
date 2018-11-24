#get duration
duration=$(ffprobe  -i $1 -show_entries format=duration -v quiet -of csv='p=0')

#do sum maths
size=$(bc -l <<< "$duration"*705)
width=$(bc <<< "$size"/24)
height=1000


#COMMENCE MAGIC
ffmpeg -i $1  -f u8 -ar 44100 -ac 2 - | ffmpeg -f rawvideo -s "$width"x"$height" -pix_fmt rgb24 -i - -y -pix_fmt rgb24 ./test.xwd
ffplay -f u8 -ar 44100 -ac 2 -i ./test.xwd

echo "$width"x"$height"
echo $duration

