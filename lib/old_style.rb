$: << File.expand_path('../../lib', __FILE__)
require 'parse_dir'

parse = ParseDir.new(ARGV)
parse.success?
