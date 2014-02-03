$: << File.expand_path('../../lib', __FILE__)
require 'load_dir'
require 'format'

load_dir = LoadDir.new(ARGV)
load_dir.segregate
format = Format.new(found: load_dir.found_css, empty: load_dir.empty_css)
format.write_index
