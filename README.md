#   ffmpeg tool for watermark and text copyright

##  What is it?
This script add watermark and copyright to your video with fade effect


* Version 1.0 2017.03.09


### How to install? ###

### How to run ?
Change the value in file `ff_mw_cr.sh` :
```
ENCODED_DIR='./encoded' # where save encoded files
WATERMARK_IMAGE='watermark.png' # png image with alpha layer and your logo
COPYRIGHT_TEXT='\:copyright\: 2011-2017. Licensed and Authorized for Use Only by ...'
FONT=/usr/share/fonts/truetype/liberation/LiberationSerif-Regular.ttf
EFFECT_SECONDS_BEFORE_END=2 # finish effect before end ( in seconds )
EFFECT_SECONDS_AFTER_BEGIN=3 # start effect after start ( in seconds )
FID=2 # fade in duration
FOD=2 # fade out duration
```
Run script:
```
./ff_mw_cr.sh my_file.mp4
```

  Licensing
  ---------
	GNU

  Contacts
  --------

     o korolev-ia [at] yandex.ru
     o http://www.unixpin.com

