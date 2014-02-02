require 'css_parser'
require 'nokogiri'

class LoadDir
  PATH = File.expand_path('../../app', __FILE__)
  include CssParser 
  attr_accessor :directories, :files, :css, :html

  def initialize(*args)
    @directories = args
    @files = []
    @directories.each {|dir| Dir.foreach(PATH + "/#{dir}") {|x| @files << x unless /^\./.match(x)}} 
    @css = []
    @html = []
  end

  def css?(file)
    true if /\.css\S*\z/.match(file)
  end

  def html?(file)
    true if/\.html\S*\z/.match(file)
  end

  def segregate
    self.files.each do |file|
      if self.css?(file)
        self.css << file
      elsif self.html?(file)
        self.html << file
      end
    end
  end

  def parse_css
    tmp = []
    self.css.each do |file|
      parser = CssParser::Parser.new
      parser.load_file!(file, PATH + "/fake", :all)
      parser.each_selector(:all) do |selector, dec, spec|
        tmp << selector unless /^\//.match(selector)
      end
    end
    tmp
  end

  def parse_html
    #call segregate first
    yes = []
    self.html.each do |file|
      doc = Nokogiri::HTML(open(PATH + "/fake/#{file}"))
      self.parse_css.each do |sel|
        unless doc.css(sel).empty?
          doc.css(sel).each {|link| yes << "#{sel}: #{link.content}"}
        end
      end
    end
    yes
  end

end


