if [[ $1 =~ ("-help"|"-h") ]];then
echo "
./palettefy.sh red blue red blue 2x2
./palettefy.sh green blue purple black 10x10
./palettefy.sh yellow black red blue 2x2
./palettefy.sh -two blue red 10x10
./palettefy.sh -two blue red 2x2"
else
if [[ $1 =~ ("two"|"-t") ]];then
meme=$(echo 'ffmpeg -f lavfi -i color='$2':s='$4' -f lavfi -i color='$3':s='$4'  -lavfi "[0:v][1:v]vstack" -frames 1 -pix_fmt rgba -f nut -c:v ffvhuff - | ffmpeg -i - -vf palettegen -pix_fmt rgba out.tiff -y | ffmpeg -f v4l2 -framerate 10 -video_size 640x360 -i /dev/video0 -i ./out.tiff  -filter_complex "[1:v]null[ckout];[0:v][ckout]paletteuse=dither=bayer:bayer_scale=5:diff_mode=1:color_search=bruteforce[out]" -map "[out]" -f avi -c:v ffvhuff -q:v 0 - | ffplay - ')
gnome-terminal -x sh -c "${meme}"
else
meme=$(echo 'ffmpeg -f lavfi -i color='$1':s='$5' -f lavfi -i color='$2':s='$5' -f lavfi -i color='$3':s='$5' -f lavfi -i color='$4':s='$5' -lavfi "[0:v][1:v]hstack=inputs=4" -frames 1 -pix_fmt rgba -f nut -c:v ffvhuff - | ffmpeg -i - -vf palettegen -pix_fmt rgba out.tiff -y | ffmpeg -f v4l2 -framerate 10 -video_size 640x360 -i /dev/video0 -i ./out.tiff  -filter_complex "[1:v]null[ckout];[0:v][ckout]paletteuse=dither=bayer:bayer_scale=5:diff_mode=1:color_search=bruteforce[out]" -map "[out]" -f avi -c:v ffvhuff -q:v 0 - | ffplay -')
gnome-terminal -x sh -c "${meme}"
fi ; fi

