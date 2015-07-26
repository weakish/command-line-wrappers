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

def has_avconv?
  system('which', 'avconv')
end

file_names = Dir.glob('*').sort
videos = file_names.join('|')

if has_avconv?
  system 'avconv', '-i', "concat:#{videos}", output_file_name
else
  puts 'avconv is unavailable.'
end
