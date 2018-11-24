#Remove "-frames 40" or edit if you want longer output.
if [[ $1 =~ ("-help"|"-h") ]];then
clear
echo "##Batch ImageMagick Format Bending And Colorspace Glitch Script##
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

 A GENEROUS LIST OF COMBINATIONS; THE REST IS UP TO YOU

./batchex-conv.sh dds tiff input.avi 3000 330000 HSL HCL None <---
./batchex-conv.sh pdfa tiff /dev/video0 23 23 HSB None
./batchex-conv.sh pdfa tiff /dev/video0 23 23 HSB XYZ None
./batchex-conv.sh pdfa tiff /dev/video0 23 23 XYZ HSB None
./batchex-conv.sh pdfa png /dev/video0 23 23 HSB XYZ None
./batchex-conv.sh pdfa tiff /dev/video0 23 23 HCL OHTA None
./batchex-conv.sh pdf tiff /dev/video0 23 24 XYZ HWB None = moody purple
./batchex-conv.sh pdf tiff /dev/video0 23 24 XYZ HCL None = blood red
./batchex-conv.sh pdf tiff /dev/video0 23 24 XYZ HSI None
./batchex-conv.sh pdf tiff /dev/video0 23 24 Lab HCLp None
./batchex-conv.sh pdf tiff /dev/video0 23 24 Lab HSI None = negated greens
./batchex-conv.sh pdf jpg input.mp4  23 28 LAB HSI None
./batchex-conv.sh psb tiff /dev/video0 B0 BLAB HSI None
./batchex-conv.sh psb tiff /dev/video0 44 44 LAB HSI None
./batchex-conv.sh psb tiff /dev/video0 44 44 LAB HWB None
./batchex-conv.sh psb tiff /dev/video0 1200 21000000 LAB HWB None
./batchex-conv.sh psb tiff /dev/video0 1011 101000 XYZ xyY None
./batchex-conv.sh psb tiff /dev/video0 88 8700 XYZ XYZ RunlengthEncoded
./batchex-conv.sh psb tiff /dev/video0 1511 121100 HWB HCL Zip
./batchex-conv.sh psb tiff /dev/video0 1811 151100 HCL HWB Group4
./batchex-conv.sh psb tiff /dev/video0 1811 151100 XYZ xyY Group4 = suttle yellow twins
./batchex-conv.sh psb tiff /dev/video0 1811 151100 OHTA OHTA Group4
./batchex-conv.sh psb tiff /dev/video0 1811 151100 YDbDr YDbDr Group4
./batchex-conv.sh dds tiff /dev/video0 11 99 HCL HSB None
./batchex-conv.sh dds tiff /dev/video0 11 1100 Luv HSB None
./batchex-conv.sh pdf tiff /dev/video0 23 23 xyY HCL None = haunted shades
./batchex-conv.sh pdf tiff /dev/video0 23 23 CMY HCL None
./batchex-conv.sh pdf tiff /dev/video0 23 29 RGB RGB None

#Dont forget to use: convert -list colorspace // convert -list format

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
"
else
mkdir $1
mkdir ./$1/$1-hex
mkdir ./$1/$1-hex/$1-conv
 ffmpeg -i $3 -f image2 -q:v 0 -y -frames 40 -s 640x360 framed%01d.$2
  for k in *.$2; do convert $k -colorspace $6 -compress $8 ./$1/"${k%}.$1" ; done
   cd $1
  for m in *.$1; do chexr $m $4 $5 ./$1-hex/"${m%}" ; done
   cd $1-hex
  for s in *.$1; do convert -colorspace $7 $s ./$1-conv/"${s%}.$2" ; done
 ffmpeg -f image2 -pattern_type glob_sequence -i ./$1-conv/framed%01d.$2.$1.$2 -f avi -c:v huffyuv -y $1-hax.avi
 ffplay -loop 9001 -i $1-hax.avi -fs
cd ../
cd ../
rm *.$2
rm ./$1/*.$1
rm ./$1/$1-hex/*.$1
rm ./$1/$1-hex/$1-conv/*.$2	
rm ./$1/$1-hex/$1-hax.avi ; fi




