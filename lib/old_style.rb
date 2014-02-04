$: << File.expand_path('../../lib', __FILE__)
require 'load_dir'
require 'format'

load_dir = LoadDir.new(ARGV)
load_dir.html_directories
load_dir.css_directories
load_dir.segregate
format = Format.new(found: load_dir.found_css, 
                    empty: load_dir.empty_css,
                    directories: load_dir.directories,
                    html_files: load_dir.html,
                    css_files: load_dir.css)
format.write_index
