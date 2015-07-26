#!/bin/sh
# by Jakukyo Friel <weakish@gmail.com>, under Apache License v2.

# Combine videos into one.
# Note: you need a recent version of ffmpeg, see http://ffmpeg.org/download.htm
# Usage:
#     cd /path/to/videos && cat-videos output_file_name
# The directory should only contains video files you want to combine, and in the proper order.

for f in *; do
  echo "file '$f'" >> VIDEO_LIST;
done
ffmpeg -f concat -i VIDEO_LIST -c copy $1
rm VIDEO_LIST
