#!/bin/bash
# korolev-ia [] yandex.ru
# 20170309
#
ENCODED_DIR='./encoded'
WATERMARK_IMAGE='watermark.png'
COPYRIGHT_TEXT='\:copyright\: 2011-2017. Licensed and Authorized for Use Only by ...'
FONT=/usr/share/fonts/truetype/liberation/LiberationSerif-Regular.ttf
EFFECT_SECONDS_BEFORE_END=2
EFFECT_SECONDS_AFTER_BEGIN=3
FID=2 # fade in duration
FOD=2 # fade out duration


if [[ "x$1" != "x-f" ]] ; then
	echo "This script add watermark and copyright to your video"
	echo "with fade_in and fade_out effect"
	echo "Encoded file will be save into ./encoded directory"
	echo "Usage:$0 videofile.mp4"
	exit 1
fi	
f=$1

[  -d $ENCODED_DIR ] || mkdir -p $ENCODED_DIR 
if [ ! -f $FONT ] ; then
	echo "Font $FONT do not exist" >&2
	exit 1
fi

DURATION=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f"`
DS=$EFFECT_SECONDS_AFTER_BEGIN  # display start
DE=` bc -l <<< "scale=2;  $DURATION - $EFFECT_SECONDS_BEFORE_END "` # display end
FO_START=` bc -l <<< "scale=2;  $DE - $FOD "` # start fadeout

		
ffmpeg -loglevel warning -y -loop 1 -ss 0 -t $DURATION -i $WATERMARK_IMAGE -i $f \
-filter_complex "[0:v] fade=t=in:st=$DS:d=$FID:alpha=1, \
fade=t=out:st=$FO_START:d=$FOD:alpha=1[a];\
[1:v] drawtext=fontfile=$FONT:text='$COPYRIGHT_TEXT':\
fontcolor=white: alpha='if( between(t\, $DS, $DS+$FID), ( t-$DS )/$FID , \
if( between(t\,$FO_START,$DE), 1-((t-$FO_START)/$FOD) ,1 ) ) ' \
:fontsize=15:boxborderw=5: x=(w-text_w)/2: y=(h-text_h)-30:enable='between(t\,$DS,$DE )'[b]; \
[b][a]overlay=main_w-overlay_w-20:20:enable='between(t\,$DS,$DE )'[v]" -map '1:a?' -map '[v]'  "$ENCODED_DIR/$f"	


exit 0