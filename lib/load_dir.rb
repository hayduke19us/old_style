require 'css_parser'
require 'nokogiri'

class LoadDir
  HTML_PATH = File.expand_path('../../app/views', __FILE__)
  CSS_PATH = File.expand_path('../../app/assets/stylesheets', __FILE__)

  include CssParser

  attr_accessor :directories, :files, :css, :html, :html_css

  def initialize(*args)
    @directories = args
    @files = {}
    @css = {}
    @html = {}
    @html_css = {}
    html_directories
    css_directories
  end

  def html_directories
    @directories.each do |dir|
      Dir.foreach(HTML_PATH + "/#{dir}") do |file|
        @files[file] = HTML_PATH + "/#{dir}/#{file}" unless /^\./.match(file)
      end
    end
  end

  def css_directories
    # This method's return hashes' PATH value is different from html_directories.
    # It only includes the directory because the css parser requires
    # an argument of file, base_directory, media_type
    # The path can't include the file
    @directories.each do |dir|
      Dir.foreach(CSS_PATH + "/#{dir}") do |file|
        @files[file] = CSS_PATH + "/#{dir}" unless /^\./.match(file)
      end
    end
  end

  def css?(file)
    true if /\.css\S*\z/.match(file)
  end

  def html?(file)
    true if/\.html\S*\z/.match(file)
  end

  def segregate
    self.files.each do |file, path|
      if self.css?(file)
        self.css[file] = path
      elsif self.html?(file)
        self.html[file] = path
      end
    end
  end

  def parse_css
    tmp = []
    self.css.each do |file, path|
      parser = CssParser::Parser.new
      parser.load_file!(file, path, :all)
      parser.each_selector(:all) do |selector, dec, spec|
        tmp << selector unless /^\//.match(selector)
      end
    end
    tmp
  end

  def parse_html
    #call segregate first
    self.html.each_value do |path|
      self.html_css[Nokogiri::HTML(open(path))] = self.parse_css
    end
  end

  def found_css
    tmp = []
    self.html_css.each do |k,v|
      v.each {|sel| tmp << sel unless k.css(sel).empty?}
    end
  end

  def empty_css
    tmp = []
    self.html_css.each do |k,v|
      v.each {|sel| tmp << sel if k.css(sel).empty?}
    end
  end
end


