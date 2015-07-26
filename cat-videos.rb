#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

# by Jakukyo Friel <weakish@gmail.com>
# under MIT.

# Combine videos into one.
# Note: you need a recent version of avconv.
# Usage:
#     cd /path/to/videos && cat-videos output_file_name
# The directory should only contains video files you want to combine,
# and in proper order.
#
# Tested under ruby 1.9.3p484.


output_file_name = ARGV.first

def has_cmd?
  systemh('which', cmd)
end

def has_avconv?
  has_cmd?('avconv')
end

def has_ffmpeg?
  has_cmd?('ffmpeg')
end

def has_mkvmerge?
  has_cmd?('mkvmerge')
end

file_names = Dir.glob('*').sort
videos = file_names.join('|')

if has_avconv?
  system 'avconv', '-i', "concat:#{videos}", '-codec', 'copy', output_file_name
elsif has_ffmpeg?
  system 'ffmpeg', '-i', "concat:#{videos}", '-codec', 'copy', output_file_name
elsif has_mkvmerge?
  if not output_file_name.end_with?('.mkv', 'MKV')
    ext = /\.[A-z0-9]+$/
    if output_file_name.match(ext)
      output_file_name.sub! ext, '.mkv'
    else
      output_file_name += '.mkv'
    end
  end
  system 'mkvmerge', '-o', output_file_name, *file_names
else
  puts 'avconv/ffmpeg/mkvmerge is unavailable.'
end
