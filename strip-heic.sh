#!/bin/sh

output_filename=`basename $1 .heic`
convert "$1" -strip "$output_filename"
mogrify -resize 50% "$output_filename"
