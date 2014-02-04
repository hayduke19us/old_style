require 'css_parser'
require 'nokogiri'

class LoadDir
  HTML_PATH = File.expand_path(Dir.pwd + '/app/views')
  CSS_PATH = File.expand_path(Dir.pwd + '/app/assets/stylesheets')

  include CssParser

  attr_accessor :directories, :files, :css, :html

  def initialize(*args)
    @directories = args.flatten
    @files = {}
    @css = {}
    @html = {}
    @html_css = {}
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
    Dir.foreach(CSS_PATH) do |file|
      if file =~ /#{@directories.each {|dir| dir}}/
        @files[file] = CSS_PATH
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

  def parse_html
    #call segregate first
    self.html.inject([]) do |array, path|
      array << Nokogiri::HTML(open(path.last))
    end
  end

  def parse_css
    hash = {}
    self.css.each do |file, path|
      parser = CssParser::Parser.new
      parser.load_file!(file, path, :all)
      parser.each_selector(:all) do |selector, dec, spec|
        unless /(^\/|\$|@)/.match(selector)
          hash[selector] = dec 
        end
      end
    end
    hash
  end

  def found_css
    tmp = {}
    self.parse_html.each do |doc|
      self.parse_css.each {|sel, des| tmp[sel] = des unless doc.css(sel).empty?}
    end
    tmp
  end

  def empty_css
    hash = {}
    empty = self.parse_css.flatten - self.found_css.flatten
    empty = empty.each_slice(2).to_a
    empty.each {|sel| sel.each{hash[sel.first] = sel.last}}
    hash
  end
end


