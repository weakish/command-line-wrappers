#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

# by Jakukyo Friel <weakish@gmail.com>
# under MIT.

# Combine videos into one.
# Note: you need a recent version of avconv/ffmpeg/mkvmerge.
# Usage:
#     cd /path/to/videos && cat-videos Output_file_name
# The directory should only contains video files you want to combine,
# and in proper order.
#
# Tested under ruby 1.9.3p484.
#
# Reference
#
# - [Stackoverflow: FFmpeg has three concat methods](http://stackoverflow.com/a/11175851)
# - [FFmpeg wiki: Concatenating media files](http://trac.ffmpeg.org/wiki/Concatenate#samecodec)
# - [libav FAQ: How can I join video files](https://libav.org/documentation/faq.html#toc-How-can-I-join-video-files_003f)

require 'tempfile'
require 'mimemagic'

File_names = Dir.glob('*').sort
Output_file_name = ARGV.first

# For concat protocol of avconv or ffmpeg
Videos = File_names.join('|')

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


def avconv
  system 'avconv', '-i', "concat:#{Videos}", Output_file_name
end

def ffmpeg_cat_files
  system 'ffmpeg', '-i', "concat:#{Videos}", '-codec', 'copy',
      Output_file_name
end

def mkvmerge
  if not Output_file_name.end_with?('.mkv', 'MKV')
    ext = /\.[A-z0-9]+$/
    if Output_file_name.match(ext)
      output = Output_file_name.sub(ext, '.mkv')
    else
      output = Output_file_name + '.mkv'
    end
  end
  system 'mkvmerge', '-o', output, *File_names
end

def cat_files
  if has_avconv?
    avconv
  elsif has_ffmpeg?
    ffmpeg_cat_files
  elsif has_mkvmerge?
    mkvmerge
  else
    puts 'avconv/ffmpeg/mkvmerge is unavailable.'
  end
end

# A few multimedia containers (MPEG-1, MPEG-2 PS, DV)
# allow to join video files by merely concatenating them.
# PS and DV is much less common than MPEG.
# Thus we only detect MPEG files.
def mpeg?(f)
  if MimeMagic.by_path(f) == 'video/mpeg'
    true
  elsif MimeMagic.by_magic(File.open(f)) == 'video/mpeg'
    true
  else
    false
  end
end

def all_mpeg?
  File_names.all? { |f| mpeg?(f) }
end

def same_type?
  first_file = File_names.first
  mime_ext = MimeMagic.by_path(first_file)
  # We use .all? because by_path is cheaper than by_magic.
  if File_names[1..-1].all? { |f| MimeMagic.by_path(f) == mime_ext }
    true
  else
    mime_magic = MimeMagic.by_magic(File.open(first_file))
    if File_names[1..-1].any? { |f|
      MimeMagic.by_magic(File.open(f)) != mime_magic
    }
      false
    else
      true
    end
  end
end

def generate_list
  video_list = "file '" + File_names.join("'\nfile '") + "'\n"
  list_file = Tempfile.new 'cat-videos', '.'
  list_file.write video_list
  list_file.rewind
  list_file
end

def clean_up_temp_file(f)
  f.close
  f.unlink
end

# For concat demuxer of ffmpeg. avconv does not have this feature yet.
def cat_streams
  list = generate_list
  system 'ffmpeg', '-f', 'concat', '-i', list.path, '-c', 'copy',
      Output_file_name
  clean_up_temp_file(list)
end

def main
  if all_mpeg?
    cat_files
  elsif same_type?
    cat_streams
  else
    mkvmerge
  end
end

main
