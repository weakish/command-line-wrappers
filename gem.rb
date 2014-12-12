#!/usr/bin/env ruby

require_relative 'carpark'

gem = '/usr/bin/gem'

if ARGV[0] == 'install'
	system gem, 'install', '--minimal-deps', '--user-install', *ARGV.cdr
else
	system gem, *ARGV
end





























