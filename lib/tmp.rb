require 'css_parser'
require 'nokogiri'
include CssParser

parser = CssParser::Parser.new
parser.load_file!('test.css', Dir.pwd, :all)
sel_arr = []
parser.each_selector(:all) do |selector, dec, spec|
  sel_arr << selector unless /\A\//.match(selector)
end

doc = Nokogiri::HTML::Document.new
doc = doc.parse(open(Dir.pwd + '/test.html.erb'))
#doc = Nokogiri::HTML(open(Dir.pwd + '/test.html.erb'))
puts " =-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-"
array = []
other = []
sel_arr.each {|sel| array << sel if doc.css(sel).empty?}

sel_arr.each {|sel| other << sel unless doc.css(sel).empty?}

puts sel_arr.count
puts array.count
puts other.count


